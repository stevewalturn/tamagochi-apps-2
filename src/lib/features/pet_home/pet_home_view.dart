import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/pet_home/pet_home_viewmodel.dart';
import 'package:my_app/ui/common/app_colors.dart';
import 'package:my_app/ui/widgets/pet_sprite/pet_sprite.dart';
import 'package:my_app/ui/widgets/action_button/action_button.dart';
import 'package:my_app/ui/widgets/stat_bar/stat_bar.dart';

class PetHomeView extends StackedView<PetHomeViewModel> {
  const PetHomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, PetHomeViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.petName),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: viewModel.openShop,
          ),
        ],
      ),
      body: viewModel.hasPet
          ? Padding(
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
                  PetSprite(
                    petType: viewModel.petType,
                    state: viewModel.petState,
                    size: 200,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    viewModel.stateDisplay,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    viewModel.ageDisplay,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  StatBar(
                    label: 'Hunger',
                    value: viewModel.hunger,
                    color: kcHungerColor,
                  ),
                  const SizedBox(height: 8),
                  StatBar(
                    label: 'Happiness',
                    value: viewModel.happiness,
                    color: kcHappinessColor,
                  ),
                  const SizedBox(height: 8),
                  StatBar(
                    label: 'Health',
                    value: viewModel.health,
                    color: kcHealthColor,
                  ),
                  const SizedBox(height: 8),
                  StatBar(
                    label: 'Cleanliness',
                    value: viewModel.cleanliness,
                    color: kcCleanlinessColor,
                  ),
                  const SizedBox(height: 8),
                  StatBar(
                    label: 'Energy',
                    value: viewModel.energy,
                    color: kcEnergyColor,
                  ),
                  const Spacer(),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ActionButton(
                        label: 'Feed',
                        icon: Icons.restaurant,
                        onPressed: viewModel.startFeedingGame,
                        isEnabled: viewModel.isAlive,
                      ),
                      ActionButton(
                        label: 'Clean',
                        icon: Icons.cleaning_services,
                        onPressed: viewModel.startCleaningGame,
                        isEnabled: viewModel.isAlive,
                      ),
                      ActionButton(
                        label: 'Exercise',
                        icon: Icons.fitness_center,
                        onPressed: viewModel.startExerciseGame,
                        isEnabled: viewModel.isAlive,
                      ),
                    ],
                  ),
                ],
              ),
            )
          : const Center(
              child: Text('No pet found. Please create a new pet.'),
            ),
    );
  }

  @override
  PetHomeViewModel viewModelBuilder(BuildContext context) => PetHomeViewModel();

  @override
  void onViewModelReady(PetHomeViewModel viewModel) => viewModel.init();
}
