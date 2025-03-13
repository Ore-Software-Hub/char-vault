import 'dart:async';
import 'package:CharVault/models/character_model.dart';
import 'package:CharVault/models/class.model.dart';
import 'package:CharVault/models/item_model.dart';
import 'package:CharVault/models/paper.model.dart';
import 'package:CharVault/services/auth_service.dart';
import 'package:CharVault/services/storage_service.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  static final _database = FirebaseDatabase.instance;

  static const String userCollection = "Users";
  static const String classCollection = "Classes";

  // ============= CRUD CLASSES ====================

  static Future<List<ClassModel>> getClasses() async {
    if (AuthService.user == null) {
      throw 'Usuário não autenticado';
    }

    await AuthService.reauthenticate();

    try {
      var classModelRef = _database.ref(classCollection);

      // Obtém os personagens do usuário
      DataSnapshot snapshot = await classModelRef.get().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('A operação de leitura no Firebase expirou.');
        },
      );

      if (!snapshot.exists) {
        return [];
      }

      List<ClassModel> classes = [];
      for (var charSnapshot in snapshot.children) {
        var classesData = Map<String, dynamic>.from(
            charSnapshot.value as Map<dynamic, dynamic>);
        classes.add(ClassModel.fromMap(classesData));
      }

      return classes;
    } catch (e) {
      // Captura e lança a exceção com uma mensagem de erro personalizada
      throw "Erro ao buscar classes: ${e.toString()}";
    }
  }

  static Future<ClassModel?> getClass(String classId) async {
    if (AuthService.user == null) {
      throw 'Usuário não autenticado';
    }

    await AuthService.reauthenticate();

    var ref = _database.ref('$classCollection/$classId');
    DataSnapshot snapshot = await ref.get();
    if (!snapshot.exists) {
      return null;
    }
    var classe = snapshot.value as Map<dynamic, dynamic>;
    return ClassModel.fromMap(classe);
  }

  // ============= CRUD CHARACTERS ====================

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

// ============= CRUD ITEMS ====================

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

  static Future<void> deleteItem(String charId, String itemId) async {
    if (AuthService.user == null) {
      throw 'Usuário não autenticado';
    }

    await AuthService.reauthenticate();

    var itemRef = _database.ref(
        '$userCollection/${AuthService.user?.uid}/chars/$charId/items/$itemId');
    await itemRef.remove();
  }

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

// ============= CRUD PAPERS ====================

  static Future<String?> addPaper(String charId, PapersModel newPaper) async {
    if (AuthService.user == null) {
      throw 'Usuário não autenticado';
    }

    await AuthService.reauthenticate();

    try {
      var ref = _database
          .ref('$userCollection/${AuthService.user?.uid}/chars/$charId/papers');

      var newPaperRef = ref.push(); // Gerando uma nova chave única para o item
      newPaper.id = newPaperRef.key!;

      await newPaperRef.set(newPaper.toMap()); // Salvando os dados do item

      return newPaper.id;
    } catch (e) {
      throw 'Erro ao salvar o Paper: $e';
    }
  }

  static Future<void> deletePaper(String charId, String paperId) async {
    if (AuthService.user == null) {
      throw 'Usuário não autenticado';
    }

    await AuthService.reauthenticate();

    var ref = _database.ref(
        '$userCollection/${AuthService.user?.uid}/chars/$charId/papers/$paperId');
    await ref.remove();
  }

  static Future<List<PapersModel>> getCharPapers(String charId) async {
    if (AuthService.user == null) {
      throw 'Usuário não autenticado';
    }

    await AuthService.reauthenticate();

    var ref = _database
        .ref('$userCollection/${AuthService.user?.uid}/chars/$charId/papers');
    DataSnapshot snapshot = await ref.get();

    List<PapersModel> array = [];
    for (var itemSnapshot in snapshot.children) {
      var itemData = itemSnapshot.value as Map<String, dynamic>;
      array.add(PapersModel.fromMap(itemData));
    }

    return array;
  }

  static Future<PapersModel?> getPaper(String charId, String paperId) async {
    if (AuthService.user == null) {
      throw 'Usuário não autenticado';
    }

    await AuthService.reauthenticate();

    var ref = _database.ref(
        '$userCollection/${AuthService.user?.uid}/chars/$charId/papers/$paperId');
    DataSnapshot snapshot = await ref.get();
    return snapshot.exists
        ? PapersModel.fromMap(snapshot.value as Map<String, dynamic>)
        : null;
  }

  static Future<void> updatePaper(
      String charId, String paperId, Map<String, dynamic> updatedData) async {
    if (AuthService.user == null) {
      throw 'Usuário não autenticado';
    }

    await AuthService.reauthenticate();

    var ref = _database.ref(
        '$userCollection/${AuthService.user?.uid}/chars/$charId/papers/$paperId');
    await ref.update(updatedData);
  }
}
