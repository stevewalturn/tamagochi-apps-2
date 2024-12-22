import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/pet_creation/pet_creation_viewmodel.dart';
import 'package:my_app/ui/common/app_colors.dart';
import 'package:my_app/ui/widgets/action_button/action_button.dart';

class PetCreationView extends StackedView<PetCreationViewModel> {
  const PetCreationView({Key? key}) : super(key: key);

  @override
  Widget builder(context, viewModel, child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Your Pet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Pet Name',
                hintText: 'Enter a name for your pet',
              ),
              onChanged: viewModel.setName,
            ),
            const SizedBox(height: 20),
            const Text(
              'Choose Pet Type:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: [
                _PetTypeOption(
                  type: 'cat',
                  emoji: '🐱',
                  isSelected: viewModel.selectedType == 'cat',
                  onSelect: viewModel.setType,
                ),
                _PetTypeOption(
                  type: 'dog',
                  emoji: '🐶',
                  isSelected: viewModel.selectedType == 'dog',
                  onSelect: viewModel.setType,
                ),
                _PetTypeOption(
                  type: 'rabbit',
                  emoji: '🐰',
                  isSelected: viewModel.selectedType == 'rabbit',
                  onSelect: viewModel.setType,
                ),
              ],
            ),
            const Spacer(),
            if (viewModel.modelError != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  viewModel.modelError.toString(),
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            ActionButton(
              label: 'Create Pet',
              icon: Icons.pets,
              onPressed: viewModel.createPet,
              color: kcPrimaryColor,
              isEnabled: !viewModel.isBusy,
            ),
          ],
        ),
      ),
    );
  }

  @override
  PetCreationViewModel viewModelBuilder(context) => PetCreationViewModel();
}

class _PetTypeOption extends StatelessWidget {
  final String type;
  final String emoji;
  final bool isSelected;
  final Function(String) onSelect;

  const _PetTypeOption({
    required this.type,
    required this.emoji,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelect(type),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? kcPrimaryColor : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 40),
            ),
            Text(
              type.toUpperCase(),
              style: TextStyle(
                color: isSelected ? kcPrimaryColor : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
