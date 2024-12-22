enum PetState {
  egg,
  baby,
  child,
  teen,
  adult,
  senior,
  dead;

  bool get isAlive => this != PetState.dead;
  bool get canEvolve => this != PetState.senior && this != PetState.dead;

  PetState get nextState {
    switch (this) {
      case PetState.egg:
        return PetState.baby;
      case PetState.baby:
        return PetState.child;
      case PetState.child:
        return PetState.teen;
      case PetState.teen:
        return PetState.adult;
      case PetState.adult:
        return PetState.senior;
      case PetState.senior:
      case PetState.dead:
        return PetState.dead;
    }
  }

  String get displayName {
    switch (this) {
      case PetState.egg:
        return 'Egg';
      case PetState.baby:
        return 'Baby';
      case PetState.child:
        return 'Child';
      case PetState.teen:
        return 'Teen';
      case PetState.adult:
        return 'Adult';
      case PetState.senior:
        return 'Senior';
      case PetState.dead:
        return 'Dead';
    }
  }
}
