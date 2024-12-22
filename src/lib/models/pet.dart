import 'package:my_app/models/enums/pet_state.dart';

class Pet {
  Pet({
    required this.name,
    required this.type,
    this.state = PetState.egg,
    this.hunger = 100,
    this.happiness = 100,
    this.health = 100,
    this.cleanliness = 100,
    this.energy = 100,
    DateTime? birthDate,
  }) : birthDate = birthDate ?? DateTime.now();

  final String name;
  final String type;
  PetState state;
  double hunger;
  double happiness;
  double health;
  double cleanliness;
  double energy;
  final DateTime birthDate;

  bool get isAlive => state.isAlive;
  int get ageInDays => DateTime.now().difference(birthDate).inDays;

  void feed(double amount) {
    if (!isAlive) return;
    hunger = (hunger + amount).clamp(0, 100);
  }

  void play(double amount) {
    if (!isAlive) return;
    happiness = (happiness + amount).clamp(0, 100);
    energy = (energy - amount * 0.5).clamp(0, 100);
  }

  void clean(double amount) {
    if (!isAlive) return;
    cleanliness = (cleanliness + amount).clamp(0, 100);
  }

  void exercise(double amount) {
    if (!isAlive) return;
    health = (health + amount).clamp(0, 100);
    energy = (energy - amount).clamp(0, 100);
  }

  void rest(double amount) {
    if (!isAlive) return;
    energy = (energy + amount).clamp(0, 100);
  }

  void update() {
    if (!isAlive) return;

    hunger = (hunger - 0.1).clamp(0, 100);
    happiness = (happiness - 0.1).clamp(0, 100);
    cleanliness = (cleanliness - 0.1).clamp(0, 100);
    energy = (energy - 0.05).clamp(0, 100);
    health = (health - 0.05).clamp(0, 100);

    if (hunger <= 0 || happiness <= 0 || health <= 0) {
      state = PetState.dead;
    }
  }

  bool tryEvolve() {
    if (!state.canEvolve) return false;

    final requirements = {
      PetState.egg: ageInDays >= 1,
      PetState.baby: ageInDays >= 3 && happiness >= 50,
      PetState.child: ageInDays >= 7 && health >= 60,
      PetState.teen: ageInDays >= 14 && cleanliness >= 70,
      PetState.adult: ageInDays >= 30 && hunger >= 80,
      PetState.senior: ageInDays >= 60 && energy >= 90,
    };

    if (requirements[state] == true) {
      state = state.nextState;
      return true;
    }
    return false;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'state': state.index,
      'hunger': hunger,
      'happiness': happiness,
      'health': health,
      'cleanliness': cleanliness,
      'energy': energy,
      'birthDate': birthDate.toIso8601String(),
    };
  }

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      name: json['name'],
      type: json['type'],
      state: PetState.values[json['state']],
      hunger: json['hunger'],
      happiness: json['happiness'],
      health: json['health'],
      cleanliness: json['cleanliness'],
      energy: json['energy'],
      birthDate: DateTime.parse(json['birthDate']),
    );
  }
}
