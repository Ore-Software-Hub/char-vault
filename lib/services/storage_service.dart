import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  static final _storage = FirebaseStorage.instance;

  static UploadTask? _uploadTask;

  static String path = 'files/images/';

  static Future<String> upload(String filename, File file) async {
    var ref = _storage.ref().child("$path$filename");
    _uploadTask = ref.putFile(file);
    var snapshot = await _uploadTask!.whenComplete(() {});
    return await snapshot.ref.getDownloadURL();
  }
}
