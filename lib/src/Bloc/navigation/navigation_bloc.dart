import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationInitial()) {
    on<ChangingSelectedOption>(_onChangingSelectedOption);
  }

  void _onChangingSelectedOption(event, emit) {
    emit(state.copyWth(event.newSelectedIndex));
  }
}
