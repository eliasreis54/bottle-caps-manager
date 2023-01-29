// ignore_for_file: prefer_const_constructors, prefer_const_declarations

import 'package:bloc_test/bloc_test.dart';
import 'package:bottle_caps_manager/generate_team/bloc/generate_team_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:team_repository/team_repository.dart';

class MockTeamRepository extends Mock implements TeamRepository {}

void main() {
  group('GenerateTeamBloc', () {
    late TeamRepository teamRepository;

    setUp(() {
      teamRepository = MockTeamRepository();
    });

    test('initial state', () {
      final bloc = GenerateTeamBloc(
        teamRepository: teamRepository,
      );

      expect(
        bloc.state,
        equals(
          GenerateTeamStateSuccess(
            players: const [],
          ),
        ),
      );
    });

    group('GenerateTeamPlayerAdded', () {
      final playerName = 'playerName';
      blocTest<GenerateTeamBloc, GenerateTeamState>(
        'emits [GenerateTeamStateSuccess] when a new player is added',
        build: () => GenerateTeamBloc(teamRepository: teamRepository),
        act: (bloc) => bloc.add(
          GenerateTeamPlayerAdded(playerName: playerName),
        ),
        expect: () => [
          GenerateTeamStateSuccess(players: [playerName]),
        ],
      );

      blocTest<GenerateTeamBloc, GenerateTeamState>(
        'emits [GenerateTeamStateEmptyName] '
        'when a new player with empty name is added',
        build: () => GenerateTeamBloc(teamRepository: teamRepository),
        act: (bloc) => bloc.add(
          GenerateTeamPlayerAdded(playerName: ''),
        ),
        expect: () => [
          GenerateTeamStateEmptyName(),
        ],
      );

      blocTest<GenerateTeamBloc, GenerateTeamState>(
        'emits [GenerateTeamStateSuccess] '
        'when previous state is not [GenerateTeamStateSuccess]',
        build: () => GenerateTeamBloc(teamRepository: teamRepository),
        seed: GenerateTeamStateEmptyName.new,
        act: (bloc) => bloc.add(
          GenerateTeamPlayerAdded(playerName: playerName),
        ),
        expect: () => [
          GenerateTeamStateSuccess(players: [playerName]),
        ],
      );
    });

    group('GenerateTeamPlayerRemoved', () {
      final player = 'player';
      final playersList = [player, 'player1', 'player2'];

      blocTest<GenerateTeamBloc, GenerateTeamState>(
        'emits [GenerateTeamStateSuccess] when a players is removed',
        build: () => GenerateTeamBloc(teamRepository: teamRepository),
        seed: () => GenerateTeamStateSuccess(players: playersList),
        act: (bloc) => bloc.add(GenerateTeamPlayerRemoved(playerIndex: 0)),
        expect: () => [
          isA<GenerateTeamStateSuccess>().having(
            (e) => e.players,
            'players',
            equals(['player1', 'player2']),
          )
        ],
      );
    });

    group('GenerateTeamRequested', () {
      blocTest<GenerateTeamBloc, GenerateTeamState>(
        'emits [GenerateTeamStateOpponents] when generate team is requested',
        setUp: () {
          when(() => teamRepository.generateOpponents(any())).thenReturn(
            Opponents(
              teamA: Team(
                name: '',
                teamPlayers: [],
              ),
              teamB: Team(
                name: '',
                teamPlayers: [],
              ),
            ),
          );
        },
        build: () => GenerateTeamBloc(
          teamRepository: teamRepository,
        ),
        act: (bloc) => bloc.add(GenerateTeamRequested()),
        expect: () => [
          isA<GenerateTeamStateOpponents>(),
        ],
        verify: (_) {
          verify(() => teamRepository.generateOpponents([])).called(1);
        },
      );

      blocTest<GenerateTeamBloc, GenerateTeamState>(
        'emits [] when repository throws error',
        setUp: () {
          when(() => teamRepository.generateOpponents(any())).thenThrow(
            InsuficientParticipantsException(),
          );
        },
        build: () => GenerateTeamBloc(teamRepository: teamRepository),
        act: (bloc) => bloc.add(GenerateTeamRequested()),
        expect: () => [
          GenerateTeamStateInsuficientParticipants(),
        ],
      );
    });

    group('GenerateTeamRedoRequested', () {
      final players = [
        'player1',
        'player2',
        'player3',
      ];
      blocTest<GenerateTeamBloc, GenerateTeamState>(
        'emist an empty [GenerateTeamStateSuccess] when redo team',
        build: () => GenerateTeamBloc(teamRepository: teamRepository),
        seed: () => GenerateTeamStateSuccess(
          players: players,
        ),
        act: (bloc) {
          bloc.add(GenerateTeamPlayerAdded(playerName: 'player4'));
          // ignore: cascade_invocations
          bloc.add(GenerateTeamRedoRequested());
        },
        expect: () => [
          GenerateTeamStateSuccess(players: ['player4', ...players]),
          GenerateTeamStateSuccess(players: const []),
        ],
      );
    });
  });
}
