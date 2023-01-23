import 'package:team_repository/src/exceptions/exceptions.dart';
import 'package:team_repository/src/models/models.dart';

/// {@template team_repository}
/// The repository to deal with team.
/// {@endtemplate}
class TeamRepository {
  /// {@macro team_repository}
  const TeamRepository();

  /// Given a list of 12 elements, returns [Opponents].
  Opponents generateOpponents(List<String> participants) {
    if (participants.length < 12) {
      throw InsuficientParticipantsException();
    }

    participants.shuffle();
    final teamA = participants.getRange(0, 6);
    final teamB = participants.getRange(6, 12);

    return Opponents(
      teamA: Team(
        name: 'Team A',
        teamPlayers: teamA.toList(),
      ),
      teamB: Team(
        name: 'Team b',
        teamPlayers: teamB.toList(),
      ),
    );
  }
}
