import 'package:team_repository/src/models/models.dart';
import 'package:test/test.dart';

void main() {
  group('Team class', () {
    test('can be instantiated', () {
      expect(
        Team(
          name: '',
          teamPlayers: [],
        ),
        isNotNull,
      );
    });
  });
}
