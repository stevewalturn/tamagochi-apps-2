import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/models/enums/pet_state.dart';
import 'package:my_app/ui/widgets/pet_sprite/pet_sprite.dart';
import 'package:my_app/models/pet.dart';

class PetEvolutionDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const PetEvolutionDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Pet pet = request.data['pet'] as Pet;
    final PetState newState = request.data['newState'] as PetState;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '\ud83c\udf89 Evolution Time! \ud83c\udf89',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    PetSprite(
                      petType: pet.type,
                      state: pet.state,
                      size: 100,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      pet.state.displayName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward,
                  size: 30,
                ),
                Column(
                  children: [
                    PetSprite(
                      petType: pet.type,
                      state: newState,
                      size: 100,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      newState.displayName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Congratulations! ${pet.name} has evolved into a ${newState.displayName}!',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => completer(DialogResponse(confirmed: true)),
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}