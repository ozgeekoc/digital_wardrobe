import 'dart:io';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'categories.dart';
import 'database.dart';
import 'home_screen.dart';
import 'providers.dart';
import 'theme.dart';

class OutfitEditorScreen extends ConsumerStatefulWidget {
  final Outfit? outfit;
  const OutfitEditorScreen({super.key, this.outfit});

  @override
  ConsumerState<OutfitEditorScreen> createState() => _OutfitEditorScreenState();
}

class _OutfitEditorScreenState extends ConsumerState<OutfitEditorScreen> {
  late final AppDatabase _db;
  int? _top, _bottom, _shoes;
  List<int> _extras = [];
  bool _fav = false;

  @override
  void initState() {
    super.initState();
    _db = ref.read(dbProvider);
    final o = widget.outfit;
    if (o != null) {
      _top = o.topId;
      _bottom = o.bottomId;
      _shoes = o.shoesId;
      _fav = o.favorite;
      _extras = [
        for (final e in ref.read(outfitExtrasProvider).value ?? <OutfitExtra>[])
          if (e.outfitId == o.id) e.itemId
      ];
    }
  }

  BoxDecoration get _frameDeco => BoxDecoration(
        color: plum.withOpacity(0.25),
        border: Border.all(color: plum.withOpacity(0.8), width: 1.5),
        borderRadius: BorderRadius.circular(6),
      );

  Future<void> _pickSlot(String slot, String label) async {
    final res = await Navigator.push<List<int>>(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(
          pick: PickConfig(
            single: true,
            categories: slotCategories[slot]!.toSet(),
            title: '$label seç',
          ),
        ),
      ),
    );
    if (res == null || res.isEmpty || !mounted) return;
    setState(() {
      switch (slot) {
        case 'top':
          _top = res.first;
        case 'bottom':
          _bottom = res.first;
        case 'shoes':
          _shoes = res.first;
      }
    });
  }

  Future<void> _pickExtras() async {
    ref.read(pickSelectionProvider.notifier).state = {..._extras};
    final res = await Navigator.push<List<int>>(
      context,
      MaterialPageRoute(
        builder: (_) => const HomeScreen(pick: PickConfig(title: 'Ekstra parçalar')),
      ),
    );
    if (res != null && mounted) setState(() => _extras = res);
  }

  Future<void> _save() async {
    if (_top == null && _bottom == null && _shoes == null && _extras.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('En az bir parça seç')));
      return;
    }
    final comp = OutfitsCompanion(
      favorite: Value(_fav),
      topId: Value(_top),
      bottomId: Value(_bottom),
      shoesId: Value(_shoes),
    );
    final int id;
    if (widget.outfit == null) {
      id = await _db.addOutfit(comp);
    } else {
      id = widget.outfit!.id;
      await _db.updateOutfit(id, comp);
    }
    await _db.setOutfitExtras(id, _extras);
    if (mounted) Navigator.pop(context);
  }

  Future<void> _delete() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Bu kombin silinsin mi?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Vazgeç')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Sil')),
        ],
      ),
    );
    if (ok != true) return;
    await _db.deleteOutfit(widget.outfit!.id);
    if (mounted) Navigator.pop(context);
  }

  Widget _closeBadge(VoidCallback onTap) => GestureDetector(
        onTap: onTap,
        child: const CircleAvatar(
          radius: 12,
          backgroundColor: Colors.black54,
          child: Icon(Icons.close, size: 14, color: Colors.white),
        ),
      );

  Widget _slotFrame(String label, String slot, int? id, Map<int, Item> byId,
      VoidCallback onClear) {
    final it = id == null ? null : byId[id];
    return Expanded(
      child: GestureDetector(
        onTap: () => _pickSlot(slot, label),
        child: Container(
          width: double.infinity,
          decoration: _frameDeco,
          child: it == null
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add, color: Colors.white, size: 32),
                      Text(label,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.file(File(it.photoPath),
                          fit: BoxFit.cover, cacheWidth: 600),
                      Positioned(top: 4, right: 4, child: _closeBadge(onClear)),
                      Positioned(
                        left: 8,
                        bottom: 6,
                        child: Text(label,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                shadows: [Shadow(blurRadius: 4)])),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _extrasColumn(Map<int, Item> byId) => ListView(
        children: [
          GestureDetector(
            onTap: _pickExtras,
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: _frameDeco,
                child: const Icon(Icons.add, color: Colors.white, size: 32),
              ),
            ),
          ),
          for (final id in _extras)
            if (byId[id] != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: _frameDeco,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.file(File(byId[id]!.photoPath),
                              fit: BoxFit.cover, cacheWidth: 250),
                          Positioned(
                            top: 2,
                            right: 2,
                            child: _closeBadge(
                                () => setState(() => _extras.remove(id))),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final byId = {
      for (final i in ref.watch(allItemsProvider).value ?? <Item>[]) i.id: i
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.outfit == null ? 'Yeni kombin' : 'Kombini düzenle'),
        actions: [
          IconButton(
            icon: Icon(_fav ? Icons.star : Icons.star_border,
                color: _fav ? Colors.amber : Colors.white),
            onPressed: () => setState(() => _fav = !_fav),
          ),
          if (widget.outfit != null)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: _delete,
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          _slotFrame('Üst', 'top', _top, byId,
                              () => setState(() => _top = null)),
                          const SizedBox(height: 12),
                          _slotFrame('Alt', 'bottom', _bottom, byId,
                              () => setState(() => _bottom = null)),
                          const SizedBox(height: 12),
                          _slotFrame('Ayakkabı', 'shoes', _shoes, byId,
                              () => setState(() => _shoes = null)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(width: 88, child: _extrasColumn(byId)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _save,
                  child: const Text('Kaydet'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}