import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc.dart';
import '../../../widgets.dart';
import '../tabs/Explore/explore_tab.dart';
import '../tabs/Fav/fav_tab.dart';
import '../tabs/Home/home_tab.dart';
import 'top_fav_bar.dart';
import 'home_app_bar.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({super.key});

  static const tabs = [
    HomeTab(),
    ExploreTab(),
    FavTab(),
  ];

  static const topBars = <PreferredSizeWidget?>[
    HomeAppBar(),
    null,
    TopFavBar(),
  ];

  @override
  Widget build(BuildContext context) {
    void changeDestination(int newSelected) {
      final navigationBloc = context.read<NavigationBloc>();

      navigationBloc.add(ChangingSelectedOption(newSelectedIndex: newSelected));
    }

    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        final index = state.selectedOption;

        return Scaffold(
          appBar: topBars[index],
          bottomNavigationBar: CustomBottomNav(
            selectedIndex: index,
            onDestinationSelected: changeDestination,
          ),
          body: tabs[index],
        );
      },
    );
  }
}
