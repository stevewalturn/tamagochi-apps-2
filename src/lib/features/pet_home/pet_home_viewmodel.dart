import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.router.dart';
import 'package:my_app/services/pet_service.dart';
import 'package:my_app/services/time_service.dart';
import 'package:my_app/models/enums/pet_state.dart';

class PetHomeViewModel extends BaseViewModel {
  final _petService = locator<PetService>();
  final _timeService = locator<TimeService>();
  final _navigationService = locator<NavigationService>();
  final _bottomSheetService = locator<BottomSheetService>();

  bool get hasPet => _petService.hasPet;
  bool get isAlive => _petService.currentPet?.isAlive ?? false;

  String get petName => _petService.currentPet?.name ?? 'No Pet';
  String get petType => _petService.currentPet?.type ?? '';
  PetState get petState => _petService.currentPet?.state ?? PetState.egg;

  String get stateDisplay => _petService.currentPet?.state.displayName ?? 'N/A';
  String get ageDisplay {
    final days = _petService.currentPet?.ageInDays ?? 0;
    if (days == 0) return 'Just born';
    if (days == 1) return '1 day old';
    return '$days days old';
  }

  double get hunger => _petService.currentPet?.hunger ?? 0;
  double get happiness => _petService.currentPet?.happiness ?? 0;
  double get health => _petService.currentPet?.health ?? 0;
  double get cleanliness => _petService.currentPet?.cleanliness ?? 0;
  double get energy => _petService.currentPet?.energy ?? 0;

  void init() {
    if (!hasPet) {
      _navigationService.replaceWithPetCreationView();
      return;
    }
    _timeService.startGameLoop();
  }

  Future<void> openShop() async {
    try {
      final response = await _bottomSheetService.showCustomSheet(
        variant: 'petShop',
        title: 'Pet Shop',
        description: 'Buy items for your pet',
      );

      if (response?.data != null) {
        // Handle shop item purchase
        setError('Item purchased successfully!');
      }
    } catch (e) {
      setError('Failed to open shop: ${e.toString()}');
    }
  }

  Future<void> startFeedingGame() async {
    if (!isAlive) {
      setError('Cannot feed a deceased pet');
      return;
    }
    await _navigationService.navigateToFeedingGameView();
  }

  Future<void> startCleaningGame() async {
    if (!isAlive) {
      setError('Cannot clean a deceased pet');
      return;
    }
    await _navigationService.navigateToCleaningGameView();
  }

  Future<void> startExerciseGame() async {
    if (!isAlive) {
      setError('Cannot exercise a deceased pet');
      return;
    }
    await _navigationService.navigateToExerciseGameView();
  }

  @override
  void dispose() {
    _timeService.dispose();
    super.dispose();
  }
}
