import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/services/game_service.dart';

class FoodItem {
  final Offset position;
  bool isCollected;

  FoodItem({required this.position, this.isCollected = false});
}

class FeedingGameViewModel extends BaseViewModel {
  final _gameService = locator<GameService>();
  final _navigationService = locator<NavigationService>();
  final _random = Random();

  Timer? _gameTimer;
  double _score = 0;
  final List<FoodItem> _foods = [];

  List<FoodItem> get foods => _foods;
  double get score => _score;

  void startGame() {
    _score = 0;
    _foods.clear();
    _startGameLoop();
  }

  void _startGameLoop() {
    _gameTimer?.cancel();
    _gameTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_random.nextDouble() < 0.05) {
        _addNewFood();
      }
      _updateFoodPositions();
      notifyListeners();
    });
  }

  void _addNewFood() {
    final screenWidth = 300.0; // Approximate game area width
    _foods.add(FoodItem(
      position: Offset(
        _random.nextDouble() * (screenWidth - 40),
        0,
      ),
    ));
  }

  void _updateFoodPositions() {
    for (var i = _foods.length - 1; i >= 0; i--) {
      var food = _foods[i];
      if (!food.isCollected) {
        var newY = food.position.dy + 2;
        if (newY > 400) {
          _foods.removeAt(i);
        } else {
          _foods[i] = FoodItem(
            position: Offset(food.position.dx, newY),
            isCollected: food.isCollected,
          );
        }
      }
    }
  }

  void onTapFood(Offset tapPosition) {
    for (var i = 0; i < _foods.length; i++) {
      var food = _foods[i];
      if (!food.isCollected) {
        final foodRect = Rect.fromCenter(
          center: food.position,
          width: 40,
          height: 40,
        );
        if (foodRect.contains(tapPosition)) {
          _foods[i] = FoodItem(
            position: food.position,
            isCollected: true,
          );
          _score += 10;
          notifyListeners();
          break;
        }
      }
    }
  }

  Future<void> finishGame() async {
    try {
      _gameTimer?.cancel();
      await _gameService.playFeedingGame();
      await _navigationService.back();
    } catch (e) {
      setError('Failed to complete feeding game: ${e.toString()}');
    }
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    super.dispose();
  }
}
