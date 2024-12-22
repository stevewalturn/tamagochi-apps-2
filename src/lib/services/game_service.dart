import 'dart:math';
import 'package:my_app/services/pet_service.dart';

class GameService {
  final PetService _petService;
  final Random _random = Random();

  GameService(this._petService);

  double playFeedingGame() {
    if (!_petService.hasPet) {
      throw Exception('No pet exists to play the feeding game');
    }
    if (!_petService.currentPet!.isAlive) {
      throw Exception('Cannot play games with a deceased pet');
    }

    // Simulate game result (0-100)
    final score = _random.nextDouble() * 100;
    final foodAmount = score / 2; // Convert score to food amount

    try {
      _petService.feed(foodAmount);
      return score;
    } catch (e) {
      throw Exception('Failed to feed pet: ${e.toString()}');
    }
  }

  double playCleaningGame() {
    if (!_petService.hasPet) {
      throw Exception('No pet exists to play the cleaning game');
    }
    if (!_petService.currentPet!.isAlive) {
      throw Exception('Cannot play games with a deceased pet');
    }

    final score = _random.nextDouble() * 100;
    final cleanAmount = score / 2;

    try {
      _petService.clean(cleanAmount);
      return score;
    } catch (e) {
      throw Exception('Failed to clean pet: ${e.toString()}');
    }
  }

  double playExerciseGame() {
    if (!_petService.hasPet) {
      throw Exception('No pet exists to play the exercise game');
    }
    if (!_petService.currentPet!.isAlive) {
      throw Exception('Cannot play games with a deceased pet');
    }

    final score = _random.nextDouble() * 100;
    final exerciseAmount = score / 2;

    try {
      _petService.exercise(exerciseAmount);
      return score;
    } catch (e) {
      throw Exception('Failed to exercise pet: ${e.toString()}');
    }
  }
}
