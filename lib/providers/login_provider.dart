import 'package:CharVault/models/character_model.dart';
import 'package:CharVault/models/user_model.dart';
import 'package:CharVault/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  set userModel(UserModel? user) {
    _userModel = user;
    notifyListeners();
  }

  updateUser({CharacterModel? char}) {
    var curUser = AuthService.user;
    UserModel newUserModel =
        UserModel(curUser!.photoURL!, curUser.displayName!, char);
    userModel = newUserModel;
  }
}
