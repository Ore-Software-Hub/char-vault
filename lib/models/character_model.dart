import 'package:CharVault/models/class.model.dart';

class CharacterModel {
  String id;
  String image;
  String name;
  List<Status> status;
  List<Currency> currency;

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
      'status': status.map((e) => {e.toMap()}).toList(),
      'currency': currency.map((e) => e.toMap()).toList(),
      'details': details.toMap(),
      'features': features.map((e) => e.toMap()).toList(),
    };
    return map;
  }

  factory CharacterModel.fromMap(Map<String, dynamic> map) {
    var details = CharacterDetails.fromMap(map['details']);

    var features = FeatureDetails.fromList(map['features']);

    List<Currency> currency =
        map['currency'] != null ? Currency.fromList(map['currency']) : [];

    var character = CharacterModel(
        id: map['id'] ?? '',
        image: map['image'] ?? '',
        name: map['name'] ?? '',
        status: map['status'] ?? [],
        currency: currency,
        details: details,
        features: features);
    return character;
  }

  static int calculateLife(int pv, int level, int modifier) {
    if (level == 1) return pv + modifier;

    int lifePerLevel = (pv / 2).ceil() + 1 + modifier;
    return (pv + modifier) + (lifePerLevel * (level - 1));
  }

  @override
  String toString() {
    return 'CharacterModel{id: $id, image: $image, name: $name, status: $status, currency: $currency, details: $details, features: $features}';
  }
}

class CharacterDetails {
  int curLife;
  int maxLife;
  int level;
  int armorClass;
  int movement;
  int age;
  int proficiency;
  String race;
  String height;
  String weight;
  String alignment;
  String background;
  String backstory;
  ClassModel classModel;
  List<String> languages;
  List<String> immunities;
  List<String> vulnerabilities;
  List<String> resistancies;

  CharacterDetails({
    required this.curLife,
    required this.maxLife,
    required this.level,
    required this.armorClass,
    required this.movement,
    required this.age,
    required this.proficiency,
    required this.race,
    required this.height,
    required this.weight,
    required this.alignment,
    required this.background,
    required this.backstory,
    required this.classModel,
    required this.languages,
    required this.immunities,
    required this.vulnerabilities,
    required this.resistancies,
  });

  Map<String, dynamic> toMap() {
    return {
      'curLife': curLife,
      'maxLife': maxLife,
      'level': level,
      'armorClass': armorClass,
      'movement': movement,
      'age': age,
      'proficiency': proficiency,
      'race': race,
      'height': height,
      'weight': weight,
      'alignment': alignment,
      'background': background,
      'backstory': backstory,
      'classModel': classModel.toMap(),
      'languages': languages,
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
      curLife: map['curLife'] ?? 0,
      maxLife: map['maxLife'] ?? 0,
      level: map['level'] ?? 0,
      armorClass: map['armorClass'] ?? 0,
      movement: map['movement'] ?? 0,
      age: map['age'] ?? 0,
      proficiency: map['proficiency'] ?? 0,
      race: map['race'] ?? '',
      height: map['height'] ?? '',
      weight: map['weight'] ?? '',
      alignment: map['alignment'] ?? '',
      background: map['background'] ?? '',
      backstory: map['backstory'] ?? '',
      classModel: ClassModel.fromMap(map['classModel']),
      languages: languages,
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
  List<SkillDetails>? skills;
  int? modifier;
  int? savingThrow;

  FeatureDetails({
    required this.title,
    required this.value,
    this.skills,
    this.modifier,
    this.savingThrow,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'value': value,
      'modifier': modifier,
      'savingThrow': savingThrow,
      'skills': skills?.map((e) => e.toMap()).toList(),
    };
  }

  factory FeatureDetails.fromMap(Map<String, dynamic> map) {
    var skills =
        map['skills'] == null ? null : SkillDetails.fromList(map['skills']);

    var feature = FeatureDetails(
      title: map['title'] ?? '',
      value: map['value'] ?? 0,
      modifier: map['modifier'],
      savingThrow: map['savingThrow'],
      skills: skills,
    );

    return feature;
  }

  static List<FeatureDetails> fromList(List<dynamic> list) {
    return list
        .map((item) => FeatureDetails.fromMap(Map<String, dynamic>.from(item)))
        .toList();
  }

  @override
  String toString() {
    return "FeatureDetails(title: $title, value: $value, skills: $skills, modifier: $modifier, savingThrow: $savingThrow)";
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

  static List<SkillDetails> fromList(List<dynamic> list) {
    return list
        .map((item) => SkillDetails.fromMap(Map<String, dynamic>.from(item)))
        .toList();
  }

  @override
  String toString() {
    return "title $title, value $value,";
  }
}

class Status {
  String name;
  String value;

  Status({required this.name, required this.value});

  Map<String, String> toMap() => {'name': name, 'value': value};

  factory Status.fromMap(Map<String, String> map) =>
      Status(name: map['name'] ?? '', value: map['value'] ?? '');

  static List<Status> fromList(List<dynamic> list) {
    return list
        .map((item) => Status.fromMap(Map<String, String>.from(item)))
        .toList();
  }
}

class Currency {
  String type;
  int amount;

  Currency({required this.type, required this.amount});

  Map<String, dynamic> toMap() {
    return {'type': type, 'amount': amount};
  }

  factory Currency.fromMap(Map<String, dynamic> map) =>
      Currency(type: map['type'] ?? '', amount: map['amount'] ?? 0);

  static List<Currency> fromList(List<dynamic> list) {
    return list
        .map((item) => Currency.fromMap(Map<String, dynamic>.from(item)))
        .toList();
  }
}
