import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

@DataClassName('Furniture')
class Furnitures extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get kind => text()(); // wardrobe | dresser | rack
  TextColumn get photoPath => text().nullable()();
  RealColumn get aspect => real().withDefault(const Constant(0.75))();
}

@DataClassName('Zone')
class Zones extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get furnitureId => integer().references(Furnitures, #id)();
  TextColumn get title => text()();
  RealColumn get x => real()();
  RealColumn get y => real()();
  RealColumn get w => real()();
  RealColumn get h => real()();
}

@DataClassName('Item')
class Items extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get zoneId => integer().references(Zones, #id)();
  TextColumn get photoPath => text()();
  TextColumn get brand => text().withDefault(const Constant(''))();
  TextColumn get size => text().withDefault(const Constant(''))();
  TextColumn get notes => text().withDefault(const Constant(''))();
  // mevsim bitmask: 1=ilkbahar, 2=yaz, 4=sonbahar, 8=kış
  IntColumn get seasons => integer().withDefault(const Constant(0))();
  TextColumn get category => text().withDefault(const Constant(''))();
}

@DataClassName('WeatherLog')
class WeatherLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get temp => integer()();
  TextColumn get outfit => text()(); // eski kayıtlardaki metin
  IntColumn get feeling => integer().withDefault(const Constant(1))();
  TextColumn get comment => text().withDefault(const Constant(''))();
}

@DataClassName('LogItem')
class LogItems extends Table {
  IntColumn get logId => integer().references(WeatherLogs, #id)();
  IntColumn get itemId => integer().references(Items, #id)();

  @override
  Set<Column> get primaryKey => {logId, itemId};
}

@DataClassName('Outfit')
class Outfits extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get favorite => boolean().withDefault(const Constant(false))();
  IntColumn get topId => integer().nullable().references(Items, #id)();
  IntColumn get bottomId => integer().nullable().references(Items, #id)();
  IntColumn get shoesId => integer().nullable().references(Items, #id)();
}

@DataClassName('OutfitExtra')
class OutfitExtras extends Table {
  IntColumn get outfitId => integer().references(Outfits, #id)();
  IntColumn get itemId => integer().references(Items, #id)();

  @override
  Set<Column> get primaryKey => {outfitId, itemId};
}

@DriftDatabase(
    tables: [Furnitures, Zones, Items, WeatherLogs, LogItems, Outfits, OutfitExtras])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'wardrobe'));

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          for (final k in ['wardrobe', 'dresser', 'rack']) {
            await into(furnitures).insert(FurnituresCompanion.insert(kind: k));
          }
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) await m.createTable(items);
          if (from < 3) await m.createTable(weatherLogs);
          if (from < 4) await m.createTable(logItems);
          if (from < 5) {
            if (from >= 2) await m.addColumn(items, items.category);
            await m.createTable(outfits);
            await m.createTable(outfitExtras);
          }
        },
      );

  // --- Furniture
  Stream<List<Furniture>> watchFurnitures() =>
      (select(furnitures)..orderBy([(t) => OrderingTerm.asc(t.id)])).watch();

  Future<void> setPhoto(int id, String path, double aspect) =>
      (update(furnitures)..where((f) => f.id.equals(id))).write(
        FurnituresCompanion(photoPath: Value(path), aspect: Value(aspect)),
      );

  // --- Zones
  Stream<List<Zone>> watchZones(int furnitureId) =>
      (select(zones)..where((z) => z.furnitureId.equals(furnitureId))).watch();

  Future<void> addZone(ZonesCompanion z) => into(zones).insert(z);

  Future<void> renameZone(int id, String title) =>
      (update(zones)..where((z) => z.id.equals(id)))
          .write(ZonesCompanion(title: Value(title)));

  Future<void> deleteZone(int id) async {
    final ids = await (select(items)..where((i) => i.zoneId.equals(id)))
        .map((i) => i.id)
        .get();
    await _detachItems(ids);
    await (delete(items)..where((i) => i.zoneId.equals(id))).go();
    await (delete(zones)..where((z) => z.id.equals(id))).go();
  }

