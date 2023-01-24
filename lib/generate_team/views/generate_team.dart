import 'package:bottle_caps_manager/generate_team/bloc/generate_team_bloc.dart';
import 'package:bottle_caps_manager/generate_team/widgets/opponents_list.dart';
import 'package:bottle_caps_manager/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_repository/team_repository.dart';

class GenerateTeamPage extends StatelessWidget {
  const GenerateTeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GenerateTeamBloc(
        teamRepository: context.read<TeamRepository>(),
      ),
      child: GenerateTeamView(),
    );
  }
}

class GenerateTeamView extends StatelessWidget {
  GenerateTeamView({super.key});

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final TextEditingController playerNameController = TextEditingController();
  final FocusNode playerNameFocus = FocusNode();

  void _addPlayer(BuildContext context) {
    context.read<GenerateTeamBloc>().add(
          GenerateTeamPlayerAdded(
            playerName: playerNameController.text,
          ),
        );
    if (playerNameController.text.isNotEmpty) {
      _listKey.currentState!.insertItem(0);
      playerNameController.clear();
      playerNameFocus.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocConsumer<GenerateTeamBloc, GenerateTeamState>(
      listener: (context, state) {
        if (state is GenerateTeamStateInsuficientParticipants) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.invalidNumberOfParticipants),
            ),
          );
        }
        if (state is GenerateTeamStateEmptyName) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.playerNameCannotBeEmpty),
            ),
          );
        }
      },
      buildWhen: (previous, current) =>
          current is GenerateTeamStateSuccess ||
          current is GenerateTeamStateOpponents,
      builder: (context, state) {
        if (state is GenerateTeamStateOpponents) {
          return Scaffold(
            appBar: AppBar(
              title: Text(l10n.callYourTeammates),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8),
              child: SafeArea(
                child: Column(
                  children: [
                    Text(
                      'Team A',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(height: 8),
                    OpponentsList(
                      players: state.teamA,
                      backgroundColor: Colors.blueGrey[500],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Team A',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(height: 8),
                    OpponentsList(
                      players: state.teamB,
                      backgroundColor: Colors.blueGrey[300],
                    ),
                    ElevatedButton(
                        child: Text('Redo'),
                        onPressed: () {
                          context
                              .read<GenerateTeamBloc>()
                              .add(const GenerateTeamRedoRequested());
                        }),
                  ],
                ),
              ),
            ),
          );
        } else {
          final stateSuccess = state as GenerateTeamStateSuccess;
          return Scaffold(
            appBar: AppBar(title: Text(l10n.generateTeam)),
            body: Padding(
              padding: const EdgeInsets.all(8),
              child: SafeArea(
                child: Column(
                  children: [
                    Text(
                      l10n.addPlayers,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(height: 8),
                    Visibility(
                      visible: stateSuccess.players.isNotEmpty,
                      child: Text(
                        l10n.playersInTheList(stateSuccess.players.length),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: playerNameController,
                            onSubmitted: (_) => _addPlayer(context),
                            focusNode: playerNameFocus,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => _addPlayer(context),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        child: AnimatedList(
                          key: _listKey,
                          itemBuilder: (context, index, animation) {
                            return SizeTransition(
                              key: UniqueKey(),
                              sizeFactor: animation,
                              child: Card(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.2),
                                child: ListTile(
                                  title: Text(
                                    stateSuccess.players[index],
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      context.read<GenerateTeamBloc>().add(
                                            GenerateTeamPlayerRemoved(
                                              playerIndex: index,
                                            ),
                                          );

                                      _listKey.currentState!.removeItem(
                                        index,
                                        (context, animation) {
                                          return SizeTransition(
                                            sizeFactor: animation,
                                            child: Card(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .error,
                                              child: ListTile(
                                                title: Text(l10n.delete),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    ElevatedButton(
                      child: Text(l10n.generate),
                      onPressed: () {
                        context
                            .read<GenerateTeamBloc>()
                            .add(const GenerateTeamRequested());
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
