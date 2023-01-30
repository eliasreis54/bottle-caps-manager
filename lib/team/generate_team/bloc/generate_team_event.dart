part of 'generate_team_bloc.dart';

abstract class GenerateTeamEvent extends Equatable {
  const GenerateTeamEvent();
}

class GenerateTeamPlayerAdded extends GenerateTeamEvent {
  const GenerateTeamPlayerAdded({
    required this.playerName,
  });

  final String playerName;

  @override
  List<Object?> get props => [
        playerName,
      ];
}

class GenerateTeamPlayerRemoved extends GenerateTeamEvent {
  const GenerateTeamPlayerRemoved({
    required this.playerIndex,
  });

  final int playerIndex;

  @override
  List<Object?> get props => [
        playerIndex,
      ];
}

class GenerateTeamRequested extends GenerateTeamEvent {
  const GenerateTeamRequested();

  @override
  List<Object?> get props => [];
}

class GenerateTeamRedoRequested extends GenerateTeamEvent {
  const GenerateTeamRedoRequested();

  @override
  List<Object?> get props => [];
}
