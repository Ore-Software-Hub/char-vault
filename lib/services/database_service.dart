import 'dart:async';
import 'package:CharVault/models/character_model.dart';
import 'package:CharVault/models/item_model.dart';
import 'package:CharVault/services/auth_service.dart';
import 'package:CharVault/services/storage_service.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  static final _database = FirebaseDatabase.instance;

  static const String userCollection = "Users";

  /// Método para adicionar um personagem a um usuário
  static Future<String?> addCharacter(CharacterModel newCharacter) async {
    if (AuthService.user == null) {
      throw 'Usuário não autenticado';
    }

    await AuthService.reauthenticate();

    try {
      var userCharsRef = _database.ref(
          '$userCollection/${AuthService.user?.uid}/chars'); // Referência ao nó de personagens do usuário

      var newCharRef =
          userCharsRef.push(); // Gerando uma nova chave única para o personagem
      newCharacter.id = newCharRef.key!; // Definindo o ID do personagem

      await newCharRef
          .set(newCharacter.toMap()); // Salvando os dados do personagem

      return newCharacter.id; // Confirmação de que foi salvo com sucesso
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
      var charRef = _database
          .ref('$userCollection/${AuthService.user?.uid}/chars/$charId');

      // Obtém os dados do personagem antes de remover
      var charSnapshot = await charRef.get();
      if (charSnapshot.exists) {
        var charData = charSnapshot.value as Map;

        // Remove todos os itens relacionados ao personagem
        if (charData['items'] != null) {
          var items = charData['items'] as Map;
          for (var itemId in items.keys) {
            var itemRef = _database.ref(
                '$userCollection/${AuthService.user?.uid}/chars/$charId/items/$itemId');
            await itemRef.remove();
          }
        }
      }

      // Removendo o personagem
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

    var charRef =
        _database.ref('$userCollection/${AuthService.user?.uid}/chars/$charId');
    DataSnapshot snapshot = await charRef.get();
    return snapshot.exists
        ? CharacterModel.fromMap(snapshot.value as Map<String, dynamic>)
        : null;
  }

  /// Método para atualizar os dados de um personagem específico
  static Future<void> updateCharacter(
      String charId, Map<String, dynamic> updatedData) async {
    if (AuthService.user == null) {
      throw 'Usuário não autenticado';
    }

    await AuthService.reauthenticate();

    var charRef =
        _database.ref('$userCollection/${AuthService.user?.uid}/chars/$charId');
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

      // Obtém os personagens do usuário
      DataSnapshot snapshot = await userCharsRef.get().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('A operação de leitura no Firebase expirou.');
        },
      );

      if (!snapshot.exists) {
        return [];
      }

      List<CharacterModel> characters = [];
      for (var charSnapshot in snapshot.children) {
        var characterData = Map<String, dynamic>.from(
            charSnapshot.value as Map<dynamic, dynamic>);
        characters.add(CharacterModel.fromMap(characterData));
      }

      return characters;
    } catch (e) {
      // Captura e lança a exceção com uma mensagem de erro personalizada
      throw "Erro ao buscar personagens: ${e.toString()}";
    }
  }

  /// Método para adicionar um item a um personagem
  static Future<String?> addItem(String charId, ItemModel newItem) async {
    if (AuthService.user == null) {
      throw 'Usuário não autenticado';
    }

    await AuthService.reauthenticate();

    try {
      var itemsRef = _database
          .ref('$userCollection/${AuthService.user?.uid}/chars/$charId/items');

      var newItemRef =
          itemsRef.push(); // Gerando uma nova chave única para o item
      newItem.id = newItemRef.key!;

      await newItemRef.set(newItem.toMap()); // Salvando os dados do item

      return newItem.id;
    } catch (e) {
      throw 'Erro ao salvar o item: $e';
    }
  }

  /// Método para deletar um item de um personagem
  static Future<void> deleteItem(String charId, String itemId) async {
    if (AuthService.user == null) {
      throw 'Usuário não autenticado';
    }

    await AuthService.reauthenticate();

    var itemRef = _database.ref(
        '$userCollection/${AuthService.user?.uid}/chars/$charId/items/$itemId');
    await itemRef.remove();
  }

  /// Método para obter todos os itens de um personagem
  static Future<List<ItemModel>> getCharItems(String charId) async {
    if (AuthService.user == null) {
      throw 'Usuário não autenticado';
    }

    await AuthService.reauthenticate();

    var itemsRef = _database
        .ref('$userCollection/${AuthService.user?.uid}/chars/$charId/items');
    DataSnapshot snapshot = await itemsRef.get();

    List<ItemModel> items = [];
    for (var itemSnapshot in snapshot.children) {
      var itemData = itemSnapshot.value as Map<dynamic, dynamic>;
      items.add(ItemModel.fromMap(itemData));
    }

    return items;
  }

  /// Método para ler os dados de um item específico
  static Future<ItemModel?> getItem(String charId, String itemId) async {
    if (AuthService.user == null) {
      throw 'Usuário não autenticado';
    }

    await AuthService.reauthenticate();

    var itemRef = _database.ref(
        '$userCollection/${AuthService.user?.uid}/chars/$charId/items/$itemId');
    DataSnapshot snapshot = await itemRef.get();
    return snapshot.exists
        ? ItemModel.fromMap(snapshot.value as Map<String, dynamic>)
        : null;
  }

  /// Método para atualizar os dados de um item específico
  static Future<void> updateItem(
      String charId, String itemId, Map<String, dynamic> updatedData) async {
    if (AuthService.user == null) {
      throw 'Usuário não autenticado';
    }

    await AuthService.reauthenticate();

    var itemRef = _database.ref(
        '$userCollection/${AuthService.user?.uid}/chars/$charId/items/$itemId');
    await itemRef.update(updatedData);
  }
}
