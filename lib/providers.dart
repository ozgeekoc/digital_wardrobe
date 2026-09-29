import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'database.dart';

final dbProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final furnituresProvider = StreamProvider<List<Furniture>>(
    (ref) => ref.watch(dbProvider).watchFurnitures());

final zonesProvider = StreamProvider.family<List<Zone>, int>(
    (ref, id) => ref.watch(dbProvider).watchZones(id));

/// Alan çizme modu açıkken sayfa kaydırma kilitlenir.
final editModeProvider = StateProvider<bool>((ref) => false);

final itemsProvider = StreamProvider.family<List<Item>, int>(
    (ref, zoneId) => ref.watch(dbProvider).watchItems(zoneId));

final logsProvider = StreamProvider<List<WeatherLog>>(
    (ref) => ref.watch(dbProvider).watchLogs());

final allItemsProvider = StreamProvider<List<Item>>(
    (ref) => ref.watch(dbProvider).watchAllItems());

final logItemsProvider = StreamProvider<List<LogItem>>(
    (ref) => ref.watch(dbProvider).watchLogItems());

/// Seçim modunda işaretlenen kıyafet id'leri
final pickSelectionProvider = StateProvider<Set<int>>((ref) => {});

final outfitsProvider = StreamProvider<List<Outfit>>(
    (ref) => ref.watch(dbProvider).watchOutfits());

final outfitExtrasProvider = StreamProvider<List<OutfitExtra>>(
    (ref) => ref.watch(dbProvider).watchOutfitExtras());