class CharacterModel {
  String id;
  String image;
  String name;
  List<Map<String, String>> status;
  List<Map<String, int>> currency;
  List<Papers> notes;
  List<Papers> missions;
  List<Papers> relationships;

  CharacterDetails? details;
  List<FeatureDetails>? features;

  CharacterModel({
    required this.id,
    required this.image,
    required this.name,
    required this.status,
    required this.currency,
    required this.notes,
    required this.missions,
    required this.relationships,
    required this.details,
    required this.features,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'status': status,
      'currency': currency,
      'notes': notes,
      'missions': missions,
      'relationships': relationships,
      'details': details?.toMap(),
      'features': features?.map((e) => e.toMap()).toList(),
    };
  }

  factory CharacterModel.fromMap(Map<dynamic, dynamic> map) {
    return CharacterModel(
        id: map['id'] ?? '',
        image: map['image'] ?? '',
        name: map['name'] ?? '',
        status: map['status'] ?? [],
        currency: map['currency'] ?? [],
        notes: map['notes'] ?? [],
        missions: map['missions'] ?? [],
        relationships: map['relationships'] ?? [],
        details: map['details'] != null
            ? CharacterDetails.fromMap(map['details'])
            : null,
        features: map['features'] != null
            ? List<FeatureDetails>.from(
                map['features'].map((x) => FeatureDetails.fromMap(x)))
            : null);
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
    return 'CharacterModel{id: $id, image: $image, name: $name, status: $status, currency: $currency, notes: ${notes.map((note) => {note.title})}, missions: ${missions.map((mission) => {
          mission.title
        })}, relationships: ${relationships.map((relation) => {relation.title})}, details: $details, features: $features}';
  }
}

class CharacterDetails {
  String curLife;
  String maxLife;
  String level;
  String classe;
  String age;
  String race;
  String height;
  String weight;
  String alignment;
  String background;
  String backstory;
  List<String> languages;
  List<Papers> talents;
  String armorClass;
  String movement;
  List<String> immunities;
  List<String> vulnerabilities;
  List<String> resistancies;

  CharacterDetails({
    required this.curLife,
    required this.maxLife,
    required this.level,
    required this.classe,
    required this.age,
    required this.race,
    required this.height,
    required this.weight,
    required this.alignment,
    required this.background,
    required this.backstory,
    required this.languages,
    required this.talents,
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
      'classe': classe,
      'age': age,
      'race': race,
      'height': height,
      'weight': weight,
      'alignment': alignment,
      'background': background,
      'backstory': backstory,
      'languages': languages,
      'talents': talents,
      'armorClass': armorClass,
      'movement': movement,
      'immunity': immunities,
      'vulnerabilities': vulnerabilities,
      'resistancies': resistancies,
    };
  }

  factory CharacterDetails.fromMap(Map<dynamic, dynamic> map) {
    return CharacterDetails(
      curLife: map['curLife'] ?? '',
      maxLife: map['maxLife'] ?? '',
      level: map['level'] ?? '',
      classe: map['classe'] ?? '',
      age: map['age'] ?? '',
      race: map['race'] ?? '',
      height: map['height'] ?? '',
      weight: map['weight'] ?? '',
      alignment: map['alignment'] ?? '',
      background: map['background'] ?? '',
      backstory: map['backstory'] ?? '',
      languages: map['languages'] ?? [],
      talents: map['talents'] ?? [],
      armorClass: map['armorClass'] ?? '',
      movement: map['movement'] ?? '',
      immunities: map['immunities'] ?? [],
      vulnerabilities: map['vulnerabilities'] ?? [],
      resistancies: map['resistancies'] ?? [],
    );
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
    return FeatureDetails(
      title: map['title'] ?? '',
      value: map['value'] ?? 0,
      skill: map['skill'],
      modifier: map['modifier'],
      savingThrow: map['savingThrow'],
    );
  }

  @override
  String toString() {
    return "FeatureDetails(title: $title, value: $value, skill: $skill, modifier: $modifier, savingThrow: $savingThrow)";
  }
}

class Papers {
  String title;
  String description;
  bool? completed;

  Papers({
    required this.title,
    required this.description,
    this.completed,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'completed': completed,
    };
  }

  factory Papers.fromMap(Map<String, dynamic> map) {
    return Papers(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      completed: map['completed'] ?? false,
    );
  }

  @override
  String toString() {
    return "Papers(title: $title, description: $description, completed: $completed)";
  }
}
