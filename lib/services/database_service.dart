import 'dart:async';

import 'package:CharVault/models/character_model.dart';
import 'package:CharVault/models/item_model.dart';
import 'package:CharVault/services/auth_service.dart';
import 'package:CharVault/services/storage_service.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  static final _database = FirebaseDatabase.instance;

  static const String userCollection = "Users";
  static const String charCollection = "Chars";
  static const String itemsCollection = "Items";

  /// Método para salvar dados em uma coleção e retornar a chave única gerada
  static Future<String> saveData(String collection, dynamic value) async {
    if (AuthService.user == null) {
      throw 'Usuário não autenticado';
    }

    await AuthService.reauthenticate();

    var ref = _database.ref(collection);

    var newRef = ref.push(); // Gerando uma nova chave única
    String newKey = newRef.key!; // Obtendo a chave única
    await newRef.set(value); // Adicionando o novo valor com a chave gerada

    return newKey;
  }

  /// Método para adicionar um personagem a um usuário
  static Future<String?> addCharacter(CharacterModel newCharacter) async {
    if (AuthService.user == null) {
      throw 'Usuário não autenticado';
    }

    await AuthService.reauthenticate();

    try {
      String charId = await saveData(
          charCollection,
          newCharacter
              .toMap()); // Salvando o personagem na coleção de personagens

      newCharacter.id = charId;

      await updateCharacter(charId, newCharacter.toMap());

      var userCharsRef = _database.ref(
          '$userCollection/${AuthService.user?.uid}/chars'); // Referência ao nó de personagens do usuário

      await userCharsRef
          .child(charId)
          .set(true); // Adicionando a referência ao personagem no nó do usuário

      return charId; // Confirmação de que foi salvo com sucesso
    } catch (e) {
      throw 'Erro ao salvar o personagem: $e';
    }
  }

  /// Método para deletar um personagem de um usuário
  static Future<void> deleteCharacter(String charId, String charImageId) async {
    if (AuthService.user == null) {
      throw 'Usuário não autenticado';
    }

    await AuthService.reauthenticate();

    try {
      // Referência ao nó de personagens do usuário
      var userCharsRef = _database
          .ref('$userCollection/${AuthService.user?.uid}/chars/$charId');

      // Removendo a referência ao personagem no nó do usuário
      await userCharsRef.remove();

      // Referência ao personagem na coleção de personagens
      var charRef = _database.ref('$charCollection/$charId');

      // Obtém os dados do personagem antes de remover
      var charSnapshot = await charRef.get();
      if (charSnapshot.exists) {
        var charData = charSnapshot.value as Map;

        // Remove todos os itens relacionados ao personagem
        if (charData['items'] != null) {
          var items = charData['items'] as Map;
          for (var itemId in items.keys) {
            var itemRef = _database.ref('$itemsCollection/$itemId');
            await itemRef.remove();
          }
        }
      }

      // Removendo o personagem da coleção de personagens
      await charRef.remove();

      // Removendo a imagem do personagem
      await StorageService.deleteImageById(charImageId);
    } catch (e) {
      throw 'Erro ao deletar o personagem: $e';
    }
  }

  /// Método para ler os dados de um personagem específico
  static Future<CharacterModel?> getCharacter(String charId) async {
    if (AuthService.user == null) {
      throw 'Usuário não autenticado';
    }

    await AuthService.reauthenticate();

    var charRef = _database.ref('$charCollection/$charId');
    DataSnapshot snapshot = await charRef.get();
    return snapshot.exists ? snapshot.value as CharacterModel : null;
  }

  /// Método para atualizar os dados de um personagem específico
  static Future<void> updateCharacter(
      String charId, Map<String, dynamic> updatedData) async {
    if (AuthService.user == null) {
      throw 'Usuário não autenticado';
    }

    await AuthService.reauthenticate();

    var charRef = _database.ref('$charCollection/$charId');
    await charRef.update(updatedData);
  }

  /// Método para obter todos os personagens de um usuário
  static Future<List<CharacterModel>?> getUserCharacters() async {
    if (AuthService.user == null) {
      throw 'Usuário não autenticado';
    }

    await AuthService.reauthenticate();

    try {
      var userCharsRef =
          _database.ref('$userCollection/${AuthService.user?.uid}/chars');

      // Obtém os IDs dos personagens do usuário
      DataSnapshot snapshot = await userCharsRef.get().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('A operação de leitura no Firebase expirou.');
        },
      );

      if (!snapshot.exists) {
        return [];
      }

      List<Future<CharacterModel?>> characterFutures = [];
      for (var charId in snapshot.children) {
        var charSnapshotFuture = _database
            .ref('$charCollection/${charId.key}')
            .get()
            .then((charSnapshot) {
          if (charSnapshot.exists) {
            var characterData = charSnapshot.value as Map<dynamic, dynamic>;
            return CharacterModel.fromMap(characterData);
          }
          return null;
        });
        characterFutures.add(charSnapshotFuture);
      }

      // Espera todas as futuras se resolverem e filtra os nulos
      var characters = (await Future.wait(characterFutures))
          .whereType<CharacterModel>()
          .toList();

      return characters;
    } catch (e) {
      // Captura e lança a exceção com uma mensagem de erro personalizada
      throw "Erro ao buscar personagens: ${e.toString()}";
    }
  }

  static Future<bool> addItemModel(
      String charId, ItemModel newItemModel) async {
    if (AuthService.user == null) {
      throw 'Usuário não autenticado';
    }

    await AuthService.reauthenticate();

    try {
      String newItemModelId =
          await saveData(itemsCollection, newItemModel.toMap());
      newItemModel.id = newItemModelId;
      await updateItemModel(newItemModelId, newItemModel.toMap());
      var userModelsRef = _database.ref('$charCollection/$charId/items');
      await userModelsRef.child(newItemModelId).set(true);
      return true;
    } catch (e) {
      throw 'Erro ao salvar o novo modelo: $e';
    }
  }

  static Future<void> deleteItemModel(
      String charId, String newItemModelId) async {
    if (AuthService.user == null) {
      throw 'Usuário não autenticado';
    }

    await AuthService.reauthenticate();

    var userModelsRef =
        _database.ref('$charCollection/$charId/items/$newItemModelId');
    await userModelsRef.remove();
    var modelRef = _database.ref('$itemsCollection/$newItemModelId');
    await modelRef.remove();
  }

  static Future<ItemModel?> getItemModel(String newItemModelId) async {
    if (AuthService.user == null) {
      throw 'Usuário não autenticado';
    }

    await AuthService.reauthenticate();

    var modelRef = _database.ref('$itemsCollection/$newItemModelId');
    DataSnapshot snapshot = await modelRef.get();
    return snapshot.exists
        ? ItemModel.fromMap(snapshot.value as Map<String, dynamic>)
        : null;
  }

  static Future<void> updateItemModel(
      String newItemModelId, Map<String, dynamic> updatedData) async {
    if (AuthService.user == null) {
      throw 'Usuário não autenticado';
    }

    await AuthService.reauthenticate();

    var modelRef = _database.ref('$itemsCollection/$newItemModelId');
    await modelRef.update(updatedData);
  }

  static Future<List<ItemModel>> getCharItemModels(String charId) async {
    if (AuthService.user == null) {
      throw 'Usuário não autenticado';
    }

    await AuthService.reauthenticate();

    var charModelsRef = _database.ref('$charCollection/$charId/items');
    DataSnapshot snapshot = await charModelsRef.get();
    List<ItemModel> itemModels = [];
    for (var itemModelId in snapshot.children) {
      var modelSnapshot =
          await _database.ref('$itemsCollection/${itemModelId.key}').get();
      if (modelSnapshot.exists) {
        var modelData = modelSnapshot.value as Map<dynamic, dynamic>;
        itemModels.add(ItemModel.fromMap(modelData));
      }
    }
    return itemModels;
  }
}
