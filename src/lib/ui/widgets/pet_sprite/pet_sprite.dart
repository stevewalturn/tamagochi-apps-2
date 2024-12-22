import 'package:flutter/material.dart';
import 'package:my_app/models/enums/pet_state.dart';

class PetSprite extends StatelessWidget {
  final String petType;
  final PetState state;
  final double size;

  const PetSprite({
    super.key,
    required this.petType,
    required this.state,
    this.size = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          _getEmoji(),
          style: TextStyle(
            fontSize: size * 0.5,
          ),
        ),
      ),
    );
  }

  String _getEmoji() {
    switch (state) {
      case PetState.egg:
        return '🥚';
      case PetState.dead:
        return '💀';
      default:
        switch (petType) {
          case 'cat':
            return '🐱';
          case 'dog':
            return '🐶';
          case 'rabbit':
            return '🐰';
          default:
            return '🐣';
        }
    }
  }

  Color _getBackgroundColor() {
    switch (state) {
      case PetState.egg:
        return Colors.amber.withOpacity(0.3);
      case PetState.dead:
        return Colors.grey.withOpacity(0.3);
      default:
        return Colors.transparent;
    }
  }
}
