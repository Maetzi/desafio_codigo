part of 'navigation_bloc.dart';

class NavigationState {
  final int selectedOption;

  const NavigationState({required this.selectedOption});

  NavigationState copyWth(int selectedOption) {
    return NavigationState(selectedOption: selectedOption);
  }
}

final class NavigationInitial extends NavigationState {
  const NavigationInitial({selectedOption = 0}) : super(selectedOption: 0);
}