  // --- Items
  Stream<List<Item>> watchItems(int zoneId) => (select(items)
        ..where((i) => i.zoneId.equals(zoneId))
        ..orderBy([(t) => OrderingTerm.desc(t.id)]))
      .watch();

  Stream<List<Item>> watchAllItems() => select(items).watch();

  Future<Item> getItem(int id) =>
      (select(items)..where((i) => i.id.equals(id))).getSingle();

  Future<int> addItem(ItemsCompanion i) => into(items).insert(i);

  Future<void> updateItem(int id, ItemsCompanion c) =>
      (update(items)..where((i) => i.id.equals(id))).write(c);

  Future<void> deleteItem(int id) async {
    await _detachItems([id]);
    await (delete(items)..where((i) => i.id.equals(id))).go();
  }

  /// Kıyafet silinirken loglardan ve kombinlerden çıkarır
  Future<void> _detachItems(List<int> ids) async {
    if (ids.isEmpty) return;
    await (delete(logItems)..where((l) => l.itemId.isIn(ids))).go();
    await (delete(outfitExtras)..where((e) => e.itemId.isIn(ids))).go();
    await (update(outfits)..where((o) => o.topId.isIn(ids)))
        .write(OutfitsCompanion(topId: const Value(null)));
    await (update(outfits)..where((o) => o.bottomId.isIn(ids)))
        .write(OutfitsCompanion(bottomId: const Value(null)));
    await (update(outfits)..where((o) => o.shoesId.isIn(ids)))
        .write(OutfitsCompanion(shoesId: const Value(null)));
  }

  // --- Weather logs
  Stream<List<WeatherLog>> watchLogs() => (select(weatherLogs)
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
      .watch();

  Stream<List<LogItem>> watchLogItems() => select(logItems).watch();

  Future<int> addLog(WeatherLogsCompanion l) => into(weatherLogs).insert(l);

  Future<void> updateLog(int id, WeatherLogsCompanion c) =>
      (update(weatherLogs)..where((l) => l.id.equals(id))).write(c);

  Future<void> setLogItems(int logId, List<int> itemIds) => transaction(() async {
        await (delete(logItems)..where((l) => l.logId.equals(logId))).go();
        for (final id in itemIds) {
          await into(logItems)
              .insert(LogItemsCompanion.insert(logId: logId, itemId: id));
        }
      });

  Future<void> deleteLog(int id) async {
    await (delete(logItems)..where((l) => l.logId.equals(id))).go();
    await (delete(weatherLogs)..where((l) => l.id.equals(id))).go();
  }

  // --- Outfits
  Stream<List<Outfit>> watchOutfits() => (select(outfits)
        ..orderBy([
          (t) => OrderingTerm.desc(t.favorite),
          (t) => OrderingTerm.desc(t.createdAt),
        ]))
      .watch();

  Stream<List<OutfitExtra>> watchOutfitExtras() => select(outfitExtras).watch();

  Future<int> addOutfit(OutfitsCompanion o) => into(outfits).insert(o);

  Future<void> updateOutfit(int id, OutfitsCompanion c) =>
      (update(outfits)..where((o) => o.id.equals(id))).write(c);

  Future<void> toggleFavorite(int id, bool fav) => updateOutfit(
        id,
        OutfitsCompanion(favorite: Value(fav)),
      );

  Future<void> setOutfitExtras(int outfitId, List<int> itemIds) =>
      transaction(() async {
        await (delete(outfitExtras)..where((e) => e.outfitId.equals(outfitId)))
            .go();
        for (final id in itemIds) {
          await into(outfitExtras).insert(
              OutfitExtrasCompanion.insert(outfitId: outfitId, itemId: id));
        }
      });

  Future<void> deleteOutfit(int id) async {
    await (delete(outfitExtras)..where((e) => e.outfitId.equals(id))).go();
    await (delete(outfits)..where((o) => o.id.equals(id))).go();
  }
}