import 'dart:io';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'categories.dart';
import 'database.dart';
import 'providers.dart';
import 'theme.dart';

const _seasonNames = ['İlkbahar', 'Yaz', 'Sonbahar', 'Kış'];
const _seasonIcons = [
  Icons.local_florist,
  Icons.wb_sunny,
  Icons.eco,
  Icons.ac_unit,
];

class ItemScreen extends ConsumerStatefulWidget {
  final Item item;
  final String kind; // wardrobe | dresser | rack
  const ItemScreen({super.key, required this.item, this.kind = 'wardrobe'});

  @override
  ConsumerState<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends ConsumerState<ItemScreen> {
  late final AppDatabase _db;
  late final TextEditingController _brand;
  late final TextEditingController _size;
  late final TextEditingController _notes;
  late int _seasons;
  late String _category;
  bool _deleted = false;

  List<String> get _options => categoryOptions[widget.kind] ?? [];

  @override
  void initState() {
    super.initState();
    _db = ref.read(dbProvider);
    _brand = TextEditingController(text: widget.item.brand);
    _size = TextEditingController(text: widget.item.size);
    _notes = TextEditingController(text: widget.item.notes);
    _seasons = widget.item.seasons;
    _category = widget.item.category;
    // tek seçenek varsa (şifonyer: pijama) otomatik seç
    if (_category.isEmpty && _options.length == 1) _category = _options.first;
  }

  @override
  void dispose() {
    _brand.dispose();
    _size.dispose();
    _notes.dispose();
    super.dispose();
  }

  void _save() {
    if (_deleted) return;
    _db.updateItem(
      widget.item.id,
      ItemsCompanion(
        brand: Value(_brand.text.trim()),
        size: Value(_size.text.trim()),
        notes: Value(_notes.text.trim()),
        seasons: Value(_seasons),
        category: Value(_category),
      ),
    );
  }

  Future<void> _delete() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Bu kıyafet silinsin mi?'),
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
    _deleted = true;
    await _db.deleteItem(widget.item.id);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) _save();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kıyafet'),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: _delete,
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(
                File(widget.item.photoPath),
                height: 320,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            const Text('Kategori',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final c in _options)
                  ChoiceChip(
                    label: Text(c),
                    selected: _category == c,
                    showCheckmark: false,
                    backgroundColor: Colors.white,
                    selectedColor: plum,
                    labelStyle: TextStyle(
                      color: _category == c ? Colors.white : Colors.black87,
                    ),
                    onSelected: (_) => setState(() => _category = c),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _brand,
              decoration: const InputDecoration(labelText: 'Marka'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _size,
              decoration: const InputDecoration(labelText: 'Beden'),
            ),
            const SizedBox(height: 16),
            const Text('Mevsim',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Row(
              children: [
                for (var i = 0; i < 4; i++)
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: i < 3 ? 8 : 0),
                      child: GestureDetector(
                        onTap: () => setState(() => _seasons ^= (1 << i)),
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: (_seasons & (1 << i)) != 0 ? 1.0 : 0.35,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: plum,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Icon(_seasonIcons[i],
                                    color: Colors.white, size: 22),
                                const SizedBox(height: 4),
                                Text(_seasonNames[i],
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _notes,
              minLines: 3,
              maxLines: 6,
              decoration: const InputDecoration(
                labelText: 'Notlar',
                hintText: 'ör. annemindi, hediye geldi',
                alignLabelWithHint: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}