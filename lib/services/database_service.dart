import 'package:CharVault/models/character_model.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  static final _database = FirebaseDatabase.instance;

  /// Método para salvar dados em uma coleção e retornar a chave única gerada
  static Future<String> saveData(String collection, dynamic value) async {
    var ref = _database.ref(collection);

    var newRef = ref.push(); // Gerando uma nova chave única
    String newKey = newRef.key!; // Obtendo a chave única
    await newRef.set(value); // Adicionando o novo valor com a chave gerada

    return newKey;
  }

  /// Método para adicionar um personagem a um usuário
  static Future<bool> addCharacter(
      String userId, CharacterModel newCharacter) async {
    try {
      String charId = await saveData(
          'Chars',
          newCharacter
              .toMap()); // Salvando o personagem na coleção de personagens

      var userCharsRef = _database.ref(
          'Users/$userId/chars'); // Referência ao nó de personagens do usuário

      await userCharsRef
          .child(charId)
          .set(true); // Adicionando a referência ao personagem no nó do usuário

      return true; // Confirmação de que foi salvo com sucesso
    } catch (e) {
      print('Erro ao salvar o personagem: $e');
      return false; // Retorna false em caso de erro
    }
  }

  /// Método para deletar um personagem de um usuário
  static Future<void> deleteCharacter(String userId, String charId) async {
    var userCharsRef = _database.ref(
        'Users/$userId/chars/$charId'); // Referência ao nó de personagens do usuário

    await userCharsRef
        .remove(); // Removendo a referência ao personagem no nó do usuário

    var charRef = _database.ref(
        'Chars/$charId'); // Referência ao personagem na coleção de personagens

    await charRef.remove(); // Removendo o personagem da coleção de personagens
  }

  /// Método para ler os dados de um personagem específico
  static Future<CharacterModel?> getCharacter(String charId) async {
    var charRef = _database.ref('Chars/$charId');
    DataSnapshot snapshot = await charRef.get();
    return snapshot.exists ? snapshot.value as CharacterModel : null;
  }

  /// Método para atualizar os dados de um personagem específico
  static Future<void> updateCharacter(
      String charId, Map<String, dynamic> updatedData) async {
    var charRef = _database.ref('Chars/$charId');
    await charRef.update(updatedData);
  }

  /// Método para obter todos os personagens de um usuário
  static Future<List<CharacterModel>> getUserCharacters(String userId) async {
    var userCharsRef = _database.ref('Users/$userId/chars');
    DataSnapshot snapshot = await userCharsRef.get();

    List<CharacterModel> characters = [];
    for (var charId in snapshot.children) {
      var charSnapshot = await _database.ref('Chars/${charId.key}').get();
      if (charSnapshot.exists) {
        var characterData = charSnapshot.value as Map<dynamic, dynamic>;
        characters.add(CharacterModel.fromMap(characterData));
      }
    }

    return characters;
  }
}
