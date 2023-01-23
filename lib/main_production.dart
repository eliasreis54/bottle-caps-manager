import 'package:bottle_caps_manager/app/app.dart';
import 'package:bottle_caps_manager/bootstrap.dart';
import 'package:team_repository/team_repository.dart';

void main() {
  const teamRepository = TeamRepository();
  bootstrap(
    () => const App(
      teamRepository: teamRepository,
    ),
  );
}
