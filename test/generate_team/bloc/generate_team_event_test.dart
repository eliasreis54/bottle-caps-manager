// ignore_for_file: prefer_const_constructors

import 'package:bottle_caps_manager/generate_team/bloc/generate_team_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GenerateTeamEvent', () {
    group('GenerateTeamPlayerAdded', () {
      test('can be instantiated', () {
        final event = GenerateTeamPlayerAdded(playerName: '');
        expect(event, isNotNull);
      });

      test('supports value equiality', () {
        final eventA = GenerateTeamPlayerAdded(playerName: 'name');
        final eventB = GenerateTeamPlayerAdded(playerName: 'name');

        expect(eventA, isNot(same(eventB)));
        expect(eventA, equals(eventB));
      });
    });

    group('GenerateTeamPlayerRemoved', () {
      test('can be instantiated', () {
        final event = GenerateTeamPlayerRemoved(playerIndex: 1);
        expect(event, isNotNull);
      });

      test('supports value equiality', () {
        final eventA = GenerateTeamPlayerRemoved(playerIndex: 1);
        final eventB = GenerateTeamPlayerRemoved(playerIndex: 1);

        expect(eventA, isNot(same(eventB)));
        expect(eventA, equals(eventB));
      });
    });

    group('GenerateTeamRequested', () {
      test('can be instantiated', () {
        final event = GenerateTeamRequested();
        expect(event, isNotNull);
      });

      test('supports value equiality', () {
        final eventA = GenerateTeamRequested();
        final eventB = GenerateTeamRequested();

        expect(eventA, isNot(same(eventB)));
        expect(eventA, equals(eventB));
      });
    });

    group('GenerateTeamRedoRequested', () {
      test('can be instantiated', () {
        final event = GenerateTeamRedoRequested();
        expect(event, isNotNull);
      });

      test('supports value equiality', () {
        final eventA = GenerateTeamRedoRequested();
        final eventB = GenerateTeamRedoRequested();

        expect(eventA, isNot(same(eventB)));
        expect(eventA, equals(eventB));
      });
    });
  });
}
