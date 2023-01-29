import 'package:bottle_caps_manager/app/app.dart';
import 'package:bottle_caps_manager/bootstrap.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:team_repository/team_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  const teamRepository = TeamRepository();

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/font/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  bootstrap(
    () => const App(
      teamRepository: teamRepository,
    ),
  );
}
