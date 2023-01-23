import 'package:team_repository/src/models/models.dart';
import 'package:test/test.dart';

void main() {
  group('Opponents class', () {
    test('can be instantiated', () {
      final team = Team(name: '', teamPlayers: []);
      expect(
        Opponents(teamA: team, teamB: team),
        isNotNull,
      );
    });
  });
}
