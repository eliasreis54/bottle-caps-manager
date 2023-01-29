// ignore_for_file: prefer_const_constructors

import 'package:bottle_caps_manager/generate_team/bloc/generate_team_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GenerateTeamState', () {
    group('GenerateTeamStateSuccess', () {
      test('can be instantiated', () {
        final state = GenerateTeamStateSuccess(players: const []);

        expect(state, isNotNull);
      });

      test('supports value equiality', () {
        final stateA = GenerateTeamStateSuccess(players: const []);
        final stateB = GenerateTeamStateSuccess(players: const []);

        expect(stateA, isNot(same(stateB)));
        expect(stateA, equals(stateB));
      });
    });

    group('GenerateTeamStateInsuficientParticipants', () {
      test('can be instantiated', () {
        final state = GenerateTeamStateInsuficientParticipants();

        expect(state, isNotNull);
      });

      test('supports value equiality', () {
        final stateA = GenerateTeamStateInsuficientParticipants();
        final stateB = GenerateTeamStateInsuficientParticipants();

        expect(stateA, isNot(same(stateB)));
        expect(stateA, equals(stateB));
      });
    });

    group('GenerateTeamStateEmptyName', () {
      test('can be instantiated', () {
        final state = GenerateTeamStateEmptyName();

        expect(state, isNotNull);
      });

      test('supports value equiality', () {
        final stateA = GenerateTeamStateEmptyName();
        final stateB = GenerateTeamStateEmptyName();

        expect(stateA, isNot(same(stateB)));
        expect(stateA, equals(stateB));
      });
    });

    group('GenerateTeamStateOpponents', () {
      test('can be instantiated', () {
        final state = GenerateTeamStateOpponents(
          teamA: const [],
          teamB: const [],
        );

        expect(state, isNotNull);
      });

      test('supports value equiality', () {
        final stateA = GenerateTeamStateOpponents(
          teamA: const [],
          teamB: const [],
        );
        final stateB = GenerateTeamStateOpponents(
          teamA: const [],
          teamB: const [],
        );

        expect(stateA, isNot(same(stateB)));
        expect(stateA, equals(stateB));
      });
    });
  });
}
