import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:train/main.dart';

void main() {
  testWidgets('App builds without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: BandInstrumentTrainingApp()));
    await tester.pump();
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
  });
}
