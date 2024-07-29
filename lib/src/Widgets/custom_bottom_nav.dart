import 'package:flutter/material.dart';

import '../common.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({
    super.key,
    required this.selectedIndex,
    this.onDestinationSelected,
  });

  final int selectedIndex;
  final void Function(int)? onDestinationSelected;

  static const List<Map<String, dynamic>> options = [
    {
      'icon': Icon(Icons.home_outlined),
      'label': 'Home',
      'selectedIcon': Icon(Icons.home_filled),
    },
    {
      'icon': Icon(Icons.explore_outlined),
      'label': 'Explore',
      'selectedIcon': Icon(Icons.explore),
    },
    {
      'icon': Icon(Icons.favorite_border),
      'label': 'Favorite',
      'selectedIcon': Icon(Icons.favorite),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: options
          .map((e) => NavigationDestination(
                icon: e['icon'],
                label: e['label'],
                selectedIcon: e['selectedIcon'],
              ))
          .toList(),
      indicatorColor: kSecondaryColor.withOpacity(0.4),
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
    );
  }
}
