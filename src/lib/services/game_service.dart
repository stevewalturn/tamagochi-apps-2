import 'dart:math';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/services/pet_service.dart';

class GameService {
  final _petService = locator<PetService>();
  final Random _random = Random();

  GameService();

  double playFeedingGame() {
    if (!_petService.hasPet) {
      throw Exception('No pet exists to play the feeding game');
    }
    if (!_petService.currentPet!.isAlive) {
      throw Exception('Cannot play games with a deceased pet');
    }

    final score = _random.nextDouble() * 100;
    final foodAmount = score / 2;

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