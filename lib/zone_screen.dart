import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'categories.dart';
import 'database.dart';
import 'item_screen.dart';
import 'photo_utils.dart';
import 'providers.dart';
import 'theme.dart';

class ZoneScreen extends ConsumerWidget {
  final Zone zone;
  final PickConfig? pick;
  const ZoneScreen({super.key, required this.zone, this.pick});

  bool get pickMode => pick != null;

  Future<void> _add(BuildContext context, WidgetRef ref, String kind) async {
    final path = await pickAndSavePhoto('item');
    if (path == null) return;
    final db = ref.read(dbProvider);
    final id = await db
        .addItem(ItemsCompanion.insert(zoneId: zone.id, photoPath: path));
    final item = await db.getItem(id);
    if (!context.mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ItemScreen(item: item, kind: kind)),
    );
  }

  void _toggle(WidgetRef ref, int id) {
    final notifier = ref.read(pickSelectionProvider.notifier);
    final s = {...notifier.state};
    if (!s.remove(id)) s.add(id);
    notifier.state = s;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kind = ref
            .watch(furnituresProvider)
            .value
            ?.where((f) => f.id == zone.furnitureId)
            .firstOrNull
            ?.kind ??
        'wardrobe';
    final all = ref.watch(itemsProvider(zone.id)).value ?? [];
    final cats = pick?.categories;
    // kategorisizler (eski kıyafetler) her filtrede görünür
    final items = cats == null
        ? all
        : all.where((i) => i.category.isEmpty || cats.contains(i.category)).toList();
    final selected = ref.watch(pickSelectionProvider);

    return Scaffold(
      appBar: AppBar(title: Text(zone.title)),
      floatingActionButton: pickMode
          ? null
          : FloatingActionButton.extended(
              onPressed: () => _add(context, ref, kind),
              icon: const Icon(Icons.add),
              label: const Text('Kıyafet ekle'),
            ),
      body: items.isEmpty
          ? Center(
              child: Text(
                all.isEmpty ? 'Henüz kıyafet yok' : 'Bu kategoride kıyafet yok',
                style: const TextStyle(color: Colors.white70),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 90),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.78,
              ),
              itemCount: items.length,
              itemBuilder: (_, i) {
                final it = items[i];
                final isSel = selected.contains(it.id);
                final caption = [
                  if (it.category.isNotEmpty) it.category,
                  if (it.brand.isNotEmpty) it.brand,
                ].join(' · ');
                return GestureDetector(
                  onTap: () {
                    if (pickMode) {
                      if (pick!.single) {
                        Navigator.pop(context, it.id);
                      } else {
                        _toggle(ref, it.id);
                      }
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ItemScreen(item: it, kind: kind)),
                      );
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.file(File(it.photoPath),
                            fit: BoxFit.cover, cacheWidth: 500),
                        if (caption.isNotEmpty)
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              color: Colors.black38,
                              padding: const EdgeInsets.all(6),
                              child: Text(caption,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.white)),
                            ),
                          ),
                        if (pickMode && !pick!.single && isSel)
                          Container(
                            color: plum.withOpacity(0.55),
                            child: const Center(
                              child: Icon(Icons.check_circle,
                                  color: Colors.white, size: 44),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}