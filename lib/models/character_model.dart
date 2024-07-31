import 'package:firebase_auth/firebase_auth.dart';

class CharacterModel {
  String? image;
  String? name;
  String? classe;
  String? level;
  String? curLife;
  String? maxLife;
  String? po;
  String? pp;
  String? pb;

  CharacterModel(String? image, String? name, String? classe, String? level,
      String? curLife, String? maxLife, String? po, String? pp, String? pb);

  @override
  String toString() {
    return "image $image, name $name, classe $classe, level $level, curLife $curLife, maxLife $maxLife, po $po, pp $pp, pb $pb";
  }
}
