import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc.dart';
import '../../services.dart';
import 'widgets/home_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final unsplashService = UnsplashService();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ImageListBloc>(
          create: (BuildContext context) => ImageListBloc(unsplashService),
        ),
        BlocProvider<NavigationBloc>(
          create: (BuildContext context) => NavigationBloc(),
        ),
        BlocProvider<TopicListBloc>(
          create: (BuildContext context) => TopicListBloc(unsplashService),
        ),
      ],
      child: const HomeScaffold(),
    );
  }
}
