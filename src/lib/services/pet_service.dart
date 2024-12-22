import 'package:my_app/models/pet.dart';

class PetService {
  Pet? _currentPet;

  Pet? get currentPet => _currentPet;
  bool get hasPet => _currentPet != null;

  void createPet({required String name, required String type}) {
    if (name.isEmpty) {
      throw Exception('Please enter a name for your pet');
    }
    _currentPet = Pet(name: name, type: type);
  }

  void updatePet() {
    if (_currentPet == null) {
      throw Exception('No pet exists');
    }
    _currentPet!.update();

    // Check for evolution
    if (_currentPet!.tryEvolve()) {
      // TODO: Notify evolution
    }
  }

  void feed(double amount) {
    if (_currentPet == null) {
      throw Exception('No pet exists to feed');
    }
    if (!_currentPet!.isAlive) {
      throw Exception('Cannot feed a deceased pet');
    }
    _currentPet!.feed(amount);
  }

  void play(double amount) {
    if (_currentPet == null) {
      throw Exception('No pet exists to play with');
    }
    if (!_currentPet!.isAlive) {
      throw Exception('Cannot play with a deceased pet');
    }
    _currentPet!.play(amount);
  }

  void clean(double amount) {
    if (_currentPet == null) {
      throw Exception('No pet exists to clean');
    }
    if (!_currentPet!.isAlive) {
      throw Exception('Cannot clean a deceased pet');
    }
    _currentPet!.clean(amount);
  }

  void exercise(double amount) {
    if (_currentPet == null) {
      throw Exception('No pet exists to exercise');
    }
    if (!_currentPet!.isAlive) {
      throw Exception('Cannot exercise a deceased pet');
    }
    _currentPet!.exercise(amount);
  }

  void rest(double amount) {
    if (_currentPet == null) {
      throw Exception('No pet exists to rest');
    }
    if (!_currentPet!.isAlive) {
      throw Exception('Cannot rest a deceased pet');
    }
    _currentPet!.rest(amount);
  }

  Map<String, dynamic> toJson() {
    return {
      'currentPet': _currentPet?.toJson(),
    };
  }

  void loadFromJson(Map<String, dynamic> petData) {
    if (petData['currentPet'] != null) {
      final Map<String, dynamic> currentPetData = 
          Map<String, dynamic>.from(petData['currentPet'] as Map);
      _currentPet = Pet.fromJson(currentPetData);
    }
  }
}