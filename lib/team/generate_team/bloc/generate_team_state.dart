part of 'generate_team_bloc.dart';

abstract class GenerateTeamState extends Equatable {
  const GenerateTeamState();
}

class GenerateTeamStateSuccess extends GenerateTeamState {
  const GenerateTeamStateSuccess({
    required this.players,
  });

  final List<String> players;

  @override
  List<Object> get props => [
        players,
      ];
}

class GenerateTeamStateInsuficientParticipants extends GenerateTeamState {
  @override
  List<Object?> get props => [];
}

class GenerateTeamStateEmptyName extends GenerateTeamState {
  @override
  List<Object?> get props => [];
}

class GenerateTeamStateOpponents extends GenerateTeamState {
  const GenerateTeamStateOpponents({
    required this.teamA,
    required this.teamB,
  });

  final List<String> teamA;
  final List<String> teamB;
  @override
  List<Object?> get props => [
        teamA,
        teamB,
      ];
}
