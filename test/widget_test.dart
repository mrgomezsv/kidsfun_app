import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kidsfun/login/login_screen.dart';
import 'package:kidsfun/main.dart';

void main() {
  testWidgets('Initial route test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(isLoggedIn: false, hasCompletedOnboarding: false)); // Ajusta los valores según sea necesario

    // Verify that LoginPage is the initial route when isLoggedIn is false.
    expect(find.byType(LoginPage), findsOneWidget);

    // If you want to test the scenario where isLoggedIn is true and hasCompletedOnboarding is true,
    // you can modify the test as follows:

    // await tester.pumpWidget(MyApp(isLoggedIn: true, hasCompletedOnboarding: true));
    // expect(find.byType(MainScreen), findsOneWidget); // Replace with the expected initial route for isLoggedIn true
  });
}
