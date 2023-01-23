/// {@template team_class}
/// A class to represent a team.
/// {@endtemplate}
class Team {
  /// {@team_class}
  Team({
    required this.name,
    required this.teamPlayers,
  });

  /// The team name.
  final String name;

  /// The team players.
  final List<String> teamPlayers;
}
