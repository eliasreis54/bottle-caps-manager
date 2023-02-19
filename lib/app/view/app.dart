import 'package:bottle_caps_manager/home/home.dart';
import 'package:bottle_caps_manager/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:team_repository/team_repository.dart';

class BottleCapsCollors extends ThemeExtension<BottleCapsCollors> {
  const BottleCapsCollors({
    required this.card,
  });

  final Color? card;

  @override
  ThemeExtension<BottleCapsCollors> copyWith({
    Color? card,
  }) {
    return BottleCapsCollors(
      card: card ?? this.card,
    );
  }

  @override
  ThemeExtension<BottleCapsCollors> lerp(
    covariant ThemeExtension<BottleCapsCollors>? other,
    double t,
  ) {
    if (other is! BottleCapsCollors) {
      return this;
    }
    return BottleCapsCollors(
      card: Color.lerp(card, other.card, t),
    );
  }

  static const light = BottleCapsCollors(
    card: Color(0x009b9dcb),
  );
}

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
        theme: flutterNesTheme(
          customExtensions: [
            BottleCapsCollors.light,
          ],
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const HomePage(),
      ),
    );
  }
}
