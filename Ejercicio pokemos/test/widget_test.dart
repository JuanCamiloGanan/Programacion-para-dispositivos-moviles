import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ejemplo_2_documentacion/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp.test()); 

    // Verify that our counter starts at 0.
    expect(find.byType(MaterialApp), findsOneWidget); 
    expect(find.byType(Scaffold), findsOneWidget);    

  });
}