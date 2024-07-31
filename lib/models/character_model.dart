class CharacterModel {
  String image;
  String name;
  String classe;
  String level;
  String curLife;
  String maxLife;
  String po;
  String pp;
  String pb;

  CharacterModel(this.image, this.name, this.classe, this.level, this.curLife,
      this.maxLife, this.po, this.pp, this.pb);

  @override
  String toString() {
    return "image $image, name $name, classe $classe, level $level, curLife $curLife, maxLife $maxLife, po $po, pp $pp, pb $pb";
  }
}
