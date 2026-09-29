import 'dart:io';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'database.dart';
import 'home_screen.dart';
import 'providers.dart';
import 'theme.dart';
import 'categories.dart';

const _feelLabels = ['Üşüdüm', 'Tam iyiydi', 'Sıcak bastı'];
const _feelIcons = [
  Icons.ac_unit,
  Icons.check_circle_outline,
  Icons.wb_sunny_outlined,
];
const _minT = -10.0;
const _maxT = 45.0;

String _fmt(DateTime d) =>
    '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year}';

Widget _thumb(String path, double size) => ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.file(File(path),
          width: size, height: size, fit: BoxFit.cover, cacheWidth: 200),
    );

class WeatherLogScreen extends ConsumerStatefulWidget {
  const WeatherLogScreen({super.key});

  @override
  ConsumerState<WeatherLogScreen> createState() => _WeatherLogScreenState();
}

class _WeatherLogScreenState extends ConsumerState<WeatherLogScreen> {
  RangeValues _range = const RangeValues(_minT, _maxT);
  bool get _filtering => _range.start > _minT || _range.end < _maxT;

  Future<bool> _confirmDelete(BuildContext ctx) async =>
      await showDialog<bool>(
        context: ctx,
        builder: (d) => AlertDialog(
          title: const Text('Bu kayıt silinsin mi?'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(d, false),
                child: const Text('Vazgeç')),
            FilledButton(
                onPressed: () => Navigator.pop(d, true),
                child: const Text('Sil')),
          ],
        ),
      ) ??
      false;

  Future<void> _openForm([WeatherLog? log]) async {
    final db = ref.read(dbProvider);
    final itemsById = {
      for (final i in ref.read(allItemsProvider).value ?? <Item>[]) i.id: i
    };
    final temp = TextEditingController(text: log?.temp.toString() ?? '');
    final comment = TextEditingController(text: log?.comment ?? '');
    final legacy = log?.outfit ?? '';
    var feeling = log?.feeling ?? 1;
    var showErr = false;
    var selected = <int>[
      for (final l in ref.read(logItemsProvider).value ?? <LogItem>[])
        if (log != null && l.logId == log.id) l.itemId
    ];

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (ctx) => SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              16, 16, 16, MediaQuery.of(ctx).viewInsets.bottom + 16),
          child: StatefulBuilder(
            builder: (ctx, setS) {
              final valid = selected.isNotEmpty || legacy.isNotEmpty;

              Future<void> pick() async {
                ref.read(pickSelectionProvider.notifier).state = {...selected};
                final res = await Navigator.push<List<int>>(
                  ctx,
                  MaterialPageRoute(
                      builder: (_) => const HomeScreen(pick: PickConfig())),
                );
                if (res != null && ctx.mounted) setS(() => selected = res);
              }

              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(log == null ? 'Yeni kayıt' : 'Kaydı düzenle',
                        style: Theme.of(ctx).textTheme.titleLarge),
                    const SizedBox(height: 12),
                    TextField(
                      controller: temp,
                      keyboardType:
                          const TextInputType.numberWithOptions(signed: true),
                      decoration: InputDecoration(
                        labelText: 'Hava kaç derece?',
                        suffixText: '°C',
                        errorText:
                            showErr && int.tryParse(temp.text.trim()) == null
                                ? 'Bir sayı gir'
                                : null,
                      ),
                    ),
                    const SizedBox(height: 12),
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: pick,
                      child: InputDecorator(
                        isEmpty: false,
                        decoration: InputDecoration(
                          labelText: 'Ne giydin?',
                          suffixIcon: const Icon(Icons.checkroom),
                          errorText:
                              showErr && !valid ? 'En az bir kıyafet seç' : null,
                        ),
                        child: selected.isEmpty
                            ? Text(
                                legacy.isNotEmpty ? legacy : 'Kıyafet seç',
                                style: const TextStyle(color: Colors.black54),
                              )
                            : Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: [
                                  for (final id in selected)
                                    if (itemsById[id] != null)
                                      _thumb(itemsById[id]!.photoPath, 56),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SegmentedButton<int>(
                      showSelectedIcon: false,
                      segments: [
                        for (var i = 0; i < 3; i++)
                          ButtonSegment(
                            value: i,
                            icon: Icon(_feelIcons[i], size: 18),
                            label: Text(_feelLabels[i],
                                style: const TextStyle(fontSize: 12)),
                          ),
                      ],
                      selected: {feeling},
                      onSelectionChanged: (s) => setS(() => feeling = s.first),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: comment,
                      minLines: 2,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: 'Yorum',
                        hintText: 'ör. rüzgarlıydı, akşam soğudu',
                        alignLabelWithHint: true,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        if (log != null)
                          IconButton(
                            icon: const Icon(Icons.delete_outline, color: plum),
                            onPressed: () async {
                              if (await _confirmDelete(ctx)) {
                                await db.deleteLog(log.id);
                                if (ctx.mounted) Navigator.pop(ctx);
                              }
                            },
                          ),
                        Expanded(
                          child: FilledButton(
                            onPressed: () async {
                              final t = int.tryParse(temp.text.trim());
                              if (t == null || !valid) {
                                setS(() => showErr = true);
                                return;
                              }
                              final c = comment.text.trim();
                              int logId;
                              if (log == null) {
                                logId = await db.addLog(
                                  WeatherLogsCompanion.insert(
                                    temp: t,
                                    outfit: '',
                                    feeling: Value(feeling),
                                    comment: Value(c),
                                  ),
                                );
                              } else {
                                logId = log.id;
                                await db.updateLog(
                                  logId,
                                  WeatherLogsCompanion(
                                    temp: Value(t),
                                    feeling: Value(feeling),
                                    comment: Value(c),
                                  ),
                                );
                              }
                              await db.setLogItems(logId, selected);
                              if (ctx.mounted) Navigator.pop(ctx);
                            },
                            child: const Text('Kaydet'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final all = ref.watch(logsProvider).value ?? [];
    final allItems = ref.watch(allItemsProvider).value ?? [];
    final links = ref.watch(logItemsProvider).value ?? [];
    final itemsById = {for (final i in allItems) i.id: i};

    final logs = all
        .where((l) =>
            l.temp >= _range.start.round() && l.temp <= _range.end.round())
        .toList();

    List<Item> itemsOf(int logId) => [
          for (final l in links)
            if (l.logId == logId && itemsById[l.itemId] != null)
              itemsById[l.itemId]!
        ];

    return Scaffold(
      appBar: AppBar(title: const Text('Havaya göre')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(),
        icon: const Icon(Icons.add),
        label: const Text('Log ekle'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(12, 4, 12, 8),
            padding: const EdgeInsets.fromLTRB(16, 8, 8, 0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      _filtering
                          ? 'Filtre: ${_range.start.round()}° – ${_range.end.round()}°'
                          : 'Tüm dereceler',
                      style: const TextStyle(color: Colors.white),
                    ),
                    const Spacer(),
                    if (_filtering)
                      TextButton(
                        onPressed: () => setState(
                            () => _range = const RangeValues(_minT, _maxT)),
                        child: const Text('Sıfırla',
                            style: TextStyle(color: Colors.white)),
                      ),
                  ],
                ),
                RangeSlider(
                  values: _range,
                  min: _minT,
                  max: _maxT,
                  divisions: 55,
                  labels: RangeLabels(
                      '${_range.start.round()}°', '${_range.end.round()}°'),
                  activeColor: Colors.white,
                  inactiveColor: Colors.white38,
                  onChanged: (v) => setState(() => _range = v),
                ),
              ],
            ),
          ),
          Expanded(
            child: logs.isEmpty
                ? Center(
                    child: Text(
                      all.isEmpty ? 'Henüz kayıt yok' : 'Bu aralıkta kayıt yok',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 90),
                    itemCount: logs.length,
                    itemBuilder: (_, i) {
                      final l = logs[i];
                      final f = l.feeling.clamp(0, 2);
                      final worn = itemsOf(l.id);
                      return Card(
                        color: Colors.white.withOpacity(0.93),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () => _openForm(l),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 64,
                                  child: Text('${l.temp}°',
                                      style: const TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                          color: plum)),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (l.outfit.isNotEmpty)
                                        Text(l.outfit,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600)),
                                      if (worn.isNotEmpty)
                                        Wrap(
                                          spacing: 6,
                                          runSpacing: 6,
                                          children: [
                                            for (final it in worn)
                                              _thumb(it.photoPath, 44),
                                          ],
                                        ),
                                      if (l.comment.isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.only(top: 6),
                                          child: Text(l.comment),
                                        ),
                                      const SizedBox(height: 6),
                                      Text(_fmt(l.createdAt),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54)),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Icon(_feelIcons[f], color: plum),
                                    Text(_feelLabels[f],
                                        style: const TextStyle(fontSize: 11)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}