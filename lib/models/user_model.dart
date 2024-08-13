import 'package:CharVault/models/character_model.dart';

class UserModel {
  String image;
  String name;
  CharacterModel? char;

  UserModel(this.image, this.name, this.char);

  @override
  String toString() {
    return "image: $image, name: $name, char: ${char.toString()}";
  }
}
