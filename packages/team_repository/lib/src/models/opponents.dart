import 'package:team_repository/src/models/models.dart';

/// {@template opponents_class}
/// A class to represent the current teams to play,
/// {@endtemplate}
class Opponents {
  /// {@opponents_class}
  Opponents({
    required this.teamA,
    required this.teamB,
    this.nextPlayers = const Team(
      name: '',
      teamPlayers: [],
    ),
  });

  /// The fisrt opponent.
  final Team teamA;

  /// The seccond opponent.
  final Team teamB;

  /// The next players.
  final Team nextPlayers;
}
