import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/mini_games/feeding/feeding_game_viewmodel.dart';
import 'package:my_app/ui/common/app_colors.dart';

class FeedingGameView extends StackedView<FeedingGameViewModel> {
  const FeedingGameView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, FeedingGameViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feeding Time'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              if (viewModel.modelError != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    viewModel.modelError.toString(),
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              Text(
                'Score: ${viewModel.score.toStringAsFixed(0)}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GestureDetector(
                  onTapDown: (details) =>
                      viewModel.onTapFood(details.localPosition),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: kcPrimaryColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        for (var food in viewModel.foods)
                          Positioned(
                            left: food.position.dx,
                            top: food.position.dy,
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: Center(
                                child: Text(
                                  '🍎',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: food.isCollected
                                        ? Colors.grey
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Tap the falling food items to feed your pet!',
                style: TextStyle(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: viewModel.finishGame,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kcPrimaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text('Finish Feeding'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  FeedingGameViewModel viewModelBuilder(BuildContext context) =>
      FeedingGameViewModel();

  @override
  void onViewModelReady(FeedingGameViewModel viewModel) =>
      viewModel.startGame();

  @override
  void onDispose(FeedingGameViewModel viewModel) => viewModel.dispose();
}
