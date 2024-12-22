import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/pet_stats/pet_stats_viewmodel.dart';
import 'package:my_app/ui/common/app_colors.dart';
import 'package:my_app/ui/widgets/stat_bar/stat_bar.dart';

class PetStatsView extends StackedView<PetStatsViewModel> {
  const PetStatsView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, PetStatsViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Statistics'),
      ),
      body: viewModel.hasPet
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Current Status',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'State: ${viewModel.stateDisplay}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Age: ${viewModel.ageDisplay}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Stats',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
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
                ],
              ),
            )
          : const Center(
              child: Text('No pet found'),
            ),
    );
  }

  @override
  PetStatsViewModel viewModelBuilder(BuildContext context) =>
      PetStatsViewModel();
}
