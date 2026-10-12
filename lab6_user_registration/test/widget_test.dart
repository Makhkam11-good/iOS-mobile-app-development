import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab6_user_registration/main.dart';

void main() {
  Future<void> openApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const RegistrationApp());
  }

  Future<void> fillValid(WidgetTester tester) async {
    await tester.enterText(find.byKey(const Key('fullName')), 'Test Student');
    await tester.enterText(find.byKey(const Key('email')), 'student@narxoz.kz');
    await tester.enterText(find.byKey(const Key('password')), 'test123');
    await tester.enterText(find.byType(TextFormField).at(3), 'test123');
    await tester.pump();
  }

  testWidgets('empty submission shows every error and blocks success', (
    tester,
  ) async {
    await openApp(tester);
    await tester.tap(find.byKey(const Key('register')));
    await tester.pump();
    expect(find.text('Full name is required.'), findsOneWidget);
    expect(find.text('Email is required.'), findsOneWidget);
    expect(find.text('Password is required.'), findsOneWidget);
    expect(find.text('Please confirm your password.'), findsOneWidget);
    expect(
      find.text('Accept the Terms and Conditions to continue.'),
      findsOneWidget,
    );
    expect(find.byType(SnackBar), findsNothing);
  });

  testWidgets('valid data requires terms before success', (tester) async {
    await openApp(tester);
    await fillValid(tester);
    await tester.tap(find.byKey(const Key('register')));
    await tester.pump();
    expect(find.byType(SnackBar), findsNothing);
    expect(
      find.text('Accept the Terms and Conditions to continue.'),
      findsOneWidget,
    );
    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    await tester.tap(find.byKey(const Key('register')));
    await tester.pumpAndSettle();
    expect(
      find.text('Registration successful! Welcome, Test Student.'),
      findsOneWidget,
    );
  });

  testWidgets('live validation and dependent password confirmation', (
    tester,
  ) async {
    await openApp(tester);
    await tester.enterText(find.byKey(const Key('fullName')), '   ');
    await tester.enterText(find.byKey(const Key('email')), 'invalid@narxoz');
    await tester.enterText(find.byKey(const Key('password')), '12345');
    await tester.enterText(find.byType(TextFormField).at(3), 'different');
    await tester.pump();
    expect(find.text('Full name is required.'), findsOneWidget);
    expect(
      find.text('Enter a valid email, e.g. name@narxoz.kz.'),
      findsOneWidget,
    );
    expect(find.text('Use at least 6 characters.'), findsOneWidget);
    expect(find.text('Passwords must match exactly.'), findsOneWidget);
    await fillValid(tester);
    expect(find.text('Passwords must match exactly.'), findsNothing);
    await tester.enterText(find.byKey(const Key('password')), 'changed123');
    await tester.pump();
    expect(find.text('Passwords must match exactly.'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField).at(3), 'changed123');
    await tester.pump();
    expect(find.text('Passwords must match exactly.'), findsNothing);
  });

  testWidgets('passwords are obscured and every role is selectable', (
    tester,
  ) async {
    await openApp(tester);
    expect(
      tester
          .widgetList<EditableText>(find.byType(EditableText))
          .where((field) => field.obscureText)
          .length,
      2,
    );
    for (final role in ['Teacher', 'Developer', 'Student']) {
      await tester.tap(find.byKey(const Key('role')));
      await tester.pumpAndSettle();
      await tester.tap(find.text(role).last);
      await tester.pumpAndSettle();
      expect(find.text(role), findsOneWidget);
    }
  });
}
