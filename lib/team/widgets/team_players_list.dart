import 'package:bottle_caps_manager/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:nes_ui/nes_ui.dart';

class TeamPlayersList extends StatelessWidget {
  const TeamPlayersList({
    super.key,
    required GlobalKey<AnimatedListState> listKey,
    required this.players,
    required this.onDeleteTap,
  }) : _listKey = listKey;

  final GlobalKey<AnimatedListState> _listKey;
  final List<String> players;
  final void Function(int) onDeleteTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Expanded(
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
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                child: ListTile(
                  title: Text(
                    players[index],
                  ),
                  trailing: IconButton(
                    icon: NesIcon(iconData: NesIcons.instance.delete),
                    onPressed: () {
                      onDeleteTap(index);

                      _listKey.currentState!.removeItem(
                        index,
                        (context, animation) {
                          return SizeTransition(
                            sizeFactor: animation,
                            child: Card(
                              color: Theme.of(context).colorScheme.error,
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
    );
  }
}
