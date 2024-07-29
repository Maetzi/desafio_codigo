import 'package:flutter/material.dart';

import '../../../common.dart';
import '../../../screens.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  State createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: RichText(
        text: const TextSpan(
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'Un',
            ),
            TextSpan(
              style: TextStyle(color: kPrimaryColor),
              text: 'Splash',
            )
          ],
        ),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SearchScreen()),
            );
          },
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }
}
