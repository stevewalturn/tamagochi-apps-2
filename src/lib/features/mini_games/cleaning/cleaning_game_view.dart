import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/mini_games/cleaning/cleaning_game_viewmodel.dart';
import 'package:my_app/ui/common/app_colors.dart';

class CleaningGameView extends StackedView<CleaningGameViewModel> {
  const CleaningGameView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, CleaningGameViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cleaning Time'),
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
                'Cleanliness: ${viewModel.cleanlinessScore.toStringAsFixed(0)}%',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GestureDetector(
                  onPanUpdate: viewModel.onDrag,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: kcPrimaryColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CustomPaint(
                      painter: CleaningPainter(
                        cleanedAreas: viewModel.cleanedAreas,
                      ),
                      child: Container(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Drag your finger to clean your pet!',
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
                child: const Text('Finish Cleaning'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  CleaningGameViewModel viewModelBuilder(BuildContext context) =>
      CleaningGameViewModel();
}

class CleaningPainter extends CustomPainter {
  final List<Offset> cleanedAreas;

  CleaningPainter({required this.cleanedAreas});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.withOpacity(0.3)
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < cleanedAreas.length - 1; i++) {
      canvas.drawLine(cleanedAreas[i], cleanedAreas[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(CleaningPainter oldDelegate) => true;
}
