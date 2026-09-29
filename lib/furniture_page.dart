import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'database.dart';
import 'providers.dart';
import 'theme.dart';
import 'zone_screen.dart';
import 'categories.dart';

const _names = {'wardrobe': 'Gardırop', 'dresser': 'Şifonyer', 'rack': 'Askılık'};

class FurniturePage extends ConsumerStatefulWidget {
  final Furniture furniture;
  final PickConfig? pick;
  const FurniturePage({super.key, required this.furniture, this.pick});

  bool get pickMode => pick != null;

  @override
  ConsumerState<FurniturePage> createState() => _FurniturePageState();
}

class _FurniturePageState extends ConsumerState<FurniturePage> {
  Offset? _a, _b; // çizim sırasında normalize noktalar

  Future<void> _pickPhoto() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    final dir = await getApplicationDocumentsDirectory();
    final dest = p.join(dir.path,
        'furniture_${widget.furniture.id}_${DateTime.now().millisecondsSinceEpoch}.jpg');
    await File(picked.path).copy(dest);
    final img = await decodeImageFromList(await File(dest).readAsBytes());
    await ref
        .read(dbProvider)
        .setPhoto(widget.furniture.id, dest, img.width / img.height);
  }

  Future<({String? title, bool delete})?> _zoneDialog(
      {String? initial, bool canDelete = false}) {
    final c = TextEditingController(text: initial);
    return showDialog<({String? title, bool delete})>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(canDelete ? 'Alanı düzenle' : 'Bu alanın adı ne?'),
        content: TextField(
          controller: c,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'ör. Sol kapak, Çekmece 1'),
        ),
        actions: [
          if (canDelete)
            TextButton(
              onPressed: () => Navigator.pop(ctx, (title: null, delete: true)),
              child: const Text('Sil'),
            ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Vazgeç'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.pop(ctx, (title: c.text.trim(), delete: false)),
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );
  }

  Future<void> _finishDraw() async {
    if (_a == null || _b == null) return;
    final r = Rect.fromPoints(_a!, _b!);
    setState(() => _a = _b = null);
    if (r.width < 0.05 || r.height < 0.05) return; // yanlışlıkla dokunma
    final res = await _zoneDialog();
    if (res?.title == null || res!.title!.isEmpty) return;
    await ref.read(dbProvider).addZone(ZonesCompanion.insert(
          furnitureId: widget.furniture.id,
          title: res.title!,
          x: r.left,
          y: r.top,
          w: r.width,
          h: r.height,
        ));
  }

  Future<void> _onZoneTap(Zone z, bool editing) async {
    if (!editing) {
      final id = await Navigator.push<int>(
        context,
        MaterialPageRoute(builder: (_) => ZoneScreen(zone: z, pick: widget.pick)),
      );
      // tek seçimde kıyafete dokunulduysa seçim ekranını da kapat
      if (widget.pick?.single == true && id != null && mounted) {
        Navigator.pop(context, <int>[id]);
      }
      return;
    }
    final res = await _zoneDialog(initial: z.title, canDelete: true);
    if (res == null) return;
    final db = ref.read(dbProvider);
    if (res.delete) {
      await db.deleteZone(z.id);
    } else if (res.title != null && res.title!.isNotEmpty) {
      await db.renameZone(z.id, res.title!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final f = widget.furniture;
    final editing = ref.watch(editModeProvider) && !widget.pickMode;
    final zones = ref.watch(zonesProvider(f.id)).value ?? [];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 8, 0),
          child: Row(
            children: [
              Text(
                _names[f.kind] ?? f.kind,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.white),
              ),
              const Spacer(),
              if (!widget.pickMode) ...[
                IconButton(
                  tooltip: 'Fotoğraf değiştir',
                  icon: const Icon(Icons.photo_library_outlined),
                  onPressed: _pickPhoto,
                ),
                if (f.photoPath != null)
                  IconButton(
                    tooltip: 'Alanları düzenle',
                    icon: Icon(editing ? Icons.check_circle : Icons.edit_outlined),
                    onPressed: () =>
                        ref.read(editModeProvider.notifier).state = !editing,
                  ),
              ],
            ],
          ),
        ),
        if (editing)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Parmağınla dikdörtgen çiz. Var olan alana dokunursan düzenlersin.',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        Expanded(
          child: f.photoPath == null
              ? _placeholder()
              : Padding(
                  padding: const EdgeInsets.all(12),
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: f.aspect,
                      child: LayoutBuilder(builder: (context, box) {
                        final w = box.maxWidth, h = box.maxHeight;
                        Offset norm(Offset o) => Offset(
                            (o.dx / w).clamp(0.0, 1.0),
                            (o.dy / h).clamp(0.0, 1.0));
                        final drawing =
                            _a != null && _b != null ? Rect.fromPoints(_a!, _b!) : null;

                        return GestureDetector(
                          onPanStart: editing
                              ? (d) => setState(
                                  () => _a = _b = norm(d.localPosition))
                              : null,
                          onPanUpdate: editing
                              ? (d) => setState(() => _b = norm(d.localPosition))
                              : null,
                          onPanEnd: editing ? (_) => _finishDraw() : null,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.file(File(f.photoPath!),
                                    fit: BoxFit.fill),
                              ),
                              for (final z in zones)
                                Positioned(
                                  left: z.x * w,
                                  top: z.y * h,
                                  width: z.w * w,
                                  height: z.h * h,
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () => _onZoneTap(z, editing),
                                    child: _zoneBox(z.title, editing),
                                  ),
                                ),
                              if (drawing != null)
                                Positioned(
                                  left: drawing.left * w,
                                  top: drawing.top * h,
                                  width: drawing.width * w,
                                  height: drawing.height * h,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: plum.withOpacity(0.3),
                                      border: Border.all(color: plum, width: 2),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _zoneBox(String title, bool editing) => Container(
        decoration: BoxDecoration(
          color: plum.withOpacity(editing ? 0.25 : 0.10),
          border: Border.all(color: plum.withOpacity(0.8), width: 1.5),
          borderRadius: BorderRadius.circular(6),
        ),
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.all(4),
        child: editing
            ? Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    shadows: [Shadow(blurRadius: 4)]))
            : null,
      );

  Widget _placeholder() => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 200,
              height: 280,
              decoration: BoxDecoration(
                color: plum,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.checkroom, color: Colors.white54, size: 72),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _pickPhoto,
              icon: const Icon(Icons.add_a_photo_outlined),
              label: const Text('Fotoğraf ekle'),
            ),
          ],
        ),
      );
}