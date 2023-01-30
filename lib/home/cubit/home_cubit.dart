import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState(index: 0));

  void changeTabBarIndex(int newIndex) => emit(
        HomeState(index: newIndex),
      );
}
