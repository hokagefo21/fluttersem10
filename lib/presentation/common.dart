import 'package:flutter/material.dart';
import '../model/task_model.dart';

class Live<T> extends StatelessWidget {
  final Stream<T> stream;
  final Widget Function(T) show;
  const Live(this.stream, this.show, {super.key});
  @override
  Widget build(BuildContext context) => StreamBuilder<T>(
    stream: stream,
    builder: (c, s) {
      if (s.hasError) return Text('Ошибка чтения: ${s.error}');
      if (!s.hasData) return const Center(child: CircularProgressIndicator());
      return show(s.data as T);
    },
  );
}

void message(BuildContext c, String text) => ScaffoldMessenger.of(c)
  ..hideCurrentSnackBar()
  ..showSnackBar(SnackBar(content: Text(text)));
Future<bool> act(BuildContext c, Future<void> Function() fn) async {
  try {
    await fn();
    return true;
  } catch (e) {
    if (c.mounted) message(c, e.toString());
    return false;
  }
}

Future<void> confirm(
  BuildContext c,
  String title,
  Future<void> Function() fn,
) async {
  final yes = await showDialog<bool>(
    context: c,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Назад'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('Подтвердить'),
        ),
      ],
    ),
  );
  if (yes == true && c.mounted) await act(c, fn);
}

typedef Rebuild = void Function(VoidCallback);
Future<void> editor(
  BuildContext c,
  String title,
  List<Widget> Function(BuildContext, Rebuild) fields,
  Future<void> Function() save,
) {
  bool busy = false;
  String? error;
  return showDialog<void>(
    context: c,
    barrierDismissible: false,
    builder: (dialog) => StatefulBuilder(
      builder: (ctx, set) {
        return AlertDialog(
          scrollable: true,
          title: Text(title),
          content: SizedBox(
            width: 450,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final field in fields(ctx, set))
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: field,
                  ),
                if (error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      error!,
                      style: TextStyle(color: Theme.of(ctx).colorScheme.error),
                    ),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: busy ? null : () => Navigator.pop(ctx),
              child: const Text('Отмена'),
            ),
            FilledButton(
              onPressed: busy
                  ? null
                  : () async {
                      set(() {
                        busy = true;
                        error = null;
                      });
                      try {
                        await save();
                        if (ctx.mounted) Navigator.pop(ctx);
                      } catch (e) {
                        if (ctx.mounted) {
                          set(() {
                            busy = false;
                            error = e.toString();
                          });
                        }
                      }
                    },
              child: Text(busy ? 'Сохранение…' : 'Сохранить'),
            ),
          ],
        );
      },
    ),
  );
}

Widget input(
  String label,
  String value,
  ValueChanged<String> onChanged, {
  int lines = 1,
}) => TextFormField(
  initialValue: value,
  onChanged: onChanged,
  maxLines: lines,
  decoration: InputDecoration(labelText: label),
);
Widget choices<T extends Object>(
  String label,
  T? selected,
  Map<T, String> values,
  void Function(T?) changed, {
  bool all = false,
}) {
  return DropdownButtonFormField<T>(
    key: ValueKey((label, selected)),
    initialValue: values.containsKey(selected) ? selected : null,
    isExpanded: true,
    decoration: InputDecoration(labelText: label),
    items: [
      if (all) const DropdownMenuItem(value: null, child: Text('Все')),
      for (final e in values.entries)
        DropdownMenuItem(
          value: e.key,
          child: Text(e.value, overflow: TextOverflow.ellipsis),
        ),
    ],
    onChanged: changed,
  );
}

Widget dateField(
  BuildContext c,
  String label,
  String? value,
  ValueChanged<String?> changed, {
  bool optional = false,
}) => Row(
  children: [
    Expanded(
      child: OutlinedButton.icon(
        icon: const Icon(Icons.calendar_today_outlined),
        label: Text('$label · ${value ?? "выбрать"}'),
        onPressed: () async {
          final date = await showDatePicker(
            context: c,
            initialDate: DateTime.tryParse(value ?? '') ?? DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2200),
          );
          if (date != null && c.mounted) changed(day(date));
        },
      ),
    ),
    if (optional && value != null)
      IconButton(
        tooltip: 'Убрать дату',
        onPressed: () => changed(null),
        icon: const Icon(Icons.close),
      ),
  ],
);
Widget empty(String label) => Padding(
  padding: const EdgeInsets.all(24),
  child: Center(child: Text(label, textAlign: TextAlign.center)),
);
void openPage(BuildContext c, Widget screen) =>
    Navigator.push(c, MaterialPageRoute<void>(builder: (_) => screen));
