part of 'navigation_bloc.dart';

@immutable
sealed class NavigationEvent {}

class ChangingSelectedOption extends NavigationEvent {
  final int newSelectedIndex;

  ChangingSelectedOption({required this.newSelectedIndex});
}
