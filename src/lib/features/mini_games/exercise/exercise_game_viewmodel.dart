import 'dart:async';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/services/game_service.dart';

class ExerciseGameViewModel extends BaseViewModel {
  final _gameService = locator<GameService>();
  final _navigationService = locator<NavigationService>();

  Timer? _exerciseTimer;
  bool _isJumping = false;
  int _exercisePoints = 0;

  bool get isJumping => _isJumping;
  int get exercisePoints => _exercisePoints;

  void startJump() {
    _isJumping = true;
    _startExerciseTimer();
    notifyListeners();
  }

  void stopJump() {
    _isJumping = false;
    _exerciseTimer?.cancel();
    notifyListeners();
  }

  void _startExerciseTimer() {
    _exerciseTimer?.cancel();
    _exerciseTimer = Timer.periodic(
      const Duration(milliseconds: 100),
      (timer) {
        _exercisePoints++;
        notifyListeners();
      },
    );
  }

  Future<void> finishGame() async {
    try {
      _exerciseTimer?.cancel();
      await _gameService.playExerciseGame();
      await _navigationService.back();
    } catch (e) {
      setError('Failed to complete exercise game: ${e.toString()}');
    }
  }

  @override
  void dispose() {
    _exerciseTimer?.cancel();
    super.dispose();
  }
}
