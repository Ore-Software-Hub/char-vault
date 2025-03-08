class CharacterModel {
  String id;
  String image;
  String name;
  String classe;
  String level;
  String curLife;
  String maxLife;
  String po;
  String pp;
  String pb;
  String notes;

  CharacterDetails? details;
  List<FeatureDetails>? savingThrows;
  List<FeatureDetails>? features;
  List<SkillDetails>? skills;

  CharacterModel(
      this.id,
      this.image,
      this.name,
      this.classe,
      this.level,
      this.curLife,
      this.maxLife,
      this.po,
      this.pp,
      this.pb,
      this.notes,
      this.details,
      this.savingThrows,
      this.features,
      this.skills);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'classe': classe,
      'level': level,
      'curLife': curLife,
      'maxLife': maxLife,
      'po': po,
      'pp': pp,
      'pb': pb,
      'notes': notes,
      'details': details?.toMap(),
      'savingThrows': savingThrows?.map((e) => e.toMap()).toList(),
      'features': features?.map((e) => e.toMap()).toList(),
      'skills': skills?.map((e) => e.toMap()).toList(),
    };
  }

  factory CharacterModel.fromMap(Map<dynamic, dynamic> map) {
    return CharacterModel(
      map['id'] ?? '',
      map['image'] ?? '',
      map['name'] ?? '',
      map['classe'] ?? '',
      map['level'] ?? '',
      map['curLife'] ?? '',
      map['maxLife'] ?? '',
      map['po'] ?? '',
      map['pp'] ?? '',
      map['pb'] ?? '',
      map['notes'] ?? '',
      map['details'] != null ? CharacterDetails.fromMap(map['details']) : null,
      map['savingThrows'] != null
          ? List<FeatureDetails>.from(
              map['savingThrows'].map((x) => FeatureDetails.fromMap(x)))
          : null,
      map['features'] != null
          ? List<FeatureDetails>.from(
              map['features'].map((x) => FeatureDetails.fromMap(x)))
          : null,
      map['skills'] != null
          ? List<SkillDetails>.from(
              map['skills'].map((x) => SkillDetails.fromMap(x)))
          : null,
    );
  }

  static String calculateLife(int pv, int level, int modifier) {
    var maxLife = "0";

    if (level == 1) {
      maxLife = (pv + modifier).toString();
    } else {
      int initial = pv + modifier;

      int lifePerLevel = (pv / 2).ceil() + 1 + modifier;

      int totalPerLevel = 0;

      for (var i = 0; i < level - 1; i++) {
        totalPerLevel += lifePerLevel;
      }

      maxLife = (initial + totalPerLevel).toString();
    }

    return maxLife;
  }

  @override
  String toString() {
    return "image $image, name $name, classe $classe, level $level, curLife $curLife, maxLife $maxLife, po $po, pp $pp, pb $pb, details ${details.toString()}, features ${features.toString()}, savingThrows ${savingThrows.toString()}, skills ${skills.toString()},";
  }
}

class CharacterDetails {
  String age;
  String race;
  String height;
  String weight;
  String background;
  String alignment;
  String backstory;

  CharacterDetails(this.age, this.race, this.height, this.weight,
      this.background, this.alignment, this.backstory);

  Map<String, dynamic> toMap() {
    return {
      'age': age,
      'race': race,
      'height': height,
      'weight': weight,
      'background': background,
      'alignment': alignment,
      'backstory': backstory,
    };
  }

  factory CharacterDetails.fromMap(Map<dynamic, dynamic> map) {
    return CharacterDetails(
      map['age'] ?? '',
      map['race'] ?? '',
      map['height'] ?? '',
      map['weight'] ?? '',
      map['background'] ?? '',
      map['alignment'] ?? '',
      map['backstory'] ?? '',
    );
  }

  @override
  String toString() {
    return "age $age, race $race, background $background, alignment $alignment, backstory $backstory,";
  }
}

class FeatureDetails {
  String title;
  int value;
  int modifier;

  FeatureDetails(this.title, this.value, this.modifier);

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'value': value,
      'modifier': modifier,
    };
  }

  factory FeatureDetails.fromMap(Map<dynamic, dynamic> map) {
    return FeatureDetails(
      map['title'] ?? '',
      map['value'] ?? 0,
      map['modifier'] ?? 0,
    );
  }

  @override
  String toString() {
    return "title $title, value $value, modifier $modifier,";
  }
}

class SkillDetails {
  String title;
  int value;

  SkillDetails(this.title, this.value);

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'value': value,
    };
  }

  factory SkillDetails.fromMap(Map<dynamic, dynamic> map) {
    return SkillDetails(
      map['title'] ?? '',
      map['value'] ?? 0,
    );
  }

  @override
  String toString() {
    return "title $title, value $value,";
  }
}
