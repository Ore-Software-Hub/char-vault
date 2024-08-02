import 'package:CharVault/models/character_model.dart';

class UserModel {
  String id;
  String image;
  String name;
  CharacterModel? char;

  UserModel(this.id, this.image, this.name, this.char);

  @override
  String toString() {
    return "image: $image, name: $name, char: ${char.toString()}";
  }
}
