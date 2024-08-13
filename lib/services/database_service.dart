import 'package:CharVault/models/character_model.dart';
import 'package:CharVault/models/item_model.dart';
import 'package:CharVault/services/storage_service.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  static final _database = FirebaseDatabase.instance;

  static const String userCollection = "Users";
  static const String charCollection = "Chars";
  static const String itemsCollection = "Items";

  /// Método para salvar dados em uma coleção e retornar a chave única gerada
  static Future<String> saveData(String collection, dynamic value) async {
    var ref = _database.ref(collection);

    var newRef = ref.push(); // Gerando uma nova chave única
    String newKey = newRef.key!; // Obtendo a chave única
    await newRef.set(value); // Adicionando o novo valor com a chave gerada

    return newKey;
  }

  /// Método para adicionar um personagem a um usuário
  static Future<String?> addCharacter(
      String userId, CharacterModel newCharacter) async {
    try {
      String charId = await saveData(
          charCollection,
          newCharacter
              .toMap()); // Salvando o personagem na coleção de personagens

      newCharacter.id = charId;

      await updateCharacter(charId, newCharacter.toMap());

      var userCharsRef = _database.ref(
          '$userCollection/$userId/chars'); // Referência ao nó de personagens do usuário

      await userCharsRef
          .child(charId)
          .set(true); // Adicionando a referência ao personagem no nó do usuário

      return charId; // Confirmação de que foi salvo com sucesso
    } catch (e) {
      print('Erro ao salvar o personagem: $e');
      return null; // Retorna false em caso de erro
    }
  }

  /// Método para deletar um personagem de um usuário
  static Future<void> deleteCharacter(
      String userId, String charId, String charImageId) async {
    var userCharsRef = _database.ref(
        '$userCollection/$userId/chars/$charId'); // Referência ao nó de personagens do usuário

    await userCharsRef
        .remove(); // Removendo a referência ao personagem no nó do usuário

    var charRef = _database.ref(
        '$charCollection/$charId'); // Referência ao personagem na coleção de personagens

    await charRef.remove(); // Removendo o personagem da coleção de personagens
    await StorageService.deleteImageById(charImageId);
  }

  /// Método para ler os dados de um personagem específico
  static Future<CharacterModel?> getCharacter(String charId) async {
    var charRef = _database.ref('$charCollection/$charId');
    DataSnapshot snapshot = await charRef.get();
    return snapshot.exists ? snapshot.value as CharacterModel : null;
  }

  /// Método para atualizar os dados de um personagem específico
  static Future<void> updateCharacter(
      String charId, Map<String, dynamic> updatedData) async {
    var charRef = _database.ref('$charCollection/$charId');
    await charRef.update(updatedData);
  }

  /// Método para obter todos os personagens de um usuário
  static Future<List<CharacterModel>> getUserCharacters(String userId) async {
    try {
      var userCharsRef = _database.ref('$userCollection/$userId/chars');
      DataSnapshot snapshot = await userCharsRef.get();

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

      var characters = (await Future.wait(characterFutures))
          .whereType<CharacterModel>()
          .toList();
      return characters;
    } catch (e) {
      print('Erro ao buscar personagens para o usuário $userId: $e');
      return [];
    }
  }

  static Future<bool> addItemModel(
      String charId, ItemModel newItemModel) async {
    try {
      String newItemModelId =
          await saveData(itemsCollection, newItemModel.toMap());
      newItemModel.id = newItemModelId;
      await updateItemModel(newItemModelId, newItemModel.toMap());
      var userModelsRef = _database.ref('$charCollection/$charId/items');
      await userModelsRef.child(newItemModelId).set(true);
      return true;
    } catch (e) {
      print('Erro ao salvar o novo modelo: $e');
      return false;
    }
  }

  static Future<void> deleteItemModel(
      String charId, String newItemModelId) async {
    var userModelsRef =
        _database.ref('$charCollection/$charId/items/$newItemModelId');
    await userModelsRef.remove();
    var modelRef = _database.ref('$itemsCollection/$newItemModelId');
    await modelRef.remove();
  }

  static Future<ItemModel?> getItemModel(String newItemModelId) async {
    var modelRef = _database.ref('$itemsCollection/$newItemModelId');
    DataSnapshot snapshot = await modelRef.get();
    return snapshot.exists
        ? ItemModel.fromMap(snapshot.value as Map<String, dynamic>)
        : null;
  }

  static Future<void> updateItemModel(
      String newItemModelId, Map<String, dynamic> updatedData) async {
    var modelRef = _database.ref('$itemsCollection/$newItemModelId');
    await modelRef.update(updatedData);
  }

  static Future<List<ItemModel>> getCharItemModels(String charId) async {
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
