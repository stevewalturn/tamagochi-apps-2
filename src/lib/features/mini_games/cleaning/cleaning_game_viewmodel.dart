import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/services/game_service.dart';

class CleaningGameViewModel extends BaseViewModel {
  final _gameService = locator<GameService>();
  final _navigationService = locator<NavigationService>();

  final List<Offset> _cleanedAreas = [];
  double _cleanlinessScore = 0;

  List<Offset> get cleanedAreas => _cleanedAreas;
  double get cleanlinessScore => _cleanlinessScore;

  void onDrag(DragUpdateDetails details) {
    _cleanedAreas.add(details.localPosition);
    _updateScore();
    notifyListeners();
  }

  void _updateScore() {
    // Calculate score based on cleaned areas coverage
    _cleanlinessScore = (_cleanedAreas.length / 100).clamp(0, 100);
  }

  Future<void> finishGame() async {
    try {
      await _gameService.playCleaningGame();
      await _navigationService.back();
    } catch (e) {
      setError('Failed to complete cleaning game: ${e.toString()}');
    }
  }
}
