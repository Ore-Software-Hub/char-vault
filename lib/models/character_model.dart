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

  CharacterDetails? details;
  List<FeatureDetails>? features;
  List<SkillDetails>? skills;

  CharacterModel(
      this.image,
      this.name,
      this.classe,
      this.level,
      this.curLife,
      this.maxLife,
      this.po,
      this.pp,
      this.pb,
      this.details,
      this.features,
      this.skills);

  @override
  String toString() {
    return "image $image, name $name, classe $classe, level $level, curLife $curLife, maxLife $maxLife, po $po, pp $pp, pb $pb";
  }
}

class CharacterDetails {
  String age;
  String race;
  String background;
  String alignment;
  String backstory;

  CharacterDetails(
      this.age, this.race, this.background, this.alignment, this.backstory);
}

class FeatureDetails {
  String title;
  int value;
  int modifier;

  FeatureDetails(this.title, this.value, this.modifier);
}

class SkillDetails {
  String title;
  int value;

  SkillDetails(this.title, this.value);
}
