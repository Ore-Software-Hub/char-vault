import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class StorageService {
  static final _storage = FirebaseStorage.instance;
  static const String path = 'users/images/';

  /// Salvar imagem de um usuário
  static Future<String> uploadUserImage(String userId, File file) async {
    try {
      String uniqueFilename =
          '${userId}_${DateTime.now().millisecondsSinceEpoch}.png';
      var ref = _storage.ref().child('$path$uniqueFilename');
      UploadTask uploadTask = ref.putFile(file);

      var snapshot = await uploadTask.whenComplete(() {});
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Erro ao fazer upload do arquivo: $e');
      rethrow;
    }
  }

  /// Remover imagem pelo ID da imagem
  static Future<void> deleteImageById(String imageId) async {
    try {
      var ref = _storage.ref().child('$path$imageId');
      await ref.delete();
    } catch (e) {
      print('Erro ao deletar o arquivo: $e');
      rethrow;
    }
  }

  /// Retornar a URL de download de uma imagem
  static Future<String> getImageDownloadUrl(String imageId) async {
    try {
      var ref =
          _storage.ref().child("/users/images$imageId"); // Usar o ID da imagem diretamente
      return await ref.getDownloadURL();
    } catch (e) {
      print('Erro ao obter a URL de download do arquivo: $e');
      rethrow;
    }
  }
}
