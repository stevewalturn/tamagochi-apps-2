import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/ui/common/app_colors.dart';

class PetShopSheet extends StatelessWidget {
  final Function(SheetResponse)? completer;
  final SheetRequest request;

  const PetShopSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Pet Shop',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _ShopItem(
            name: 'Food Pack',
            price: '10 coins',
            icon: Icons.fastfood,
            onTap: () => completer?.call(SheetResponse(data: 'food')),
          ),
          _ShopItem(
            name: 'Toy Pack',
            price: '15 coins',
            icon: Icons.toys,
            onTap: () => completer?.call(SheetResponse(data: 'toy')),
          ),
          _ShopItem(
            name: 'Medicine Pack',
            price: '20 coins',
            icon: Icons.medical_services,
            onTap: () => completer?.call(SheetResponse(data: 'medicine')),
          ),
        ],
      ),
    );
  }
}

class _ShopItem extends StatelessWidget {
  final String name;
  final String price;
  final IconData icon;
  final VoidCallback onTap;

  const _ShopItem({
    required this.name,
    required this.price,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: kcPrimaryColor),
      title: Text(name),
      subtitle: Text(price),
      trailing: ElevatedButton(
        onPressed: onTap,
        child: const Text('Buy'),
      ),
    );
  }
}
