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
        title: Text(l10n.mergeTeam),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocConsumer<MergeTeamBloc, MergeTeamState>(
          listener: (context, state) {
            if (state.status == MergeTeamStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    l10n.mergeTeamInvalidNumberOfPlayers,
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state.step == MergeTeamSteps.opponentsReady) {
              return Column(
                children: [
                  OpponentsList(opponents: state.opponents!),
                  ElevatedButton(
                    child: Text(l10n.redo),
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
                buttonActionText: l10n.next,
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
                buttonActionText: l10n.merge,
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
    final l10n = context.l10n;
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
                  child: Text(
                    l10n.back,
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
