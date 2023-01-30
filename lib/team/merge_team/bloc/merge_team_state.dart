part of 'merge_team_bloc.dart';

enum MergeTeamSteps {
  addWinners,

  addNextPlayers,

  opponentsReady,
}

enum MergeTeamStatus {
  ready,
  error,
}

class MergeTeamState extends Equatable {
  const MergeTeamState({
    this.winners = const Team(name: '', teamPlayers: []),
    this.nextPlayers = const Team(name: '', teamPlayers: []),
    this.step = MergeTeamSteps.addWinners,
    this.opponents,
    this.status = MergeTeamStatus.ready,
  });

  const MergeTeamState.initial() : this();

  final Team winners;
  final Team nextPlayers;
  final MergeTeamSteps step;
  final Opponents? opponents;
  final MergeTeamStatus status;

  @override
  List<Object?> get props => [
        winners,
        nextPlayers,
        step,
        opponents,
        status,
      ];

  MergeTeamState copyWith({
    Team? winners,
    Team? nextPlayers,
    MergeTeamSteps? step,
    Opponents? opponents,
    MergeTeamStatus status = MergeTeamStatus.ready,
  }) {
    return MergeTeamState(
      winners: winners ?? this.winners,
      nextPlayers: nextPlayers ?? this.nextPlayers,
      step: step ?? this.step,
      opponents: opponents ?? this.opponents,
      status: status,
    );
  }
}
