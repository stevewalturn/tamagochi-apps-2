import 'package:stacked/stacked.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/services/pet_service.dart';
import 'package:my_app/models/pet.dart';

class PetStatsViewModel extends BaseViewModel {
  final _petService = locator<PetService>();

  Pet? get pet => _petService.currentPet;

  String get ageDisplay {
    if (pet == null) return 'N/A';
    final days = pet!.ageInDays;
    if (days == 0) return 'Just born';
    if (days == 1) return '1 day old';
    return '$days days old';
  }

  String get stateDisplay => pet?.state.displayName ?? 'N/A';

  double get hunger => pet?.hunger ?? 0;
  double get happiness => pet?.happiness ?? 0;
  double get health => pet?.health ?? 0;
  double get cleanliness => pet?.cleanliness ?? 0;
  double get energy => pet?.energy ?? 0;

  bool get hasPet => pet != null;
  bool get isAlive => pet?.isAlive ?? false;

  void refreshStats() {
    notifyListeners();
  }
}
