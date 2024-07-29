import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc.dart';
import '../../services.dart';
import 'widgets/search_scaffold.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final unsplashService = UnsplashService();

    return BlocProvider(
      create: (context) => ImageListBloc(unsplashService),
      child: const SearchScaffold(),
    );
  }
}
