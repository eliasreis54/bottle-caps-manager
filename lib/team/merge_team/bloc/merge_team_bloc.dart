import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:team_repository/team_repository.dart';

part 'merge_team_event.dart';
part 'merge_team_state.dart';

class MergeTeamBloc extends Bloc<MergeTeamEvent, MergeTeamState> {
  MergeTeamBloc({
    required TeamRepository teamRepository,
  })  : _teamRepository = teamRepository,
        super(const MergeTeamState.initial()) {
    on<MergeTeamWinnerPlayerAdded>(_onMergeTeamWinnerPlayerAdded);
    on<MergeTeamNextPlayerAdded>(_onMergeTeamNextPlayerAdded);
    on<MergeTeamMergeRequested>(_onMergeTeamMergeRequested);
    on<MergeTeamNextStep>(_onMergeTeamNextStep);
    on<MergeTeamMergeRedoRequested>(_onMergeTeamMergeRedoRequested);
    on<MergeTeamWinnerRemoved>(_onMergeTeamWinnerRemoved);
    on<MergeTeamNextPlayerRemoved>(_onMergeTeamNextPlayerRemoved);
  }

  final TeamRepository _teamRepository;

  void _onMergeTeamWinnerRemoved(
    MergeTeamWinnerRemoved event,
    Emitter<MergeTeamState> emit,
  ) {
    final players = [...state.winners.teamPlayers]..removeAt(event.playerIndex);
    emit(state.copyWith(winners: Team(name: '', teamPlayers: players)));
  }

  void _onMergeTeamNextPlayerRemoved(
    MergeTeamNextPlayerRemoved event,
    Emitter<MergeTeamState> emit,
  ) {
    final players = [...state.nextPlayers.teamPlayers]..removeAt(
        event.playerIndex,
      );

    emit(
      state.copyWith(
        nextPlayers: Team(
          name: '',
          teamPlayers: players,
        ),
      ),
    );
  }

  void _onMergeTeamMergeRedoRequested(
    MergeTeamMergeRedoRequested event,
    Emitter<MergeTeamState> emit,
  ) {
    emit(const MergeTeamState.initial());
  }

  void _onMergeTeamWinnerPlayerAdded(
    MergeTeamWinnerPlayerAdded event,
    Emitter<MergeTeamState> emit,
  ) {
    final newWinners = [event.playName, ...state.winners.teamPlayers];

    emit(
      state.copyWith(
        winners: Team(
          name: 'winners',
          teamPlayers: newWinners,
        ),
      ),
    );
  }

  void _onMergeTeamNextPlayerAdded(
    MergeTeamNextPlayerAdded event,
    Emitter<MergeTeamState> emit,
  ) {
    final newNextPlayers = [event.playName, ...state.nextPlayers.teamPlayers];

    emit(
      state.copyWith(
        nextPlayers: Team(
          name: 'next',
          teamPlayers: newNextPlayers,
        ),
      ),
    );
  }

  void _onMergeTeamMergeRequested(
    MergeTeamMergeRequested event,
    Emitter<MergeTeamState> emit,
  ) {
    if (state.winners.teamPlayers.length < 6 ||
        state.nextPlayers.teamPlayers.length < 6) {
      emit(
        state.copyWith(
          status: MergeTeamStatus.error,
        ),
      );
    }
    final opponents = _teamRepository.mergeTeams(
      winners: state.winners,
      nextPlayers: state.nextPlayers,
    );

    emit(
      state.copyWith(
        step: MergeTeamSteps.opponentsReady,
        opponents: opponents,
      ),
    );
  }

  void _onMergeTeamNextStep(
    MergeTeamNextStep event,
    Emitter<MergeTeamState> emit,
  ) {
    emit(
      state.copyWith(
        step: event.step,
      ),
    );
  }
}
