import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:animated_digit/animated_digit.dart';

void main() {
  group('AnimatedDigitWidget Tests', () {
    testWidgets('should display default behavior with simple value',
        (WidgetTester tester) async {
      const testValue = 42;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedDigitWidget(
              value: testValue,
              textStyle: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(AnimatedDigitWidget), findsOneWidget);

      expect(find.text('4'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);

      expect(find.byType(Row), findsOneWidget);
    });

    testWidgets('should support custom formatter', (WidgetTester tester) async {
      const testValue = 1234.56;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedDigitWidget(
              value: testValue,
              formatter: (value) =>
                  'Rs ${NumberFormat.decimalPattern('en_IN').format(value)}',
              textStyle: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(AnimatedDigitWidget), findsOneWidget);

      expect(find.text('R'), findsOneWidget);
      expect(find.text('s'), findsOneWidget);
      expect(find.text(' '), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
      expect(find.text(','), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
      expect(find.text('.'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
      expect(find.text('6'), findsOneWidget);
    });

    testWidgets('should work with AnimatedDigitController',
        (WidgetTester tester) async {
      final controller = AnimatedDigitController(5);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedDigitWidget(
              controller: controller,
              textStyle: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('5'), findsOneWidget);

      controller.resetValue(9);

      await tester.pumpAndSettle();

      expect(find.text('9'), findsOneWidget);

      controller.addValue(1);
      await tester.pumpAndSettle();

      expect(find.text('1'), findsOneWidget);
      expect(find.text('0'), findsOneWidget);

      controller.dispose();
    });
  });
}
