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

  updateUser() {
    var curUser = AuthService.user;

    var char = CharacterModel(
      "https://i.pinimg.com/originals/02/f2/a6/02f2a6f010ab7885a6324d4f426312e9.png",
      "Garry Floyd",
      "Bardo",
      "1",
      "15",
      "17",
      "20",
      "120",
      "200",
      null,
      null,
      null
    );

    UserModel newUserModel =
        UserModel(curUser!.photoURL!, curUser.displayName!, char);
    userModel = newUserModel;
  }
}
