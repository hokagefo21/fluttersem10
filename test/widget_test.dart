import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/presentation/common.dart';

void main() {
  testWidgets('форма показывает ошибку и позволяет исправить ввод', (
    tester,
  ) async {
    var name = '', saved = '';
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (c) => Scaffold(
            body: TextButton(
              onPressed: () {
                editor(
                  c,
                  'Новая запись',
                  (_, set) => [input('Имя', name, (v) => name = v)],
                  () async {
                    if (name.isEmpty) {
                      throw const FormatException('Введите имя');
                    }
                    saved = name;
                  },
                );
              },
              child: const Text('Открыть'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Открыть'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Сохранить'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Введите имя'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField), 'Алия');
    await tester.tap(find.text('Сохранить'));
    await tester.pumpAndSettle();
    expect(saved, 'Алия');
    expect(find.text('Новая запись'), findsNothing);
  });
}
