import 'package:bottle_caps_manager/app/app.dart';
import 'package:bottle_caps_manager/counter/counter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:team_repository/team_repository.dart';

class MockTeamRepository extends Mock implements TeamRepository {}

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(App(
        teamRepository: MockTeamRepository(),
      ));
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
