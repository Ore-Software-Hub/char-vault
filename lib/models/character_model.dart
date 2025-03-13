class CharacterModel {
  String id;
  String image;
  String name;
  List<Map<String, String>> status;
  List<Map<String, int>> currency;

  CharacterDetails details;
  List<FeatureDetails> features;

  CharacterModel({
    required this.id,
    required this.image,
    required this.name,
    required this.status,
    required this.currency,
    required this.details,
    required this.features,
  });

  Map<String, dynamic> toMap() {
    var map = {
      'id': id,
      'image': image,
      'name': name,
      'status': status,
      'currency': currency,
      'details': details.toMap(),
      'features': features.map((e) => e.toMap()).toList(),
    };
    return map;
  }

  factory CharacterModel.fromMap(Map<dynamic, dynamic> map) {
    var details = CharacterDetails.fromMap(map['details']);

    var features = FeatureDetails.fromList(map['features']);

    var character = CharacterModel(
        id: map['id'] ?? '',
        image: map['image'] ?? '',
        name: map['name'] ?? '',
        status: map['status'] ?? [],
        currency: map['currency'] ?? [],
        details: details,
        features: features);
    return character;
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
    return 'CharacterModel{id: $id, image: $image, name: $name, status: $status, currency: $currency, details: $details, features: $features}';
  }
}

class CharacterDetails {
  String curLife;
  String maxLife;
  String level;
  String classId;
  String age;
  String race;
  String height;
  String weight;
  String alignment;
  String background;
  String backstory;
  List<String> languages;
  String armorClass;
  String movement;
  List<String> immunities;
  List<String> vulnerabilities;
  List<String> resistancies;

  CharacterDetails({
    required this.curLife,
    required this.maxLife,
    required this.level,
    required this.classId,
    required this.age,
    required this.race,
    required this.height,
    required this.weight,
    required this.alignment,
    required this.background,
    required this.backstory,
    required this.languages,
    required this.armorClass,
    required this.movement,
    required this.immunities,
    required this.vulnerabilities,
    required this.resistancies,
  });

  Map<String, dynamic> toMap() {
    return {
      'curLife': curLife,
      'maxLife': maxLife,
      'level': level,
      'classId': classId,
      'age': age,
      'race': race,
      'height': height,
      'weight': weight,
      'alignment': alignment,
      'background': background,
      'backstory': backstory,
      'languages': languages,
      'armorClass': armorClass,
      'movement': movement,
      'immunity': immunities,
      'vulnerabilities': vulnerabilities,
      'resistancies': resistancies,
    };
  }

  factory CharacterDetails.fromMap(Map<dynamic, dynamic> map) {
    List<String> languages = (map['languages'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];
    List<String> resistancies = (map['resistancies'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];
    List<String> vulnerabilities = (map['vulnerabilities'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];
    List<String> immunities = (map['immunities'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];

    var details = CharacterDetails(
      curLife: map['curLife'] ?? '',
      maxLife: map['maxLife'] ?? '',
      level: map['level'] ?? '',
      classId: map['classId'] ?? '',
      age: map['age'] ?? '',
      race: map['race'] ?? '',
      height: map['height'] ?? '',
      weight: map['weight'] ?? '',
      alignment: map['alignment'] ?? '',
      background: map['background'] ?? '',
      backstory: map['backstory'] ?? '',
      languages: languages,
      armorClass: map['armorClass'] ?? '',
      movement: map['movement'] ?? '',
      immunities: immunities,
      vulnerabilities: vulnerabilities,
      resistancies: resistancies,
    );
    return details;
  }

  @override
  String toString() {
    return "age $age, race $race, background $background, alignment $alignment, backstory $backstory, armorClass: $armorClass, movement: $movement, immunities: $immunities, vulnerabilities: $vulnerabilities resistancies: $resistancies";
  }
}

class FeatureDetails {
  String title;
  int value;
  List<String>? skill;
  int? modifier;
  int? savingThrow;

  FeatureDetails({
    required this.title,
    required this.value,
    this.skill,
    this.modifier,
    this.savingThrow,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'value': value,
      'modifier': modifier,
      'savingThrow': savingThrow,
    };
  }

  factory FeatureDetails.fromMap(Map<String, dynamic> map) {
    var feature = FeatureDetails(
      title: map['title'] ?? '',
      value: map['value'] ?? 0,
      skill: map['skill'],
      modifier: map['modifier'],
      savingThrow: map['savingThrow'],
    );

    return feature;
  }

  static fromList(List<dynamic> list) {
    List<FeatureDetails> features = [];

    for (var item in list) {
      var feat = Map<String, dynamic>.from(item as Map<dynamic, dynamic>);
      features.add(FeatureDetails.fromMap(feat));
    }

    return features;
  }

  @override
  String toString() {
    return "FeatureDetails(title: $title, value: $value, skill: $skill, modifier: $modifier, savingThrow: $savingThrow)";
  }
}
