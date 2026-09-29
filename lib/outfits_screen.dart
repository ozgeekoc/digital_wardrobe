import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'database.dart';
import 'outfit_editor_screen.dart';
import 'providers.dart';
import 'theme.dart';

class OutfitsScreen extends ConsumerWidget {
  const OutfitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final outfits = ref.watch(outfitsProvider).value ?? [];
    final extras = ref.watch(outfitExtrasProvider).value ?? [];
    final itemsById = {
      for (final i in ref.watch(allItemsProvider).value ?? <Item>[]) i.id: i
    };
    Item? byId(int? id) => id == null ? null : itemsById[id];

    return Scaffold(
      appBar: AppBar(title: const Text('Kombinler')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const OutfitEditorScreen()),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Kombin ekle'),
      ),
      body: outfits.isEmpty
          ? const Center(
              child: Text('Henüz kombin yok',
                  style: TextStyle(color: Colors.white70)))
          : GridView.builder(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 90),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.6,
              ),
              itemCount: outfits.length,
              itemBuilder: (_, i) {
                final o = outfits[i];
                final ex = [
                  for (final e in extras)
                    if (e.outfitId == o.id && itemsById[e.itemId] != null)
                      itemsById[e.itemId]!
                ];
                return _OutfitCard(
                  outfit: o,
                  top: byId(o.topId),
                  bottom: byId(o.bottomId),
                  shoes: byId(o.shoesId),
                  extras: ex,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => OutfitEditorScreen(outfit: o)),
                  ),
                  onStar: () => ref
                      .read(dbProvider)
                      .toggleFavorite(o.id, !o.favorite),
                );
              },
            ),
    );
  }
}

class _OutfitCard extends StatelessWidget {
  final Outfit outfit;
  final Item? top, bottom, shoes;
  final List<Item> extras;
  final VoidCallback onTap, onStar;

  const _OutfitCard({
    required this.outfit,
    required this.top,
    required this.bottom,
    required this.shoes,
    required this.extras,
    required this.onTap,
    required this.onStar,
  });

  Widget _slot(Item? it) => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox.expand(
              child: it == null
                  ? Container(color: plum.withOpacity(0.10))
                  : Image.file(File(it.photoPath),
                      fit: BoxFit.cover, cacheWidth: 400),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.93),
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [_slot(top), _slot(bottom), _slot(shoes)],
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    InkResponse(
                      onTap: onStar,
                      child: Icon(
                        outfit.favorite ? Icons.star : Icons.star_border,
                        color: outfit.favorite ? Colors.amber : Colors.black38,
                        size: 26,
                      ),
                    ),
                    const SizedBox(height: 4),
                    for (final e in extras.take(3))
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.file(File(e.photoPath),
                                fit: BoxFit.cover, cacheWidth: 150),
                          ),
                        ),
                      ),
                    if (extras.length > 3)
                      Text('+${extras.length - 3}',
                          style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}