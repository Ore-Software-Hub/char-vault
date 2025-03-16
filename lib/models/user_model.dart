import 'package:CharVault/models/character_model.dart';

class UserModel {
  String image;
  String name;
  String email;
  CharacterModel? char;

  UserModel(
      {required this.image,
      required this.name,
      required this.char,
      required this.email});

  @override
  String toString() {
    return "image: $image, name: $name, char: ${char.toString()}";
  }
}
