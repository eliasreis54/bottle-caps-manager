import 'package:bottle_caps_manager/l10n/l10n.dart';
import 'package:bottle_caps_manager/team/merge_team/bloc/merge_team_bloc.dart';
import 'package:bottle_caps_manager/team/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_repository/team_repository.dart';

class MergeTeamPage extends StatelessWidget {
  const MergeTeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MergeTeamBloc>(
      create: (_) => MergeTeamBloc(
        teamRepository: context.read<TeamRepository>(),
      ),
      child: MergeTeamView(),
    );
  }
}

class MergeTeamView extends StatelessWidget {
  MergeTeamView({super.key});

  final GlobalKey<AnimatedListState> _winnersKey =
      GlobalKey<AnimatedListState>();

  final GlobalKey<AnimatedListState> _nextPlayerKey =
      GlobalKey<AnimatedListState>();

  void _addPlayer({
    required BuildContext context,
    required String playerName,
    required MergeTeamSteps step,
  }) {
    late MergeTeamEvent event;
    if (step == MergeTeamSteps.addWinners) {
      _winnersKey.currentState?.insertItem(0);
      event = MergeTeamWinnerPlayerAdded(
        playName: playerName,
      );
    } else {
      _nextPlayerKey.currentState?.insertItem(0);
      event = MergeTeamNextPlayerAdded(
        playName: playerName,
      );
    }

    context.read<MergeTeamBloc>().add(event);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: const Text('merge team'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocConsumer<MergeTeamBloc, MergeTeamState>(
          listener: (context, state) {
            if (state.status == MergeTeamStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Invalid number of players. Must be 6 each side',
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state.step == MergeTeamSteps.opponentsReady) {
              return Column(
                children: [
                  Text(
                    'Team A',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  OpponentsList(players: state.opponents!.teamA.teamPlayers),
                  const SizedBox(height: 12),
                  Text(
                    'Team B',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  OpponentsList(players: state.opponents!.teamB.teamPlayers),
                  ElevatedButton(
                    child: const Text('Redo'),
                    onPressed: () {
                      context
                          .read<MergeTeamBloc>()
                          .add(const MergeTeamMergeRedoRequested());
                    },
                  ),
                ],
              );
            }
            if (state.step == MergeTeamSteps.addWinners) {
              return _MergeTeamInsertPlayers(
                buttonAction: () {
                  context.read<MergeTeamBloc>().add(
                        const MergeTeamNextStep(
                          step: MergeTeamSteps.addNextPlayers,
                        ),
                      );
                },
                buttonActionText: 'next',
                onSubmitted: (playerName) {
                  _addPlayer(
                    step: state.step,
                    context: context,
                    playerName: playerName,
                  );
                },
                listKey: _winnersKey,
                players: state.winners.teamPlayers,
                title: l10n.addWinners,
                onDeleteTap: (index) {
                  context
                      .read<MergeTeamBloc>()
                      .add(MergeTeamWinnerRemoved(playerIndex: index));
                },
              );
            } else {
              return _MergeTeamInsertPlayers(
                buttonAction: () {
                  context
                      .read<MergeTeamBloc>()
                      .add(const MergeTeamMergeRequested());
                },
                buttonActionText: 'merge',
                onSubmitted: (playerName) {
                  _addPlayer(
                    step: state.step,
                    context: context,
                    playerName: playerName,
                  );
                },
                listKey: _nextPlayerKey,
                players: state.nextPlayers.teamPlayers,
                title: l10n.addNextPlayers,
                onDeleteTap: (index) {
                  context
                      .read<MergeTeamBloc>()
                      .add(MergeTeamNextPlayerRemoved(playerIndex: index));
                },
                backButtonAction: () {
                  context.read<MergeTeamBloc>().add(
                        const MergeTeamNextStep(
                          step: MergeTeamSteps.addWinners,
                        ),
                      );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class _MergeTeamInsertPlayers extends StatelessWidget {
  const _MergeTeamInsertPlayers({
    required this.title,
    required this.onSubmitted,
    required this.players,
    required this.listKey,
    required this.buttonActionText,
    required this.buttonAction,
    required this.onDeleteTap,
    this.backButtonAction,
  });

  final String title;
  final String buttonActionText;
  final VoidCallback buttonAction;
  final VoidCallback? backButtonAction;
  final void Function(String) onSubmitted;
  final void Function(int) onDeleteTap;
  final List<String> players;
  final GlobalKey<AnimatedListState> listKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        PlayerInputTextField(
          onSubmitted: onSubmitted,
        ),
        TeamPlayersList(
          listKey: listKey,
          players: players,
          onDeleteTap: onDeleteTap,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (backButtonAction != null)
              Visibility(
                visible: backButtonAction != null,
                child: ElevatedButton(
                  onPressed: backButtonAction,
                  child: const Text(
                    'Back',
                  ),
                ),
              ),
            ElevatedButton(
              onPressed: buttonAction,
              child: Text(
                buttonActionText,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
