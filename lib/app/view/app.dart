import 'package:bottle_caps_manager/counter/counter.dart';
import 'package:bottle_caps_manager/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:team_repository/team_repository.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required TeamRepository teamRepository,
  }) : _teamRepository = teamRepository;

  final TeamRepository _teamRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _teamRepository,
        ),
      ],
      child: MaterialApp(
        theme: flutterNesTheme(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const CounterPage(),
      ),
    );
  }
}
