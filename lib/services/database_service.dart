import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  static final _database = FirebaseDatabase.instance;

  static Future<String> saveData(String collection, dynamic value) async {
    var ref = _database.ref(collection);

    // Gerando uma nova chave única
    var newUserRef = ref.push();

    // Obtendo a chave única
    String newContactKey = newUserRef.key!;

    // Adicionando o novo contato com a chave gerada
    await newUserRef.set(value);

    // Retornando a chave única gerada
    return newContactKey;
  }

  static addCharacter(String userId, dynamic newCharacter) async {
    // Referência ao nó de contatos do usuário
    var ref = _database.ref('users/$userId/characters');

    // Adicionando o novo contato com uma chave única
    await ref.push().set(newCharacter);
  }
}
