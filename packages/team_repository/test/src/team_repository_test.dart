// ignore_for_file: prefer_const_constructors
import 'package:team_repository/team_repository.dart';
import 'package:test/test.dart';

void main() {
  group('TeamRepository', () {
    late TeamRepository teamRepository;

    setUp(() {
      teamRepository = TeamRepository();
    });

    test('can be instantiated', () {
      expect(TeamRepository(), isNotNull);
    });

    group('generateOpponents', () {
      test('returns Opponents when participants list is valid', () {
        final opponents = teamRepository.generateOpponents([
          '1',
          '2',
          '3',
          '4',
          '5',
          '6',
          '7',
          '8',
          '9',
          '10',
          '11',
          '12',
        ]);

        expect(opponents, isNotNull);

        expect(
          opponents.teamA.teamPlayers,
          isNot(
            containsAll(
              opponents.teamB.teamPlayers,
            ),
          ),
        );
      });

      test(
        'throws [InsuficientParticipantsException] '
        'when participants list is not valid',
        () {
          expect(
            () => teamRepository.generateOpponents([]),
            throwsA(isA<InsuficientParticipantsException>()),
          );
        },
      );
    });

    group('mergeTeams', () {
      test('merge winners and next players', () {
        final winners = Team(
          name: 'winners',
          teamPlayers: ['1', '2', '3', '4', '5', '6'],
        );

        final nextPlayers = Team(
          name: 'winners',
          teamPlayers: ['7', '8', '9', '10', '11', '12'],
        );

        final opponents = teamRepository.mergeTeams(
          winners: winners,
          nextPlayers: nextPlayers,
        );

        var numberOfWinnersInTheATeam = 0;
        var numberOfWinnersInTheBTeam = 0;

        for (final element in opponents.teamA.teamPlayers) {
          if (winners.teamPlayers.contains(element)) {
            numberOfWinnersInTheATeam++;
          }
        }

        for (final element in opponents.teamB.teamPlayers) {
          if (winners.teamPlayers.contains(element)) {
            numberOfWinnersInTheBTeam++;
          }
        }

        expect(numberOfWinnersInTheATeam, equals(3));
        expect(numberOfWinnersInTheBTeam, equals(3));

        expect(
          opponents.teamA.teamPlayers,
          isNot(
            equals(opponents.teamB.teamPlayers),
          ),
        );
      });
    });
  });
}
