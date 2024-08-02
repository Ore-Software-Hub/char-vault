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

    var details = CharacterDetails(
        "26", "Humano", "Estudante", "Caótico Neutro", "era um cara bacano");

    var features = [
      FeatureDetails("Força", 8, -1),
      FeatureDetails("Destreza", 10, 0),
      FeatureDetails("Constituição", 14, 2),
      FeatureDetails("Inteligência", 13, 1),
      FeatureDetails("Sabedoria", 12, 1),
      FeatureDetails("Carisma", 15, 2)
    ];

    var skills = [
      SkillDetails("Atletismo", -1),
      SkillDetails("Acrobacia", 0),
      SkillDetails("Furtividade", 0),
      SkillDetails("Prestidigitação", 0),
      SkillDetails("Arcanismo", 1),
      SkillDetails("Investigação", 1),
      SkillDetails("Natureza", 1),
      SkillDetails("Religião", 1),
      SkillDetails("Intuição", 1),
      SkillDetails("Lidar com Animais", 1),
      SkillDetails("Medicina", 1),
      SkillDetails("Percepção", 1),
      SkillDetails("Sobrevivência", 1),
      SkillDetails("Atuação", 2),
      SkillDetails("Enganação", 2),
      SkillDetails("Intimidação", 2),
      SkillDetails("Persuasão", 2)
    ];

    var char = CharacterModel(
        "https://i.pinimg.com/originals/02/f2/a6/02f2a6f010ab7885a6324d4f426312e9.png",
        "Garry Floyd",
        "Bardo",
        "1",
        "8",
        "10",
        "20",
        "120",
        "200",
        details,
        features,
        features,
        skills);

    UserModel newUserModel =
        UserModel(curUser!.uid, curUser!.photoURL!, curUser.displayName!, char);
    userModel = newUserModel;
  }
}
