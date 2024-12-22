import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/ui/widgets/pet_sprite/pet_sprite.dart';

class PetDeathDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const PetDeathDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pet = request.data['pet'];

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
              '😢 Farewell 😢',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            PetSprite(
              petType: pet.type,
              state: pet.state,
              size: 120,
            ),
            const SizedBox(height: 20),
            Text(
              'Rest in peace, ${pet.name}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Lived for ${pet.ageInDays} days',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your pet has passed away. Take good care of your next pet!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => completer(DialogResponse(confirmed: true)),
              child: const Text('Start New Journey'),
            ),
          ],
        ),
      ),
    );
  }
}
