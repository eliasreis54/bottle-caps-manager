import 'package:flutter/material.dart';
import 'package:team_repository/team_repository.dart';

class OpponentsList extends StatelessWidget {
  const OpponentsList({
    super.key,
    required this.opponents,
  });

  final Opponents opponents;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                if (opponents.teamA.teamPlayers.isNotEmpty)
                  Expanded(
                    child: Column(
                      children: [
                        Text(opponents.teamA.name),
                        const SizedBox(height: 8),
                        ...opponents.teamA.teamPlayers.map(
                          (e) => Card(
                            color: Colors.purple[200],
                            child: ListTile(
                              style: ListTileStyle.list,
                              title: Text(
                                e,
                                style: theme.textTheme.labelSmall,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (opponents.teamB.teamPlayers.isNotEmpty)
                  Expanded(
                    child: Column(children: [
                      Text(opponents.teamB.name),
                      const SizedBox(height: 8),
                      ...opponents.teamB.teamPlayers.map(
                        (e) => Card(
                          color: Colors.purple[400],
                          child: ListTile(
                            title: Text(
                              e,
                              style: theme.textTheme.labelSmall,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
              ],
            ),
            if (opponents.nextPlayers.teamPlayers.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(opponents.nextPlayers.name),
              const SizedBox(height: 8),
              ...opponents.nextPlayers.teamPlayers.map(
                (e) => Card(
                  color: Colors.grey[400],
                  child: ListTile(
                    title: Text(
                      e,
                      style: theme.textTheme.labelSmall,
                    ),
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

class OpponentesTableColum extends StatelessWidget {
  const OpponentesTableColum({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
