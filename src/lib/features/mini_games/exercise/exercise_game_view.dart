import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/mini_games/exercise/exercise_game_viewmodel.dart';
import 'package:my_app/ui/common/app_colors.dart';

class ExerciseGameView extends StackedView<ExerciseGameViewModel> {
  const ExerciseGameView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, ExerciseGameViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise Time'),
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
                'Exercise Points: ${viewModel.exercisePoints}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: viewModel.isJumping ? 100 : 120,
                    height: viewModel.isJumping ? 120 : 100,
                    child: GestureDetector(
                      onTapDown: (_) => viewModel.startJump(),
                      onTapUp: (_) => viewModel.stopJump(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: kcPrimaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            '🏃',
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Tap and hold to make your pet exercise!',
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
                child: const Text('Finish Exercise'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  ExerciseGameViewModel viewModelBuilder(BuildContext context) =>
      ExerciseGameViewModel();

  @override
  void onDispose(ExerciseGameViewModel viewModel) => viewModel.dispose();
}
