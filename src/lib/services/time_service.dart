import 'dart:async';
import 'package:my_app/services/pet_service.dart';

class TimeService {
  final PetService _petService;
  Timer? _gameTimer;

  TimeService(this._petService);

  void startGameLoop() {
    _gameTimer?.cancel();
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      try {
        _petService.updatePet();
      } catch (e) {
        print('Error updating pet: $e');
      }
    });
  }

  void stopGameLoop() {
    _gameTimer?.cancel();
    _gameTimer = null;
  }

  void dispose() {
    stopGameLoop();
  }
}
