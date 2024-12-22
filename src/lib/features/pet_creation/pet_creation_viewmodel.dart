import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.router.dart';
import 'package:my_app/services/pet_service.dart';

class PetCreationViewModel extends BaseViewModel {
  final _petService = locator<PetService>();
  final _navigationService = locator<NavigationService>();

  String _name = '';
  String? _selectedType;

  String? get selectedType => _selectedType;

  void setName(String value) {
    _name = value;
  }

  void setType(String type) {
    _selectedType = type;
    notifyListeners();
  }

  Future<void> createPet() async {
    if (_name.isEmpty) {
      setError('Please enter a name for your pet');
      return;
    }

    if (_selectedType == null) {
      setError('Please select a pet type');
      return;
    }

    try {
      setBusy(true);
      _petService.createPet(
        name: _name,
        type: _selectedType!,
      );
      await _navigationService.replaceWithPetHomeView();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }
}
