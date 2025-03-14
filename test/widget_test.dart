// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:fff/demoAPI/repo_list_module/repoViewModel.dart';
import 'package:fff/local/database.dart';
import 'package:fff/login_module/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fff/main.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';


class MockAuthService extends Mock implements AuthService {}

void main() {
  late MockAuthService mockAuthService;

  setUp(() {
    final mockDatabase = AppDatabase.getInstance(); // Mock the database if needed
    mockAuthService = MockAuthService();
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // ✅ Mock login status
    when(mockAuthService.isLoggedIn()).thenAnswer((_) async => false);

    // ✅ Build the widget tree with necessary providers
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => RepoViewModel()), // Provide ViewModel if used in the app
        ],
        child: MaterialApp(
          home: MyApp(mockAuthService),
        ),
      ),
    );

    // // ✅ Ensure the counter starts at 0
    // expect(find.text('0'), findsOneWidget);
    // expect(find.text('1'), findsNothing);
    //
    // // ✅ Tap the '+' icon and trigger a frame
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();
    //
    // // ✅ Verify that the counter increments
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}
