import 'package:flutter/material.dart';

import 'src/common.dart'
    show kBgColor, kErrorColor, kPrimaryColor, kSecondaryColor;
import 'src/screens.dart' show HomeScreen;

class DesafioApp extends StatelessWidget {
  const DesafioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBgColor,
        colorScheme: const ColorScheme.light(
          primary: kPrimaryColor,
          secondary: kSecondaryColor,
          error: kErrorColor,
        ),
      ),
      title: 'UnSplash',
      home: const HomeScreen(),
    );
  }
}
