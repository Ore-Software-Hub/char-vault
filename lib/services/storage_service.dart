import 'dart:async';
import 'dart:io';
import 'package:CharVault/services/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  static final _storage = FirebaseStorage.instance;

  /// Salvar imagem de um usuário
  static Future<String> uploadUserImage(String charName, File file) async {
    if (AuthService.user == null) {
      throw 'Usuário não autenticado';
    }

    await AuthService.reauthenticate();

    try {
      String uniqueFilename =
          '${charName}_${DateTime.now().millisecondsSinceEpoch}.png';
      var ref = _storage
          .ref()
          .child('Users/${AuthService.user?.uid}/images/$uniqueFilename');

      // Cria o UploadTask e verifica o status
      UploadTask uploadTask = ref.putFile(file);

      // Aguarda o upload concluir
      await uploadTask.whenComplete(() {});

      // Retorna o nome do arquivo para referência futura
      return ref.name;
    } catch (e) {
      throw 'Erro ao fazer upload do arquivo: $e';
    }
  }

  /// Remover imagem pelo ID da imagem
  static Future<void> deleteImageById(String imageId) async {
    if (AuthService.user == null) {
      throw 'Usuário não autenticado';
    }

    await AuthService.reauthenticate();

    try {
      var imageRef =
          _storage.ref().child('Users/${AuthService.user?.uid}/images');

      // Listar todos os arquivos no diretório
      ListResult result = await imageRef.listAll();

      final List<Reference> matchingFiles = result.items.where((item) {
        return item.name == imageId;
      }).toList();

      for (final Reference file in matchingFiles) {
        await file.delete();
      }
    } catch (e) {
      throw 'Erro ao remover a imagem: $e';
    }
  }

  /// Retornar a URL de download de uma imagem
  static Future<String> getImageDownloadUrl(String imageId) async {
    if (AuthService.user == null) {
      throw 'Usuário não autenticado';
    }

    await AuthService.reauthenticate();

    try {
      var ref = _storage
          .ref()
          .child('Users/${AuthService.user?.uid}/images/$imageId');
      return await ref.getDownloadURL();
    } catch (e) {
      throw 'Erro ao obter a URL de download do arquivo: $e';
    }
  }
}
