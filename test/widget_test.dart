import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ranes_navigation_app/main.dart';
import 'package:ranes_navigation_app/demo_auth.dart';
import 'package:ranes_navigation_app/login_screen.dart';
import 'package:ranes_navigation_app/main_screen.dart';

void main() {
  setUp(() {
    DemoAuth.registeredUsername = null;
    DemoAuth.registeredPassword = null;
  });

  testWidgets('App starts on the Login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const StudentApp());
    await tester.pumpAndSettle();

    expect(find.text('Welcome Back!'), findsOneWidget);
    expect(find.byType(LoginScreen), findsOneWidget);
  });

  testWidgets('Wrong credentials show error and stay on Login', (WidgetTester tester) async {
    await tester.pumpWidget(const StudentApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'wrong');
    await tester.enterText(find.byType(TextFormField).at(1), 'wrong');
    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pumpAndSettle();

    expect(find.text('Invalid username or password.'), findsOneWidget);
    expect(find.byType(LoginScreen), findsOneWidget);
  });

  testWidgets('Empty fields show validation errors', (WidgetTester tester) async {
    await tester.pumpWidget(const StudentApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pumpAndSettle();

    expect(find.text('Enter your username.'), findsOneWidget);
    expect(find.text('Enter your password.'), findsOneWidget);
  });

  testWidgets('Login with admin / admin123 opens main screen with four destinations',
      (WidgetTester tester) async {
    await tester.pumpWidget(const StudentApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'admin');
    await tester.enterText(find.byType(TextFormField).at(1), 'admin123');
    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pumpAndSettle();

    expect(find.byType(MainScreen), findsOneWidget);
    final navBar = find.byType(NavigationBar);
    expect(navBar, findsOneWidget);

    expect(find.descendant(of: navBar, matching: find.text('Home')), findsOneWidget);
    expect(find.descendant(of: navBar, matching: find.text('Calculator')), findsOneWidget);
    expect(find.descendant(of: navBar, matching: find.text('Profile')), findsOneWidget);
    expect(find.descendant(of: navBar, matching: find.text('Social Media')), findsOneWidget);

    // Home
    await tester.tap(find.descendant(of: navBar, matching: find.text('Home')));
    await tester.pumpAndSettle();
    expect(find.text('Welcome, Student!'), findsOneWidget);

    // Calculator
    await tester.tap(find.descendant(of: navBar, matching: find.text('Calculator')));
    await tester.pumpAndSettle();
    expect(find.text('My Stateful Calculator'), findsOneWidget);

    // Profile
    await tester.tap(find.descendant(of: navBar, matching: find.text('Profile')));
    await tester.pumpAndSettle();
    expect(find.text('My Profile'), findsOneWidget);

    // Social Media
    await tester.tap(find.descendant(of: navBar, matching: find.text('Social Media')));
    await tester.pumpAndSettle();
    expect(find.text('Connect With Me'), findsOneWidget);
  });

  testWidgets('Calculator page state is preserved when switching tabs',
      (WidgetTester tester) async {
    await tester.pumpWidget(const StudentApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'admin');
    await tester.enterText(find.byType(TextFormField).at(1), 'admin123');
    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pumpAndSettle();

    // Go to Calculator
    final navBar = find.byType(NavigationBar);
    await tester.tap(find.descendant(of: navBar, matching: find.text('Calculator')));
    await tester.pumpAndSettle();

    // Type 8 and 2 in the two text fields
    final textFields = find.byType(TextField);
    await tester.enterText(textFields.at(0), '8');
    await tester.enterText(textFields.at(1), '2');
    await tester.pumpAndSettle();

    expect(find.text('8'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);

    // Switch to Profile and back to Calculator
    await tester.tap(find.descendant(of: navBar, matching: find.text('Profile')));
    await tester.pumpAndSettle();
    expect(find.text('My Profile'), findsOneWidget);

    await tester.tap(find.descendant(of: navBar, matching: find.text('Calculator')));
    await tester.pumpAndSettle();

    expect(find.text('8'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
  });

  testWidgets('Tapping an account in Social Media shows its SnackBar',
      (WidgetTester tester) async {
    await tester.pumpWidget(const StudentApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'admin');
    await tester.enterText(find.byType(TextFormField).at(1), 'admin123');
    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pumpAndSettle();

    final navBar = find.byType(NavigationBar);
    await tester.tap(find.descendant(of: navBar, matching: find.text('Social Media')));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Facebook'));
    await tester.pumpAndSettle();

    expect(find.text('Selected account: Facebook: student.sample'), findsOneWidget);
  });

  testWidgets('Registration validates, registers, logs in, and admin still works',
      (WidgetTester tester) async {
    await tester.pumpWidget(const StudentApp());
    await tester.pumpAndSettle();

    // Go to Register screen
    await tester.tap(find.text("Don't have an account? Register"));
    await tester.pumpAndSettle();

    // Try registering with short username
    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pumpAndSettle();
    expect(find.text('Use at least 3 characters.'), findsOneWidget);

    // Try registering with reserved username 'admin'
    await tester.enterText(find.byType(TextFormField).at(0), 'admin');
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');
    await tester.enterText(find.byType(TextFormField).at(2), 'password123');
    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pumpAndSettle();
    expect(find.text('This username is reserved.'), findsOneWidget);

    // Try registering with short password
    await tester.enterText(find.byType(TextFormField).at(0), 'student');
    await tester.enterText(find.byType(TextFormField).at(1), '123');
    await tester.enterText(find.byType(TextFormField).at(2), '123');
    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pumpAndSettle();
    expect(find.text('Use at least 6 characters.'), findsOneWidget);

    // Try registering with mismatched passwords
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');
    await tester.enterText(find.byType(TextFormField).at(2), 'password456');
    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pumpAndSettle();
    expect(find.text('Passwords do not match.'), findsOneWidget);

    // Register a valid account
    await tester.enterText(find.byType(TextFormField).at(2), 'password123');
    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pumpAndSettle();
    expect(find.text('Registration successful! You can now log in.'), findsOneWidget);

    // Log in with the registered account (pop() returned us to LoginScreen)
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'student');
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');
    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pumpAndSettle();

    expect(find.byType(MainScreen), findsOneWidget);

    // Verify admin / admin123 still works afterwards.
    expect(DemoAuth.login('admin', 'admin123'), isTrue);
  });
}
