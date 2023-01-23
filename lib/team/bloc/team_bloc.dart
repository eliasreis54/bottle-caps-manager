import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'team_event.dart';
part 'team_state.dart';

class TeamBloc extends Bloc<TeamEvent, TeamState> {
  TeamBloc() : super(const TeamState.initial()) {
    on<TeamEvent>((event, emit) {});
  }
}
