import 'package:flutter/material.dart';

class OpponentsList extends StatelessWidget {
  const OpponentsList({
    super.key,
    required this.players,
    this.backgroundColor,
  });

  final List<String> players;

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: players
              .map(
                (e) => Card(
                  color: backgroundColor,
                  child: ListTile(title: Text(e)),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
