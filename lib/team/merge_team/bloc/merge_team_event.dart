part of 'merge_team_bloc.dart';

abstract class MergeTeamEvent extends Equatable {
  const MergeTeamEvent();
}

class MergeTeamWinnerPlayerAdded extends MergeTeamEvent {
  const MergeTeamWinnerPlayerAdded({
    required this.playName,
  });

  final String playName;

  @override
  List<Object?> get props => [
        playName,
      ];
}

class MergeTeamWinnerRemoved extends MergeTeamEvent {
  const MergeTeamWinnerRemoved({
    required this.playerIndex,
  });

  final int playerIndex;

  @override
  List<Object?> get props => [
        playerIndex,
      ];
}

class MergeTeamNextPlayerRemoved extends MergeTeamEvent {
  const MergeTeamNextPlayerRemoved({
    required this.playerIndex,
  });

  final int playerIndex;

  @override
  List<Object?> get props => [
        playerIndex,
      ];
}

class MergeTeamNextPlayerAdded extends MergeTeamEvent {
  const MergeTeamNextPlayerAdded({
    required this.playName,
  });

  final String playName;

  @override
  List<Object?> get props => [
        playName,
      ];
}

class MergeTeamMergeRequested extends MergeTeamEvent {
  const MergeTeamMergeRequested();

  @override
  List<Object?> get props => [];
}

class MergeTeamMergeRedoRequested extends MergeTeamEvent {
  const MergeTeamMergeRedoRequested();

  @override
  List<Object?> get props => [];
}

class MergeTeamNextStep extends MergeTeamEvent {
  const MergeTeamNextStep({
    required this.step,
  });

  final MergeTeamSteps step;

  @override
  List<Object?> get props => [];
}
