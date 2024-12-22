import 'package:my_app/models/enums/pet_state.dart';

class Pet {
  Pet({
    required String name,
    required String type,
    PetState state = PetState.egg,
    double hunger = 100,
    double happiness = 100,
    double health = 100,
    double cleanliness = 100,
    double energy = 100,
    DateTime? birthDate,
  })  : _name = name,
        _type = type,
        _state = state,
        _hunger = hunger,
        _happiness = happiness,
        _health = health,
        _cleanliness = cleanliness,
        _energy = energy,
        _birthDate = birthDate ?? DateTime.now();

  final String _name;
  final String _type;
  PetState _state;
  double _hunger;
  double _happiness;
  double _health;
  double _cleanliness;
  double _energy;
  final DateTime _birthDate;

  String get name => _name;
  String get type => _type;
  PetState get state => _state;
  double get hunger => _hunger;
  double get happiness => _happiness;
  double get health => _health;
  double get cleanliness => _cleanliness;
  double get energy => _energy;
  DateTime get birthDate => _birthDate;

  bool get isAlive => _state.isAlive;
  int get ageInDays => DateTime.now().difference(_birthDate).inDays;

  void feed(double amount) {
    if (!isAlive) return;
    _hunger = (_hunger + amount).clamp(0, 100);
  }

  void play(double amount) {
    if (!isAlive) return;
    _happiness = (_happiness + amount).clamp(0, 100);
    _energy = (_energy - amount * 0.5).clamp(0, 100);
  }

  void clean(double amount) {
    if (!isAlive) return;
    _cleanliness = (_cleanliness + amount).clamp(0, 100);
  }

  void exercise(double amount) {
    if (!isAlive) return;
    _health = (_health + amount).clamp(0, 100);
    _energy = (_energy - amount).clamp(0, 100);
  }

  void rest(double amount) {
    if (!isAlive) return;
    _energy = (_energy + amount).clamp(0, 100);
  }

  void update() {
    if (!isAlive) return;

    _hunger = (_hunger - 0.1).clamp(0, 100);
    _happiness = (_happiness - 0.1).clamp(0, 100);
    _cleanliness = (_cleanliness - 0.1).clamp(0, 100);
    _energy = (_energy - 0.05).clamp(0, 100);
    _health = (_health - 0.05).clamp(0, 100);

    if (_hunger <= 0 || _happiness <= 0 || _health <= 0) {
      _state = PetState.dead;
    }
  }

  bool tryEvolve() {
    if (!_state.canEvolve) return false;

    final requirements = {
      PetState.egg: ageInDays >= 1,
      PetState.baby: ageInDays >= 3 && _happiness >= 50,
      PetState.child: ageInDays >= 7 && _health >= 60,
      PetState.teen: ageInDays >= 14 && _cleanliness >= 70,
      PetState.adult: ageInDays >= 30 && _hunger >= 80,
      PetState.senior: ageInDays >= 60 && _energy >= 90,
    };

    if (requirements[_state] == true) {
      _state = _state.nextState;
      return true;
    }
    return false;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': _name,
      'type': _type,
      'state': _state.index,
      'hunger': _hunger,
      'happiness': _happiness,
      'health': _health,
      'cleanliness': _cleanliness,
      'energy': _energy,
      'birthDate': _birthDate.toIso8601String(),
    };
  }

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      name: json['name'] as String,
      type: json['type'] as String,
      state: PetState.values[json['state'] as int],
      hunger: (json['hunger'] as num).toDouble(),
      happiness: (json['happiness'] as num).toDouble(),
      health: (json['health'] as num).toDouble(),
      cleanliness: (json['cleanliness'] as num).toDouble(),
      energy: (json['energy'] as num).toDouble(),
      birthDate: DateTime.parse(json['birthDate'] as String),
    );
  }
}