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
    if (participants.length < 2) {
      throw InsuficientParticipantsException();
    }

    participants.shuffle();

    final participantsNumber = (participants.length / 2).floor();

    final teamA = participants.getRange(
      participantsNumber,
      participants.length,
    );
    final teamB = participants.getRange(0, participantsNumber);

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

  /// Given a list of the winners and a list of next players
  /// merge winners with the new players.
  Opponents mergeTeams({
    required Team winners,
    required Team nextPlayers,
  }) {
    winners.teamPlayers.shuffle();
    nextPlayers.teamPlayers.shuffle();

    final newTeamA = [
      ...winners.teamPlayers.getRange(0, 3),
      ...nextPlayers.teamPlayers.getRange(0, 3)
    ].toList();

    final newTeamB = [
      ...winners.teamPlayers.getRange(3, 6),
      ...nextPlayers.teamPlayers.getRange(3, 6)
    ].toList();

    return Opponents(
      teamA: Team(
        name: 'Team A',
        teamPlayers: newTeamA,
      ),
      teamB: Team(
        name: '',
        teamPlayers: newTeamB,
      ),
    );
  }
}
