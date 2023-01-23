// ignore_for_file: prefer_const_constructors
import 'package:team_repository/src/exceptions/exceptions.dart';
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
  });
}
