import 'package:flutter/material.dart';

class TopFavBar extends StatefulWidget implements PreferredSizeWidget {
  const TopFavBar({super.key});

  @override
  State createState() => _TopFavBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}

class _TopFavBarState extends State<TopFavBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('My Favorites'),
    );
  }
}
