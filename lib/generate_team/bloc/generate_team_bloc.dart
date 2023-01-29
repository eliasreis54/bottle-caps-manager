import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:team_repository/team_repository.dart';

part 'generate_team_event.dart';
part 'generate_team_state.dart';

class GenerateTeamBloc extends Bloc<GenerateTeamEvent, GenerateTeamState> {
  GenerateTeamBloc({
    required TeamRepository teamRepository,
  })  : _teamRepository = teamRepository,
        super(const GenerateTeamStateSuccess(players: [])) {
    on<GenerateTeamPlayerAdded>(_onGenerateTeamPlayerAdded);
    on<GenerateTeamPlayerRemoved>(_onGenerateTeamPlayerRemoved);
    on<GenerateTeamRequested>(_onGenerateTeamRequested);
    on<GenerateTeamRedoRequested>(_onGenerateTeamRedoRequested);
  }

  final TeamRepository _teamRepository;

  void _onGenerateTeamPlayerAdded(
    GenerateTeamPlayerAdded event,
    Emitter<GenerateTeamState> emit,
  ) {
    if (event.playerName.isEmpty) {
      return emit(GenerateTeamStateEmptyName());
    } else {
      late List<String> players;
      if (state is GenerateTeamStateSuccess) {
        players = [
          event.playerName,
          ...(state as GenerateTeamStateSuccess).players,
        ];
      } else {
        players = [event.playerName];
      }
      emit(
        GenerateTeamStateSuccess(
          players: players,
        ),
      );
    }
  }

  void _onGenerateTeamPlayerRemoved(
    GenerateTeamPlayerRemoved event,
    Emitter<GenerateTeamState> emit,
  ) {
    final players = [...(state as GenerateTeamStateSuccess).players]
      ..removeAt(event.playerIndex);
    emit(
      GenerateTeamStateSuccess(
        players: players,
      ),
    );
  }

  void _onGenerateTeamRedoRequested(
    GenerateTeamRedoRequested event,
    Emitter<GenerateTeamState> emit,
  ) {
    emit(
      const GenerateTeamStateSuccess(
        players: [],
      ),
    );
  }

  void _onGenerateTeamRequested(
    GenerateTeamRequested event,
    Emitter<GenerateTeamState> emit,
  ) {
    try {
      final opponents = _teamRepository.generateOpponents(
        (state as GenerateTeamStateSuccess).players,
      );

      emit(
        GenerateTeamStateOpponents(
          teamA: opponents.teamA.teamPlayers,
          teamB: opponents.teamB.teamPlayers,
        ),
      );
    } on InsuficientParticipantsException {
      emit(GenerateTeamStateInsuficientParticipants());
    }
  }
}
