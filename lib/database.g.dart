// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $FurnituresTable extends Furnitures
    with TableInfo<$FurnituresTable, Furniture> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FurnituresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _aspectMeta = const VerificationMeta('aspect');
  @override
  late final GeneratedColumn<double> aspect = GeneratedColumn<double>(
    'aspect',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.75),
  );
  @override
  List<GeneratedColumn> get $columns => [id, kind, photoPath, aspect];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'furnitures';
  @override
  VerificationContext validateIntegrity(
    Insertable<Furniture> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    if (data.containsKey('aspect')) {
      context.handle(
        _aspectMeta,
        aspect.isAcceptableOrUnknown(data['aspect']!, _aspectMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Furniture map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Furniture(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
      aspect: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}aspect'],
      )!,
    );
  }

  @override
  $FurnituresTable createAlias(String alias) {
    return $FurnituresTable(attachedDatabase, alias);
  }
}

class Furniture extends DataClass implements Insertable<Furniture> {
  final int id;
  final String kind;
  final String? photoPath;
  final double aspect;
  const Furniture({
    required this.id,
    required this.kind,
    this.photoPath,
    required this.aspect,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kind'] = Variable<String>(kind);
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    map['aspect'] = Variable<double>(aspect);
    return map;
  }

  FurnituresCompanion toCompanion(bool nullToAbsent) {
    return FurnituresCompanion(
      id: Value(id),
      kind: Value(kind),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      aspect: Value(aspect),
    );
  }

  factory Furniture.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Furniture(
      id: serializer.fromJson<int>(json['id']),
      kind: serializer.fromJson<String>(json['kind']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      aspect: serializer.fromJson<double>(json['aspect']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kind': serializer.toJson<String>(kind),
      'photoPath': serializer.toJson<String?>(photoPath),
      'aspect': serializer.toJson<double>(aspect),
    };
  }

  Furniture copyWith({
    int? id,
    String? kind,
    Value<String?> photoPath = const Value.absent(),
    double? aspect,
  }) => Furniture(
    id: id ?? this.id,
    kind: kind ?? this.kind,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
    aspect: aspect ?? this.aspect,
  );
  Furniture copyWithCompanion(FurnituresCompanion data) {
    return Furniture(
      id: data.id.present ? data.id.value : this.id,
      kind: data.kind.present ? data.kind.value : this.kind,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      aspect: data.aspect.present ? data.aspect.value : this.aspect,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Furniture(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('photoPath: $photoPath, ')
          ..write('aspect: $aspect')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, kind, photoPath, aspect);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Furniture &&
          other.id == this.id &&
          other.kind == this.kind &&
          other.photoPath == this.photoPath &&
          other.aspect == this.aspect);
}

class FurnituresCompanion extends UpdateCompanion<Furniture> {
  final Value<int> id;
  final Value<String> kind;
  final Value<String?> photoPath;
  final Value<double> aspect;
  const FurnituresCompanion({
    this.id = const Value.absent(),
    this.kind = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.aspect = const Value.absent(),
  });
  FurnituresCompanion.insert({
    this.id = const Value.absent(),
    required String kind,
    this.photoPath = const Value.absent(),
    this.aspect = const Value.absent(),
  }) : kind = Value(kind);
  static Insertable<Furniture> custom({
    Expression<int>? id,
    Expression<String>? kind,
    Expression<String>? photoPath,
    Expression<double>? aspect,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kind != null) 'kind': kind,
      if (photoPath != null) 'photo_path': photoPath,
      if (aspect != null) 'aspect': aspect,
    });
  }

  FurnituresCompanion copyWith({
    Value<int>? id,
    Value<String>? kind,
    Value<String?>? photoPath,
    Value<double>? aspect,
  }) {
    return FurnituresCompanion(
      id: id ?? this.id,
      kind: kind ?? this.kind,
      photoPath: photoPath ?? this.photoPath,
      aspect: aspect ?? this.aspect,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (aspect.present) {
      map['aspect'] = Variable<double>(aspect.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FurnituresCompanion(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('photoPath: $photoPath, ')
          ..write('aspect: $aspect')
          ..write(')'))
        .toString();
  }
}

class $ZonesTable extends Zones with TableInfo<$ZonesTable, Zone> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ZonesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _furnitureIdMeta = const VerificationMeta(
    'furnitureId',
  );
  @override
  late final GeneratedColumn<int> furnitureId = GeneratedColumn<int>(
    'furniture_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES furnitures (id)',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _xMeta = const VerificationMeta('x');
  @override
  late final GeneratedColumn<double> x = GeneratedColumn<double>(
    'x',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yMeta = const VerificationMeta('y');
  @override
  late final GeneratedColumn<double> y = GeneratedColumn<double>(
    'y',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wMeta = const VerificationMeta('w');
  @override
  late final GeneratedColumn<double> w = GeneratedColumn<double>(
    'w',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hMeta = const VerificationMeta('h');
  @override
  late final GeneratedColumn<double> h = GeneratedColumn<double>(
    'h',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, furnitureId, title, x, y, w, h];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'zones';
  @override
  VerificationContext validateIntegrity(
    Insertable<Zone> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('furniture_id')) {
      context.handle(
        _furnitureIdMeta,
        furnitureId.isAcceptableOrUnknown(
          data['furniture_id']!,
          _furnitureIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_furnitureIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('x')) {
      context.handle(_xMeta, x.isAcceptableOrUnknown(data['x']!, _xMeta));
    } else if (isInserting) {
      context.missing(_xMeta);
    }
    if (data.containsKey('y')) {
      context.handle(_yMeta, y.isAcceptableOrUnknown(data['y']!, _yMeta));
    } else if (isInserting) {
      context.missing(_yMeta);
    }
    if (data.containsKey('w')) {
      context.handle(_wMeta, w.isAcceptableOrUnknown(data['w']!, _wMeta));
    } else if (isInserting) {
      context.missing(_wMeta);
    }
    if (data.containsKey('h')) {
      context.handle(_hMeta, h.isAcceptableOrUnknown(data['h']!, _hMeta));
    } else if (isInserting) {
      context.missing(_hMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Zone map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Zone(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      furnitureId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}furniture_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      x: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}x'],
      )!,
      y: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}y'],
      )!,
      w: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}w'],
      )!,
      h: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}h'],
      )!,
    );
  }

  @override
  $ZonesTable createAlias(String alias) {
    return $ZonesTable(attachedDatabase, alias);
  }
}

class Zone extends DataClass implements Insertable<Zone> {
  final int id;
  final int furnitureId;
  final String title;
  final double x;
  final double y;
  final double w;
  final double h;
  const Zone({
    required this.id,
    required this.furnitureId,
    required this.title,
    required this.x,
    required this.y,
    required this.w,
    required this.h,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['furniture_id'] = Variable<int>(furnitureId);
    map['title'] = Variable<String>(title);
    map['x'] = Variable<double>(x);
    map['y'] = Variable<double>(y);
    map['w'] = Variable<double>(w);
    map['h'] = Variable<double>(h);
    return map;
  }

  ZonesCompanion toCompanion(bool nullToAbsent) {
    return ZonesCompanion(
      id: Value(id),
      furnitureId: Value(furnitureId),
      title: Value(title),
      x: Value(x),
      y: Value(y),
      w: Value(w),
      h: Value(h),
    );
  }

  factory Zone.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Zone(
      id: serializer.fromJson<int>(json['id']),
      furnitureId: serializer.fromJson<int>(json['furnitureId']),
      title: serializer.fromJson<String>(json['title']),
      x: serializer.fromJson<double>(json['x']),
      y: serializer.fromJson<double>(json['y']),
      w: serializer.fromJson<double>(json['w']),
      h: serializer.fromJson<double>(json['h']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'furnitureId': serializer.toJson<int>(furnitureId),
      'title': serializer.toJson<String>(title),
      'x': serializer.toJson<double>(x),
      'y': serializer.toJson<double>(y),
      'w': serializer.toJson<double>(w),
      'h': serializer.toJson<double>(h),
    };
  }

  Zone copyWith({
    int? id,
    int? furnitureId,
    String? title,
    double? x,
    double? y,
    double? w,
    double? h,
  }) => Zone(
    id: id ?? this.id,
    furnitureId: furnitureId ?? this.furnitureId,
    title: title ?? this.title,
    x: x ?? this.x,
    y: y ?? this.y,
    w: w ?? this.w,
    h: h ?? this.h,
  );
  Zone copyWithCompanion(ZonesCompanion data) {
    return Zone(
      id: data.id.present ? data.id.value : this.id,
      furnitureId: data.furnitureId.present
          ? data.furnitureId.value
          : this.furnitureId,
      title: data.title.present ? data.title.value : this.title,
      x: data.x.present ? data.x.value : this.x,
      y: data.y.present ? data.y.value : this.y,
      w: data.w.present ? data.w.value : this.w,
      h: data.h.present ? data.h.value : this.h,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Zone(')
          ..write('id: $id, ')
          ..write('furnitureId: $furnitureId, ')
          ..write('title: $title, ')
          ..write('x: $x, ')
          ..write('y: $y, ')
          ..write('w: $w, ')
          ..write('h: $h')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, furnitureId, title, x, y, w, h);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Zone &&
          other.id == this.id &&
          other.furnitureId == this.furnitureId &&
          other.title == this.title &&
          other.x == this.x &&
          other.y == this.y &&
          other.w == this.w &&
          other.h == this.h);
}

class ZonesCompanion extends UpdateCompanion<Zone> {
  final Value<int> id;
  final Value<int> furnitureId;
  final Value<String> title;
  final Value<double> x;
  final Value<double> y;
  final Value<double> w;
  final Value<double> h;
  const ZonesCompanion({
    this.id = const Value.absent(),
    this.furnitureId = const Value.absent(),
    this.title = const Value.absent(),
    this.x = const Value.absent(),
    this.y = const Value.absent(),
    this.w = const Value.absent(),
    this.h = const Value.absent(),
  });
  ZonesCompanion.insert({
    this.id = const Value.absent(),
    required int furnitureId,
    required String title,
    required double x,
    required double y,
    required double w,
    required double h,
  }) : furnitureId = Value(furnitureId),
       title = Value(title),
       x = Value(x),
       y = Value(y),
       w = Value(w),
       h = Value(h);
  static Insertable<Zone> custom({
    Expression<int>? id,
    Expression<int>? furnitureId,
    Expression<String>? title,
    Expression<double>? x,
    Expression<double>? y,
    Expression<double>? w,
    Expression<double>? h,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (furnitureId != null) 'furniture_id': furnitureId,
      if (title != null) 'title': title,
      if (x != null) 'x': x,
      if (y != null) 'y': y,
      if (w != null) 'w': w,
      if (h != null) 'h': h,
    });
  }

  ZonesCompanion copyWith({
    Value<int>? id,
    Value<int>? furnitureId,
    Value<String>? title,
    Value<double>? x,
    Value<double>? y,
    Value<double>? w,
    Value<double>? h,
  }) {
    return ZonesCompanion(
      id: id ?? this.id,
      furnitureId: furnitureId ?? this.furnitureId,
      title: title ?? this.title,
      x: x ?? this.x,
      y: y ?? this.y,
      w: w ?? this.w,
      h: h ?? this.h,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (furnitureId.present) {
      map['furniture_id'] = Variable<int>(furnitureId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (x.present) {
      map['x'] = Variable<double>(x.value);
    }
    if (y.present) {
      map['y'] = Variable<double>(y.value);
    }
    if (w.present) {
      map['w'] = Variable<double>(w.value);
    }
    if (h.present) {
      map['h'] = Variable<double>(h.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ZonesCompanion(')
          ..write('id: $id, ')
          ..write('furnitureId: $furnitureId, ')
          ..write('title: $title, ')
          ..write('x: $x, ')
          ..write('y: $y, ')
          ..write('w: $w, ')
          ..write('h: $h')
          ..write(')'))
        .toString();
  }
}

class $ItemsTable extends Items with TableInfo<$ItemsTable, Item> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _zoneIdMeta = const VerificationMeta('zoneId');
  @override
  late final GeneratedColumn<int> zoneId = GeneratedColumn<int>(
    'zone_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES zones (id)',
    ),
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<String> size = GeneratedColumn<String>(
    'size',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _seasonsMeta = const VerificationMeta(
    'seasons',
  );
  @override
  late final GeneratedColumn<int> seasons = GeneratedColumn<int>(
    'seasons',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    zoneId,
    photoPath,
    brand,
    size,
    notes,
    seasons,
    category,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'items';
  @override
  VerificationContext validateIntegrity(
    Insertable<Item> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('zone_id')) {
      context.handle(
        _zoneIdMeta,
        zoneId.isAcceptableOrUnknown(data['zone_id']!, _zoneIdMeta),
      );
    } else if (isInserting) {
      context.missing(_zoneIdMeta);
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    } else if (isInserting) {
      context.missing(_photoPathMeta);
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    }
    if (data.containsKey('size')) {
      context.handle(
        _sizeMeta,
        size.isAcceptableOrUnknown(data['size']!, _sizeMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('seasons')) {
      context.handle(
        _seasonsMeta,
        seasons.isAcceptableOrUnknown(data['seasons']!, _seasonsMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Item map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Item(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      zoneId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}zone_id'],
      )!,
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      )!,
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      )!,
      size: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}size'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      seasons: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}seasons'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
    );
  }

  @override
  $ItemsTable createAlias(String alias) {
    return $ItemsTable(attachedDatabase, alias);
  }
}

class Item extends DataClass implements Insertable<Item> {
  final int id;
  final int zoneId;
  final String photoPath;
  final String brand;
  final String size;
  final String notes;
  final int seasons;
  final String category;
  const Item({
    required this.id,
    required this.zoneId,
    required this.photoPath,
    required this.brand,
    required this.size,
    required this.notes,
    required this.seasons,
    required this.category,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['zone_id'] = Variable<int>(zoneId);
    map['photo_path'] = Variable<String>(photoPath);
    map['brand'] = Variable<String>(brand);
    map['size'] = Variable<String>(size);
    map['notes'] = Variable<String>(notes);
    map['seasons'] = Variable<int>(seasons);
    map['category'] = Variable<String>(category);
    return map;
  }

  ItemsCompanion toCompanion(bool nullToAbsent) {
    return ItemsCompanion(
      id: Value(id),
      zoneId: Value(zoneId),
      photoPath: Value(photoPath),
      brand: Value(brand),
      size: Value(size),
      notes: Value(notes),
      seasons: Value(seasons),
      category: Value(category),
    );
  }

  factory Item.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Item(
      id: serializer.fromJson<int>(json['id']),
      zoneId: serializer.fromJson<int>(json['zoneId']),
      photoPath: serializer.fromJson<String>(json['photoPath']),
      brand: serializer.fromJson<String>(json['brand']),
      size: serializer.fromJson<String>(json['size']),
      notes: serializer.fromJson<String>(json['notes']),
      seasons: serializer.fromJson<int>(json['seasons']),
      category: serializer.fromJson<String>(json['category']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'zoneId': serializer.toJson<int>(zoneId),
      'photoPath': serializer.toJson<String>(photoPath),
      'brand': serializer.toJson<String>(brand),
      'size': serializer.toJson<String>(size),
      'notes': serializer.toJson<String>(notes),
      'seasons': serializer.toJson<int>(seasons),
      'category': serializer.toJson<String>(category),
    };
  }

  Item copyWith({
    int? id,
    int? zoneId,
    String? photoPath,
    String? brand,
    String? size,
    String? notes,
    int? seasons,
    String? category,
  }) => Item(
    id: id ?? this.id,
    zoneId: zoneId ?? this.zoneId,
    photoPath: photoPath ?? this.photoPath,
    brand: brand ?? this.brand,
    size: size ?? this.size,
    notes: notes ?? this.notes,
    seasons: seasons ?? this.seasons,
    category: category ?? this.category,
  );
  Item copyWithCompanion(ItemsCompanion data) {
    return Item(
      id: data.id.present ? data.id.value : this.id,
      zoneId: data.zoneId.present ? data.zoneId.value : this.zoneId,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      brand: data.brand.present ? data.brand.value : this.brand,
      size: data.size.present ? data.size.value : this.size,
      notes: data.notes.present ? data.notes.value : this.notes,
      seasons: data.seasons.present ? data.seasons.value : this.seasons,
      category: data.category.present ? data.category.value : this.category,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Item(')
          ..write('id: $id, ')
          ..write('zoneId: $zoneId, ')
          ..write('photoPath: $photoPath, ')
          ..write('brand: $brand, ')
          ..write('size: $size, ')
          ..write('notes: $notes, ')
          ..write('seasons: $seasons, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, zoneId, photoPath, brand, size, notes, seasons, category);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Item &&
          other.id == this.id &&
          other.zoneId == this.zoneId &&
          other.photoPath == this.photoPath &&
          other.brand == this.brand &&
          other.size == this.size &&
          other.notes == this.notes &&
          other.seasons == this.seasons &&
          other.category == this.category);
}

class ItemsCompanion extends UpdateCompanion<Item> {
  final Value<int> id;
  final Value<int> zoneId;
  final Value<String> photoPath;
  final Value<String> brand;
  final Value<String> size;
  final Value<String> notes;
  final Value<int> seasons;
  final Value<String> category;
  const ItemsCompanion({
    this.id = const Value.absent(),
    this.zoneId = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.brand = const Value.absent(),
    this.size = const Value.absent(),
    this.notes = const Value.absent(),
    this.seasons = const Value.absent(),
    this.category = const Value.absent(),
  });
  ItemsCompanion.insert({
    this.id = const Value.absent(),
    required int zoneId,
    required String photoPath,
    this.brand = const Value.absent(),
    this.size = const Value.absent(),
    this.notes = const Value.absent(),
    this.seasons = const Value.absent(),
    this.category = const Value.absent(),
  }) : zoneId = Value(zoneId),
       photoPath = Value(photoPath);
  static Insertable<Item> custom({
    Expression<int>? id,
    Expression<int>? zoneId,
    Expression<String>? photoPath,
    Expression<String>? brand,
    Expression<String>? size,
    Expression<String>? notes,
    Expression<int>? seasons,
    Expression<String>? category,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (zoneId != null) 'zone_id': zoneId,
      if (photoPath != null) 'photo_path': photoPath,
      if (brand != null) 'brand': brand,
      if (size != null) 'size': size,
      if (notes != null) 'notes': notes,
      if (seasons != null) 'seasons': seasons,
      if (category != null) 'category': category,
    });
  }

  ItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? zoneId,
    Value<String>? photoPath,
    Value<String>? brand,
    Value<String>? size,
    Value<String>? notes,
    Value<int>? seasons,
    Value<String>? category,
  }) {
    return ItemsCompanion(
      id: id ?? this.id,
      zoneId: zoneId ?? this.zoneId,
      photoPath: photoPath ?? this.photoPath,
      brand: brand ?? this.brand,
      size: size ?? this.size,
      notes: notes ?? this.notes,
      seasons: seasons ?? this.seasons,
      category: category ?? this.category,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (zoneId.present) {
      map['zone_id'] = Variable<int>(zoneId.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (size.present) {
      map['size'] = Variable<String>(size.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (seasons.present) {
      map['seasons'] = Variable<int>(seasons.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemsCompanion(')
          ..write('id: $id, ')
          ..write('zoneId: $zoneId, ')
          ..write('photoPath: $photoPath, ')
          ..write('brand: $brand, ')
          ..write('size: $size, ')
          ..write('notes: $notes, ')
          ..write('seasons: $seasons, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }
}

class $WeatherLogsTable extends WeatherLogs
    with TableInfo<$WeatherLogsTable, WeatherLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeatherLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _tempMeta = const VerificationMeta('temp');
  @override
  late final GeneratedColumn<int> temp = GeneratedColumn<int>(
    'temp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _outfitMeta = const VerificationMeta('outfit');
  @override
  late final GeneratedColumn<String> outfit = GeneratedColumn<String>(
    'outfit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _feelingMeta = const VerificationMeta(
    'feeling',
  );
  @override
  late final GeneratedColumn<int> feeling = GeneratedColumn<int>(
    'feeling',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _commentMeta = const VerificationMeta(
    'comment',
  );
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
    'comment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    temp,
    outfit,
    feeling,
    comment,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weather_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeatherLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('temp')) {
      context.handle(
        _tempMeta,
        temp.isAcceptableOrUnknown(data['temp']!, _tempMeta),
      );
    } else if (isInserting) {
      context.missing(_tempMeta);
    }
    if (data.containsKey('outfit')) {
      context.handle(
        _outfitMeta,
        outfit.isAcceptableOrUnknown(data['outfit']!, _outfitMeta),
      );
    } else if (isInserting) {
      context.missing(_outfitMeta);
    }
    if (data.containsKey('feeling')) {
      context.handle(
        _feelingMeta,
        feeling.isAcceptableOrUnknown(data['feeling']!, _feelingMeta),
      );
    }
    if (data.containsKey('comment')) {
      context.handle(
        _commentMeta,
        comment.isAcceptableOrUnknown(data['comment']!, _commentMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeatherLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeatherLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      temp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}temp'],
      )!,
      outfit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}outfit'],
      )!,
      feeling: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}feeling'],
      )!,
      comment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comment'],
      )!,
    );
  }

  @override
  $WeatherLogsTable createAlias(String alias) {
    return $WeatherLogsTable(attachedDatabase, alias);
  }
}

class WeatherLog extends DataClass implements Insertable<WeatherLog> {
  final int id;
  final DateTime createdAt;
  final int temp;
  final String outfit;
  final int feeling;
  final String comment;
  const WeatherLog({
    required this.id,
    required this.createdAt,
    required this.temp,
    required this.outfit,
    required this.feeling,
    required this.comment,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['temp'] = Variable<int>(temp);
    map['outfit'] = Variable<String>(outfit);
    map['feeling'] = Variable<int>(feeling);
    map['comment'] = Variable<String>(comment);
    return map;
  }

  WeatherLogsCompanion toCompanion(bool nullToAbsent) {
    return WeatherLogsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      temp: Value(temp),
      outfit: Value(outfit),
      feeling: Value(feeling),
      comment: Value(comment),
    );
  }

  factory WeatherLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeatherLog(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      temp: serializer.fromJson<int>(json['temp']),
      outfit: serializer.fromJson<String>(json['outfit']),
      feeling: serializer.fromJson<int>(json['feeling']),
      comment: serializer.fromJson<String>(json['comment']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'temp': serializer.toJson<int>(temp),
      'outfit': serializer.toJson<String>(outfit),
      'feeling': serializer.toJson<int>(feeling),
      'comment': serializer.toJson<String>(comment),
    };
  }

  WeatherLog copyWith({
    int? id,
    DateTime? createdAt,
    int? temp,
    String? outfit,
    int? feeling,
    String? comment,
  }) => WeatherLog(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    temp: temp ?? this.temp,
    outfit: outfit ?? this.outfit,
    feeling: feeling ?? this.feeling,
    comment: comment ?? this.comment,
  );
  WeatherLog copyWithCompanion(WeatherLogsCompanion data) {
    return WeatherLog(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      temp: data.temp.present ? data.temp.value : this.temp,
      outfit: data.outfit.present ? data.outfit.value : this.outfit,
      feeling: data.feeling.present ? data.feeling.value : this.feeling,
      comment: data.comment.present ? data.comment.value : this.comment,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeatherLog(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('temp: $temp, ')
          ..write('outfit: $outfit, ')
          ..write('feeling: $feeling, ')
          ..write('comment: $comment')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, temp, outfit, feeling, comment);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeatherLog &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.temp == this.temp &&
          other.outfit == this.outfit &&
          other.feeling == this.feeling &&
          other.comment == this.comment);
}

class WeatherLogsCompanion extends UpdateCompanion<WeatherLog> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<int> temp;
  final Value<String> outfit;
  final Value<int> feeling;
  final Value<String> comment;
  const WeatherLogsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.temp = const Value.absent(),
    this.outfit = const Value.absent(),
    this.feeling = const Value.absent(),
    this.comment = const Value.absent(),
  });
  WeatherLogsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    required int temp,
    required String outfit,
    this.feeling = const Value.absent(),
    this.comment = const Value.absent(),
  }) : temp = Value(temp),
       outfit = Value(outfit);
  static Insertable<WeatherLog> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<int>? temp,
    Expression<String>? outfit,
    Expression<int>? feeling,
    Expression<String>? comment,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (temp != null) 'temp': temp,
      if (outfit != null) 'outfit': outfit,
      if (feeling != null) 'feeling': feeling,
      if (comment != null) 'comment': comment,
    });
  }

  WeatherLogsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<int>? temp,
    Value<String>? outfit,
    Value<int>? feeling,
    Value<String>? comment,
  }) {
    return WeatherLogsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      temp: temp ?? this.temp,
      outfit: outfit ?? this.outfit,
      feeling: feeling ?? this.feeling,
      comment: comment ?? this.comment,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (temp.present) {
      map['temp'] = Variable<int>(temp.value);
    }
    if (outfit.present) {
      map['outfit'] = Variable<String>(outfit.value);
    }
    if (feeling.present) {
      map['feeling'] = Variable<int>(feeling.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeatherLogsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('temp: $temp, ')
          ..write('outfit: $outfit, ')
          ..write('feeling: $feeling, ')
          ..write('comment: $comment')
          ..write(')'))
        .toString();
  }
}

class $LogItemsTable extends LogItems with TableInfo<$LogItemsTable, LogItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LogItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _logIdMeta = const VerificationMeta('logId');
  @override
  late final GeneratedColumn<int> logId = GeneratedColumn<int>(
    'log_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES weather_logs (id)',
    ),
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<int> itemId = GeneratedColumn<int>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES items (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [logId, itemId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'log_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<LogItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('log_id')) {
      context.handle(
        _logIdMeta,
        logId.isAcceptableOrUnknown(data['log_id']!, _logIdMeta),
      );
    } else if (isInserting) {
      context.missing(_logIdMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {logId, itemId};
  @override
  LogItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LogItem(
      logId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}log_id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}item_id'],
      )!,
    );
  }

  @override
  $LogItemsTable createAlias(String alias) {
    return $LogItemsTable(attachedDatabase, alias);
  }
}

class LogItem extends DataClass implements Insertable<LogItem> {
  final int logId;
  final int itemId;
  const LogItem({required this.logId, required this.itemId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['log_id'] = Variable<int>(logId);
    map['item_id'] = Variable<int>(itemId);
    return map;
  }

  LogItemsCompanion toCompanion(bool nullToAbsent) {
    return LogItemsCompanion(logId: Value(logId), itemId: Value(itemId));
  }

  factory LogItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LogItem(
      logId: serializer.fromJson<int>(json['logId']),
      itemId: serializer.fromJson<int>(json['itemId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'logId': serializer.toJson<int>(logId),
      'itemId': serializer.toJson<int>(itemId),
    };
  }

  LogItem copyWith({int? logId, int? itemId}) =>
      LogItem(logId: logId ?? this.logId, itemId: itemId ?? this.itemId);
  LogItem copyWithCompanion(LogItemsCompanion data) {
    return LogItem(
      logId: data.logId.present ? data.logId.value : this.logId,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LogItem(')
          ..write('logId: $logId, ')
          ..write('itemId: $itemId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(logId, itemId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LogItem &&
          other.logId == this.logId &&
          other.itemId == this.itemId);
}

class LogItemsCompanion extends UpdateCompanion<LogItem> {
  final Value<int> logId;
  final Value<int> itemId;
  final Value<int> rowid;
  const LogItemsCompanion({
    this.logId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LogItemsCompanion.insert({
    required int logId,
    required int itemId,
    this.rowid = const Value.absent(),
  }) : logId = Value(logId),
       itemId = Value(itemId);
  static Insertable<LogItem> custom({
    Expression<int>? logId,
    Expression<int>? itemId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (logId != null) 'log_id': logId,
      if (itemId != null) 'item_id': itemId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LogItemsCompanion copyWith({
    Value<int>? logId,
    Value<int>? itemId,
    Value<int>? rowid,
  }) {
    return LogItemsCompanion(
      logId: logId ?? this.logId,
      itemId: itemId ?? this.itemId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (logId.present) {
      map['log_id'] = Variable<int>(logId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LogItemsCompanion(')
          ..write('logId: $logId, ')
          ..write('itemId: $itemId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OutfitsTable extends Outfits with TableInfo<$OutfitsTable, Outfit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OutfitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _favoriteMeta = const VerificationMeta(
    'favorite',
  );
  @override
  late final GeneratedColumn<bool> favorite = GeneratedColumn<bool>(
    'favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _topIdMeta = const VerificationMeta('topId');
  @override
  late final GeneratedColumn<int> topId = GeneratedColumn<int>(
    'top_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES items (id)',
    ),
  );
  static const VerificationMeta _bottomIdMeta = const VerificationMeta(
    'bottomId',
  );
  @override
  late final GeneratedColumn<int> bottomId = GeneratedColumn<int>(
    'bottom_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES items (id)',
    ),
  );
  static const VerificationMeta _shoesIdMeta = const VerificationMeta(
    'shoesId',
  );
  @override
  late final GeneratedColumn<int> shoesId = GeneratedColumn<int>(
    'shoes_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES items (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    favorite,
    topId,
    bottomId,
    shoesId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'outfits';
  @override
  VerificationContext validateIntegrity(
    Insertable<Outfit> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('favorite')) {
      context.handle(
        _favoriteMeta,
        favorite.isAcceptableOrUnknown(data['favorite']!, _favoriteMeta),
      );
    }
    if (data.containsKey('top_id')) {
      context.handle(
        _topIdMeta,
        topId.isAcceptableOrUnknown(data['top_id']!, _topIdMeta),
      );
    }
    if (data.containsKey('bottom_id')) {
      context.handle(
        _bottomIdMeta,
        bottomId.isAcceptableOrUnknown(data['bottom_id']!, _bottomIdMeta),
      );
    }
    if (data.containsKey('shoes_id')) {
      context.handle(
        _shoesIdMeta,
        shoesId.isAcceptableOrUnknown(data['shoes_id']!, _shoesIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Outfit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Outfit(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      favorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}favorite'],
      )!,
      topId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}top_id'],
      ),
      bottomId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bottom_id'],
      ),
      shoesId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}shoes_id'],
      ),
    );
  }

  @override
  $OutfitsTable createAlias(String alias) {
    return $OutfitsTable(attachedDatabase, alias);
  }
}

class Outfit extends DataClass implements Insertable<Outfit> {
  final int id;
  final DateTime createdAt;
  final bool favorite;
  final int? topId;
  final int? bottomId;
  final int? shoesId;
  const Outfit({
    required this.id,
    required this.createdAt,
    required this.favorite,
    this.topId,
    this.bottomId,
    this.shoesId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['favorite'] = Variable<bool>(favorite);
    if (!nullToAbsent || topId != null) {
      map['top_id'] = Variable<int>(topId);
    }
    if (!nullToAbsent || bottomId != null) {
      map['bottom_id'] = Variable<int>(bottomId);
    }
    if (!nullToAbsent || shoesId != null) {
      map['shoes_id'] = Variable<int>(shoesId);
    }
    return map;
  }

  OutfitsCompanion toCompanion(bool nullToAbsent) {
    return OutfitsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      favorite: Value(favorite),
      topId: topId == null && nullToAbsent
          ? const Value.absent()
          : Value(topId),
      bottomId: bottomId == null && nullToAbsent
          ? const Value.absent()
          : Value(bottomId),
      shoesId: shoesId == null && nullToAbsent
          ? const Value.absent()
          : Value(shoesId),
    );
  }

  factory Outfit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Outfit(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      favorite: serializer.fromJson<bool>(json['favorite']),
      topId: serializer.fromJson<int?>(json['topId']),
      bottomId: serializer.fromJson<int?>(json['bottomId']),
      shoesId: serializer.fromJson<int?>(json['shoesId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'favorite': serializer.toJson<bool>(favorite),
      'topId': serializer.toJson<int?>(topId),
      'bottomId': serializer.toJson<int?>(bottomId),
      'shoesId': serializer.toJson<int?>(shoesId),
    };
  }

  Outfit copyWith({
    int? id,
    DateTime? createdAt,
    bool? favorite,
    Value<int?> topId = const Value.absent(),
    Value<int?> bottomId = const Value.absent(),
    Value<int?> shoesId = const Value.absent(),
  }) => Outfit(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    favorite: favorite ?? this.favorite,
    topId: topId.present ? topId.value : this.topId,
    bottomId: bottomId.present ? bottomId.value : this.bottomId,
    shoesId: shoesId.present ? shoesId.value : this.shoesId,
  );
  Outfit copyWithCompanion(OutfitsCompanion data) {
    return Outfit(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      favorite: data.favorite.present ? data.favorite.value : this.favorite,
      topId: data.topId.present ? data.topId.value : this.topId,
      bottomId: data.bottomId.present ? data.bottomId.value : this.bottomId,
      shoesId: data.shoesId.present ? data.shoesId.value : this.shoesId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Outfit(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('favorite: $favorite, ')
          ..write('topId: $topId, ')
          ..write('bottomId: $bottomId, ')
          ..write('shoesId: $shoesId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, favorite, topId, bottomId, shoesId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Outfit &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.favorite == this.favorite &&
          other.topId == this.topId &&
          other.bottomId == this.bottomId &&
          other.shoesId == this.shoesId);
}

class OutfitsCompanion extends UpdateCompanion<Outfit> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<bool> favorite;
  final Value<int?> topId;
  final Value<int?> bottomId;
  final Value<int?> shoesId;
  const OutfitsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.favorite = const Value.absent(),
    this.topId = const Value.absent(),
    this.bottomId = const Value.absent(),
    this.shoesId = const Value.absent(),
  });
  OutfitsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.favorite = const Value.absent(),
    this.topId = const Value.absent(),
    this.bottomId = const Value.absent(),
    this.shoesId = const Value.absent(),
  });
  static Insertable<Outfit> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<bool>? favorite,
    Expression<int>? topId,
    Expression<int>? bottomId,
    Expression<int>? shoesId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (favorite != null) 'favorite': favorite,
      if (topId != null) 'top_id': topId,
      if (bottomId != null) 'bottom_id': bottomId,
      if (shoesId != null) 'shoes_id': shoesId,
    });
  }

  OutfitsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<bool>? favorite,
    Value<int?>? topId,
    Value<int?>? bottomId,
    Value<int?>? shoesId,
  }) {
    return OutfitsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      favorite: favorite ?? this.favorite,
      topId: topId ?? this.topId,
      bottomId: bottomId ?? this.bottomId,
      shoesId: shoesId ?? this.shoesId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (favorite.present) {
      map['favorite'] = Variable<bool>(favorite.value);
    }
    if (topId.present) {
      map['top_id'] = Variable<int>(topId.value);
    }
    if (bottomId.present) {
      map['bottom_id'] = Variable<int>(bottomId.value);
    }
    if (shoesId.present) {
      map['shoes_id'] = Variable<int>(shoesId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OutfitsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('favorite: $favorite, ')
          ..write('topId: $topId, ')
          ..write('bottomId: $bottomId, ')
          ..write('shoesId: $shoesId')
          ..write(')'))
        .toString();
  }
}

class $OutfitExtrasTable extends OutfitExtras
    with TableInfo<$OutfitExtrasTable, OutfitExtra> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OutfitExtrasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _outfitIdMeta = const VerificationMeta(
    'outfitId',
  );
  @override
  late final GeneratedColumn<int> outfitId = GeneratedColumn<int>(
    'outfit_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES outfits (id)',
    ),
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<int> itemId = GeneratedColumn<int>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES items (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [outfitId, itemId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'outfit_extras';
  @override
  VerificationContext validateIntegrity(
    Insertable<OutfitExtra> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('outfit_id')) {
      context.handle(
        _outfitIdMeta,
        outfitId.isAcceptableOrUnknown(data['outfit_id']!, _outfitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_outfitIdMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {outfitId, itemId};
  @override
  OutfitExtra map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OutfitExtra(
      outfitId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}outfit_id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}item_id'],
      )!,
    );
  }

  @override
  $OutfitExtrasTable createAlias(String alias) {
    return $OutfitExtrasTable(attachedDatabase, alias);
  }
}

class OutfitExtra extends DataClass implements Insertable<OutfitExtra> {
  final int outfitId;
  final int itemId;
  const OutfitExtra({required this.outfitId, required this.itemId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['outfit_id'] = Variable<int>(outfitId);
    map['item_id'] = Variable<int>(itemId);
    return map;
  }

  OutfitExtrasCompanion toCompanion(bool nullToAbsent) {
    return OutfitExtrasCompanion(
      outfitId: Value(outfitId),
      itemId: Value(itemId),
    );
  }

  factory OutfitExtra.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OutfitExtra(
      outfitId: serializer.fromJson<int>(json['outfitId']),
      itemId: serializer.fromJson<int>(json['itemId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'outfitId': serializer.toJson<int>(outfitId),
      'itemId': serializer.toJson<int>(itemId),
    };
  }

  OutfitExtra copyWith({int? outfitId, int? itemId}) => OutfitExtra(
    outfitId: outfitId ?? this.outfitId,
    itemId: itemId ?? this.itemId,
  );
  OutfitExtra copyWithCompanion(OutfitExtrasCompanion data) {
    return OutfitExtra(
      outfitId: data.outfitId.present ? data.outfitId.value : this.outfitId,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OutfitExtra(')
          ..write('outfitId: $outfitId, ')
          ..write('itemId: $itemId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(outfitId, itemId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OutfitExtra &&
          other.outfitId == this.outfitId &&
          other.itemId == this.itemId);
}

class OutfitExtrasCompanion extends UpdateCompanion<OutfitExtra> {
  final Value<int> outfitId;
  final Value<int> itemId;
  final Value<int> rowid;
  const OutfitExtrasCompanion({
    this.outfitId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OutfitExtrasCompanion.insert({
    required int outfitId,
    required int itemId,
    this.rowid = const Value.absent(),
  }) : outfitId = Value(outfitId),
       itemId = Value(itemId);
  static Insertable<OutfitExtra> custom({
    Expression<int>? outfitId,
    Expression<int>? itemId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (outfitId != null) 'outfit_id': outfitId,
      if (itemId != null) 'item_id': itemId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OutfitExtrasCompanion copyWith({
    Value<int>? outfitId,
    Value<int>? itemId,
    Value<int>? rowid,
  }) {
    return OutfitExtrasCompanion(
      outfitId: outfitId ?? this.outfitId,
      itemId: itemId ?? this.itemId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (outfitId.present) {
      map['outfit_id'] = Variable<int>(outfitId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OutfitExtrasCompanion(')
          ..write('outfitId: $outfitId, ')
          ..write('itemId: $itemId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FurnituresTable furnitures = $FurnituresTable(this);
  late final $ZonesTable zones = $ZonesTable(this);
  late final $ItemsTable items = $ItemsTable(this);
  late final $WeatherLogsTable weatherLogs = $WeatherLogsTable(this);
  late final $LogItemsTable logItems = $LogItemsTable(this);
  late final $OutfitsTable outfits = $OutfitsTable(this);
  late final $OutfitExtrasTable outfitExtras = $OutfitExtrasTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    furnitures,
    zones,
    items,
    weatherLogs,
    logItems,
    outfits,
    outfitExtras,
  ];
}

typedef $$FurnituresTableCreateCompanionBuilder = FurnituresCompanion Function({
  Value<int> id,
  required String kind,
  Value<String?> photoPath,
  Value<double> aspect,
});
typedef $$FurnituresTableUpdateCompanionBuilder = FurnituresCompanion Function({
  Value<int> id,
  Value<String> kind,
  Value<String?> photoPath,
  Value<double> aspect,
});

final class $$FurnituresTableReferences
    extends BaseReferences<_$AppDatabase, $FurnituresTable, Furniture> {
  $$FurnituresTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ZonesTable, List<Zone>> _zonesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.zones,
    aliasName: 'furnitures__id__zones__furniture_id',
  );

  $$ZonesTableProcessedTableManager get zonesRefs {
    final manager = $$ZonesTableTableManager(
      $_db,
      $_db.zones,
    ).filter((f) => f.furnitureId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_zonesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FurnituresTableFilterComposer
    extends Composer<_$AppDatabase, $FurnituresTable> {
  $$FurnituresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get aspect => $composableBuilder(
    column: $table.aspect,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> zonesRefs(
    Expression<bool> Function($$ZonesTableFilterComposer f) f,
  ) {
    final $$ZonesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.zones,
      getReferencedColumn: (t) => t.furnitureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ZonesTableFilterComposer(
            $db: $db,
            $table: $db.zones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FurnituresTableOrderingComposer
    extends Composer<_$AppDatabase, $FurnituresTable> {
  $$FurnituresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get aspect => $composableBuilder(
    column: $table.aspect,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FurnituresTableAnnotationComposer
    extends Composer<_$AppDatabase, $FurnituresTable> {
  $$FurnituresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<double> get aspect =>
      $composableBuilder(column: $table.aspect, builder: (column) => column);

  Expression<T> zonesRefs<T extends Object>(
    Expression<T> Function($$ZonesTableAnnotationComposer a) f,
  ) {
    final $$ZonesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.zones,
      getReferencedColumn: (t) => t.furnitureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ZonesTableAnnotationComposer(
            $db: $db,
            $table: $db.zones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FurnituresTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FurnituresTable,
          Furniture,
          $$FurnituresTableFilterComposer,
          $$FurnituresTableOrderingComposer,
          $$FurnituresTableAnnotationComposer,
          $$FurnituresTableCreateCompanionBuilder,
          $$FurnituresTableUpdateCompanionBuilder,
          (Furniture, $$FurnituresTableReferences),
          Furniture,
          PrefetchHooks Function({bool zonesRefs})
        > {
  $$FurnituresTableTableManager(_$AppDatabase db, $FurnituresTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FurnituresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FurnituresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FurnituresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<double> aspect = const Value.absent(),
              }) => FurnituresCompanion(
                id: id,
                kind: kind,
                photoPath: photoPath,
                aspect: aspect,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String kind,
                Value<String?> photoPath = const Value.absent(),
                Value<double> aspect = const Value.absent(),
              }) => FurnituresCompanion.insert(
                id: id,
                kind: kind,
                photoPath: photoPath,
                aspect: aspect,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FurnituresTable, Furniture>(table),
                  $$FurnituresTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({zonesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (zonesRefs) db.zones],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (zonesRefs)
                    await $_getPrefetchedData<
                      Furniture,
                      $FurnituresTable,
                      Zone
                    >(
                      currentTable: table,
                      referencedTable: $$FurnituresTableReferences
                          ._zonesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$FurnituresTableReferences(db, table, p0).zonesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.furnitureId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$FurnituresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FurnituresTable,
      Furniture,
      $$FurnituresTableFilterComposer,
      $$FurnituresTableOrderingComposer,
      $$FurnituresTableAnnotationComposer,
      $$FurnituresTableCreateCompanionBuilder,
      $$FurnituresTableUpdateCompanionBuilder,
      (Furniture, $$FurnituresTableReferences),
      Furniture,
      PrefetchHooks Function({bool zonesRefs})
    >;
typedef $$ZonesTableCreateCompanionBuilder = ZonesCompanion Function({
  Value<int> id,
  required int furnitureId,
  required String title,
  required double x,
  required double y,
  required double w,
  required double h,
});
typedef $$ZonesTableUpdateCompanionBuilder = ZonesCompanion Function({
  Value<int> id,
  Value<int> furnitureId,
  Value<String> title,
  Value<double> x,
  Value<double> y,
  Value<double> w,
  Value<double> h,
});

final class $$ZonesTableReferences
    extends BaseReferences<_$AppDatabase, $ZonesTable, Zone> {
  $$ZonesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FurnituresTable _furnitureIdTable(_$AppDatabase db) =>
      db.furnitures.createAlias('zones__furniture_id__furnitures__id');

  $$FurnituresTableProcessedTableManager get furnitureId {
    final $_column = $_itemColumn<int>('furniture_id')!;

    final manager = $$FurnituresTableTableManager(
      $_db,
      $_db.furnitures,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_furnitureIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ItemsTable, List<Item>> _itemsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.items,
    aliasName: 'zones__id__items__zone_id',
  );

  $$ItemsTableProcessedTableManager get itemsRefs {
    final manager = $$ItemsTableTableManager(
      $_db,
      $_db.items,
    ).filter((f) => f.zoneId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_itemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ZonesTableFilterComposer extends Composer<_$AppDatabase, $ZonesTable> {
  $$ZonesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get x => $composableBuilder(
    column: $table.x,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get y => $composableBuilder(
    column: $table.y,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get w => $composableBuilder(
    column: $table.w,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get h => $composableBuilder(
    column: $table.h,
    builder: (column) => ColumnFilters(column),
  );

  $$FurnituresTableFilterComposer get furnitureId {
    final $$FurnituresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.furnitureId,
      referencedTable: $db.furnitures,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FurnituresTableFilterComposer(
            $db: $db,
            $table: $db.furnitures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> itemsRefs(
    Expression<bool> Function($$ItemsTableFilterComposer f) f,
  ) {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.zoneId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableFilterComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ZonesTableOrderingComposer
    extends Composer<_$AppDatabase, $ZonesTable> {
  $$ZonesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get x => $composableBuilder(
    column: $table.x,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get y => $composableBuilder(
    column: $table.y,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get w => $composableBuilder(
    column: $table.w,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get h => $composableBuilder(
    column: $table.h,
    builder: (column) => ColumnOrderings(column),
  );

  $$FurnituresTableOrderingComposer get furnitureId {
    final $$FurnituresTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.furnitureId,
      referencedTable: $db.furnitures,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FurnituresTableOrderingComposer(
            $db: $db,
            $table: $db.furnitures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ZonesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ZonesTable> {
  $$ZonesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<double> get x =>
      $composableBuilder(column: $table.x, builder: (column) => column);

  GeneratedColumn<double> get y =>
      $composableBuilder(column: $table.y, builder: (column) => column);

  GeneratedColumn<double> get w =>
      $composableBuilder(column: $table.w, builder: (column) => column);

  GeneratedColumn<double> get h =>
      $composableBuilder(column: $table.h, builder: (column) => column);

  $$FurnituresTableAnnotationComposer get furnitureId {
    final $$FurnituresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.furnitureId,
      referencedTable: $db.furnitures,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FurnituresTableAnnotationComposer(
            $db: $db,
            $table: $db.furnitures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> itemsRefs<T extends Object>(
    Expression<T> Function($$ItemsTableAnnotationComposer a) f,
  ) {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.zoneId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ZonesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ZonesTable,
          Zone,
          $$ZonesTableFilterComposer,
          $$ZonesTableOrderingComposer,
          $$ZonesTableAnnotationComposer,
          $$ZonesTableCreateCompanionBuilder,
          $$ZonesTableUpdateCompanionBuilder,
          (Zone, $$ZonesTableReferences),
          Zone,
          PrefetchHooks Function({bool furnitureId, bool itemsRefs})
        > {
  $$ZonesTableTableManager(_$AppDatabase db, $ZonesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ZonesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ZonesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ZonesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> furnitureId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<double> x = const Value.absent(),
                Value<double> y = const Value.absent(),
                Value<double> w = const Value.absent(),
                Value<double> h = const Value.absent(),
              }) => ZonesCompanion(
                id: id,
                furnitureId: furnitureId,
                title: title,
                x: x,
                y: y,
                w: w,
                h: h,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int furnitureId,
                required String title,
                required double x,
                required double y,
                required double w,
                required double h,
              }) => ZonesCompanion.insert(
                id: id,
                furnitureId: furnitureId,
                title: title,
                x: x,
                y: y,
                w: w,
                h: h,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ZonesTable, Zone>(table),
                  $$ZonesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({furnitureId = false, itemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (itemsRefs) db.items],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (furnitureId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.furnitureId,
                        referencedTable: $$ZonesTableReferences
                            ._furnitureIdTable(db),
                        referencedColumn: $$ZonesTableReferences
                            ._furnitureIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (itemsRefs)
                    await $_getPrefetchedData<Zone, $ZonesTable, Item>(
                      currentTable: table,
                      referencedTable: $$ZonesTableReferences._itemsRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$ZonesTableReferences(db, table, p0).itemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.zoneId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ZonesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ZonesTable,
      Zone,
      $$ZonesTableFilterComposer,
      $$ZonesTableOrderingComposer,
      $$ZonesTableAnnotationComposer,
      $$ZonesTableCreateCompanionBuilder,
      $$ZonesTableUpdateCompanionBuilder,
      (Zone, $$ZonesTableReferences),
      Zone,
      PrefetchHooks Function({bool furnitureId, bool itemsRefs})
    >;
typedef $$ItemsTableCreateCompanionBuilder = ItemsCompanion Function({
  Value<int> id,
  required int zoneId,
  required String photoPath,
  Value<String> brand,
  Value<String> size,
  Value<String> notes,
  Value<int> seasons,
  Value<String> category,
});
typedef $$ItemsTableUpdateCompanionBuilder = ItemsCompanion Function({
  Value<int> id,
  Value<int> zoneId,
  Value<String> photoPath,
  Value<String> brand,
  Value<String> size,
  Value<String> notes,
  Value<int> seasons,
  Value<String> category,
});

final class $$ItemsTableReferences
    extends BaseReferences<_$AppDatabase, $ItemsTable, Item> {
  $$ItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ZonesTable _zoneIdTable(_$AppDatabase db) =>
      db.zones.createAlias('items__zone_id__zones__id');

  $$ZonesTableProcessedTableManager get zoneId {
    final $_column = $_itemColumn<int>('zone_id')!;

    final manager = $$ZonesTableTableManager(
      $_db,
      $_db.zones,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_zoneIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$LogItemsTable, List<LogItem>> _logItemsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.logItems,
    aliasName: 'items__id__log_items__item_id',
  );

  $$LogItemsTableProcessedTableManager get logItemsRefs {
    final manager = $$LogItemsTableTableManager(
      $_db,
      $_db.logItems,
    ).filter((f) => f.itemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_logItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$OutfitExtrasTable, List<OutfitExtra>>
  _outfitExtrasRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.outfitExtras,
    aliasName: 'items__id__outfit_extras__item_id',
  );

  $$OutfitExtrasTableProcessedTableManager get outfitExtrasRefs {
    final manager = $$OutfitExtrasTableTableManager(
      $_db,
      $_db.outfitExtras,
    ).filter((f) => f.itemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_outfitExtrasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ItemsTableFilterComposer extends Composer<_$AppDatabase, $ItemsTable> {
  $$ItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get seasons => $composableBuilder(
    column: $table.seasons,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  $$ZonesTableFilterComposer get zoneId {
    final $$ZonesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.zoneId,
      referencedTable: $db.zones,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ZonesTableFilterComposer(
            $db: $db,
            $table: $db.zones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> logItemsRefs(
    Expression<bool> Function($$LogItemsTableFilterComposer f) f,
  ) {
    final $$LogItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.logItems,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LogItemsTableFilterComposer(
            $db: $db,
            $table: $db.logItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> outfitExtrasRefs(
    Expression<bool> Function($$OutfitExtrasTableFilterComposer f) f,
  ) {
    final $$OutfitExtrasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.outfitExtras,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OutfitExtrasTableFilterComposer(
            $db: $db,
            $table: $db.outfitExtras,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ItemsTable> {
  $$ItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get seasons => $composableBuilder(
    column: $table.seasons,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  $$ZonesTableOrderingComposer get zoneId {
    final $$ZonesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.zoneId,
      referencedTable: $db.zones,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ZonesTableOrderingComposer(
            $db: $db,
            $table: $db.zones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItemsTable> {
  $$ItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get size =>
      $composableBuilder(column: $table.size, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get seasons =>
      $composableBuilder(column: $table.seasons, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  $$ZonesTableAnnotationComposer get zoneId {
    final $$ZonesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.zoneId,
      referencedTable: $db.zones,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ZonesTableAnnotationComposer(
            $db: $db,
            $table: $db.zones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> logItemsRefs<T extends Object>(
    Expression<T> Function($$LogItemsTableAnnotationComposer a) f,
  ) {
    final $$LogItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.logItems,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LogItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.logItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> outfitExtrasRefs<T extends Object>(
    Expression<T> Function($$OutfitExtrasTableAnnotationComposer a) f,
  ) {
    final $$OutfitExtrasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.outfitExtras,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OutfitExtrasTableAnnotationComposer(
            $db: $db,
            $table: $db.outfitExtras,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ItemsTable,
          Item,
          $$ItemsTableFilterComposer,
          $$ItemsTableOrderingComposer,
          $$ItemsTableAnnotationComposer,
          $$ItemsTableCreateCompanionBuilder,
          $$ItemsTableUpdateCompanionBuilder,
          (Item, $$ItemsTableReferences),
          Item,
          PrefetchHooks Function({
            bool zoneId,
            bool logItemsRefs,
            bool outfitExtrasRefs,
          })
        > {
  $$ItemsTableTableManager(_$AppDatabase db, $ItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> zoneId = const Value.absent(),
                Value<String> photoPath = const Value.absent(),
                Value<String> brand = const Value.absent(),
                Value<String> size = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<int> seasons = const Value.absent(),
                Value<String> category = const Value.absent(),
              }) => ItemsCompanion(
                id: id,
                zoneId: zoneId,
                photoPath: photoPath,
                brand: brand,
                size: size,
                notes: notes,
                seasons: seasons,
                category: category,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int zoneId,
                required String photoPath,
                Value<String> brand = const Value.absent(),
                Value<String> size = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<int> seasons = const Value.absent(),
                Value<String> category = const Value.absent(),
              }) => ItemsCompanion.insert(
                id: id,
                zoneId: zoneId,
                photoPath: photoPath,
                brand: brand,
                size: size,
                notes: notes,
                seasons: seasons,
                category: category,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ItemsTable, Item>(table),
                  $$ItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                zoneId = false,
                logItemsRefs = false,
                outfitExtrasRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (logItemsRefs) db.logItems,
                    if (outfitExtrasRefs) db.outfitExtras,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (zoneId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.zoneId,
                            referencedTable: $$ItemsTableReferences
                                ._zoneIdTable(db),
                            referencedColumn: $$ItemsTableReferences
                                ._zoneIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (logItemsRefs)
                        await $_getPrefetchedData<Item, $ItemsTable, LogItem>(
                          currentTable: table,
                          referencedTable: $$ItemsTableReferences
                              ._logItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).logItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.itemId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (outfitExtrasRefs)
                        await $_getPrefetchedData<
                          Item,
                          $ItemsTable,
                          OutfitExtra
                        >(
                          currentTable: table,
                          referencedTable: $$ItemsTableReferences
                              ._outfitExtrasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).outfitExtrasRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.itemId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ItemsTable,
      Item,
      $$ItemsTableFilterComposer,
      $$ItemsTableOrderingComposer,
      $$ItemsTableAnnotationComposer,
      $$ItemsTableCreateCompanionBuilder,
      $$ItemsTableUpdateCompanionBuilder,
      (Item, $$ItemsTableReferences),
      Item,
      PrefetchHooks Function({
        bool zoneId,
        bool logItemsRefs,
        bool outfitExtrasRefs,
      })
    >;
typedef $$WeatherLogsTableCreateCompanionBuilder =
    WeatherLogsCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      required int temp,
      required String outfit,
      Value<int> feeling,
      Value<String> comment,
    });
typedef $$WeatherLogsTableUpdateCompanionBuilder =
    WeatherLogsCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<int> temp,
      Value<String> outfit,
      Value<int> feeling,
      Value<String> comment,
    });

final class $$WeatherLogsTableReferences
    extends BaseReferences<_$AppDatabase, $WeatherLogsTable, WeatherLog> {
  $$WeatherLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$LogItemsTable, List<LogItem>> _logItemsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.logItems,
    aliasName: 'weather_logs__id__log_items__log_id',
  );

  $$LogItemsTableProcessedTableManager get logItemsRefs {
    final manager = $$LogItemsTableTableManager(
      $_db,
      $_db.logItems,
    ).filter((f) => f.logId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_logItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WeatherLogsTableFilterComposer
    extends Composer<_$AppDatabase, $WeatherLogsTable> {
  $$WeatherLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get temp => $composableBuilder(
    column: $table.temp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get outfit => $composableBuilder(
    column: $table.outfit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get feeling => $composableBuilder(
    column: $table.feeling,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> logItemsRefs(
    Expression<bool> Function($$LogItemsTableFilterComposer f) f,
  ) {
    final $$LogItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.logItems,
      getReferencedColumn: (t) => t.logId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LogItemsTableFilterComposer(
            $db: $db,
            $table: $db.logItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WeatherLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $WeatherLogsTable> {
  $$WeatherLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get temp => $composableBuilder(
    column: $table.temp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get outfit => $composableBuilder(
    column: $table.outfit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get feeling => $composableBuilder(
    column: $table.feeling,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WeatherLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeatherLogsTable> {
  $$WeatherLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get temp =>
      $composableBuilder(column: $table.temp, builder: (column) => column);

  GeneratedColumn<String> get outfit =>
      $composableBuilder(column: $table.outfit, builder: (column) => column);

  GeneratedColumn<int> get feeling =>
      $composableBuilder(column: $table.feeling, builder: (column) => column);

  GeneratedColumn<String> get comment =>
      $composableBuilder(column: $table.comment, builder: (column) => column);

  Expression<T> logItemsRefs<T extends Object>(
    Expression<T> Function($$LogItemsTableAnnotationComposer a) f,
  ) {
    final $$LogItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.logItems,
      getReferencedColumn: (t) => t.logId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LogItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.logItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WeatherLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeatherLogsTable,
          WeatherLog,
          $$WeatherLogsTableFilterComposer,
          $$WeatherLogsTableOrderingComposer,
          $$WeatherLogsTableAnnotationComposer,
          $$WeatherLogsTableCreateCompanionBuilder,
          $$WeatherLogsTableUpdateCompanionBuilder,
          (WeatherLog, $$WeatherLogsTableReferences),
          WeatherLog,
          PrefetchHooks Function({bool logItemsRefs})
        > {
  $$WeatherLogsTableTableManager(_$AppDatabase db, $WeatherLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeatherLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeatherLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeatherLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> temp = const Value.absent(),
                Value<String> outfit = const Value.absent(),
                Value<int> feeling = const Value.absent(),
                Value<String> comment = const Value.absent(),
              }) => WeatherLogsCompanion(
                id: id,
                createdAt: createdAt,
                temp: temp,
                outfit: outfit,
                feeling: feeling,
                comment: comment,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                required int temp,
                required String outfit,
                Value<int> feeling = const Value.absent(),
                Value<String> comment = const Value.absent(),
              }) => WeatherLogsCompanion.insert(
                id: id,
                createdAt: createdAt,
                temp: temp,
                outfit: outfit,
                feeling: feeling,
                comment: comment,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WeatherLogsTable, WeatherLog>(table),
                  $$WeatherLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({logItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (logItemsRefs) db.logItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (logItemsRefs)
                    await $_getPrefetchedData<
                      WeatherLog,
                      $WeatherLogsTable,
                      LogItem
                    >(
                      currentTable: table,
                      referencedTable: $$WeatherLogsTableReferences
                          ._logItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$WeatherLogsTableReferences(
                            db,
                            table,
                            p0,
                          ).logItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.logId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$WeatherLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeatherLogsTable,
      WeatherLog,
      $$WeatherLogsTableFilterComposer,
      $$WeatherLogsTableOrderingComposer,
      $$WeatherLogsTableAnnotationComposer,
      $$WeatherLogsTableCreateCompanionBuilder,
      $$WeatherLogsTableUpdateCompanionBuilder,
      (WeatherLog, $$WeatherLogsTableReferences),
      WeatherLog,
      PrefetchHooks Function({bool logItemsRefs})
    >;
typedef $$LogItemsTableCreateCompanionBuilder = LogItemsCompanion Function({
  required int logId,
  required int itemId,
  Value<int> rowid,
});
typedef $$LogItemsTableUpdateCompanionBuilder = LogItemsCompanion Function({
  Value<int> logId,
  Value<int> itemId,
  Value<int> rowid,
});

final class $$LogItemsTableReferences
    extends BaseReferences<_$AppDatabase, $LogItemsTable, LogItem> {
  $$LogItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WeatherLogsTable _logIdTable(_$AppDatabase db) =>
      db.weatherLogs.createAlias('log_items__log_id__weather_logs__id');

  $$WeatherLogsTableProcessedTableManager get logId {
    final $_column = $_itemColumn<int>('log_id')!;

    final manager = $$WeatherLogsTableTableManager(
      $_db,
      $_db.weatherLogs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_logIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ItemsTable _itemIdTable(_$AppDatabase db) =>
      db.items.createAlias('log_items__item_id__items__id');

  $$ItemsTableProcessedTableManager get itemId {
    final $_column = $_itemColumn<int>('item_id')!;

    final manager = $$ItemsTableTableManager(
      $_db,
      $_db.items,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LogItemsTableFilterComposer
    extends Composer<_$AppDatabase, $LogItemsTable> {
  $$LogItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$WeatherLogsTableFilterComposer get logId {
    final $$WeatherLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.logId,
      referencedTable: $db.weatherLogs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherLogsTableFilterComposer(
            $db: $db,
            $table: $db.weatherLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemsTableFilterComposer get itemId {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableFilterComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LogItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $LogItemsTable> {
  $$LogItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$WeatherLogsTableOrderingComposer get logId {
    final $$WeatherLogsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.logId,
      referencedTable: $db.weatherLogs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherLogsTableOrderingComposer(
            $db: $db,
            $table: $db.weatherLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemsTableOrderingComposer get itemId {
    final $$ItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableOrderingComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LogItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LogItemsTable> {
  $$LogItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$WeatherLogsTableAnnotationComposer get logId {
    final $$WeatherLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.logId,
      referencedTable: $db.weatherLogs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.weatherLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemsTableAnnotationComposer get itemId {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LogItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LogItemsTable,
          LogItem,
          $$LogItemsTableFilterComposer,
          $$LogItemsTableOrderingComposer,
          $$LogItemsTableAnnotationComposer,
          $$LogItemsTableCreateCompanionBuilder,
          $$LogItemsTableUpdateCompanionBuilder,
          (LogItem, $$LogItemsTableReferences),
          LogItem,
          PrefetchHooks Function({bool logId, bool itemId})
        > {
  $$LogItemsTableTableManager(_$AppDatabase db, $LogItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LogItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LogItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LogItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> logId = const Value.absent(),
            Value<int> itemId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => LogItemsCompanion(logId: logId, itemId: itemId, rowid: rowid),
          createCompanionCallback:
              ({
                required int logId,
                required int itemId,
                Value<int> rowid = const Value.absent(),
              }) => LogItemsCompanion.insert(
                logId: logId,
                itemId: itemId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LogItemsTable, LogItem>(table),
                  $$LogItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({logId = false, itemId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (logId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.logId,
                        referencedTable: $$LogItemsTableReferences._logIdTable(
                          db,
                        ),
                        referencedColumn: $$LogItemsTableReferences
                            ._logIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (itemId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.itemId,
                        referencedTable: $$LogItemsTableReferences._itemIdTable(
                          db,
                        ),
                        referencedColumn: $$LogItemsTableReferences
                            ._itemIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LogItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LogItemsTable,
      LogItem,
      $$LogItemsTableFilterComposer,
      $$LogItemsTableOrderingComposer,
      $$LogItemsTableAnnotationComposer,
      $$LogItemsTableCreateCompanionBuilder,
      $$LogItemsTableUpdateCompanionBuilder,
      (LogItem, $$LogItemsTableReferences),
      LogItem,
      PrefetchHooks Function({bool logId, bool itemId})
    >;
typedef $$OutfitsTableCreateCompanionBuilder = OutfitsCompanion Function({
  Value<int> id,
  Value<DateTime> createdAt,
  Value<bool> favorite,
  Value<int?> topId,
  Value<int?> bottomId,
  Value<int?> shoesId,
});
typedef $$OutfitsTableUpdateCompanionBuilder = OutfitsCompanion Function({
  Value<int> id,
  Value<DateTime> createdAt,
  Value<bool> favorite,
  Value<int?> topId,
  Value<int?> bottomId,
  Value<int?> shoesId,
});

final class $$OutfitsTableReferences
    extends BaseReferences<_$AppDatabase, $OutfitsTable, Outfit> {
  $$OutfitsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ItemsTable _topIdTable(_$AppDatabase db) =>
      db.items.createAlias('outfits__top_id__items__id');

  $$ItemsTableProcessedTableManager? get topId {
    final $_column = $_itemColumn<int>('top_id');
    if ($_column == null) return null;
    final manager = $$ItemsTableTableManager(
      $_db,
      $_db.items,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_topIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ItemsTable _bottomIdTable(_$AppDatabase db) =>
      db.items.createAlias('outfits__bottom_id__items__id');

  $$ItemsTableProcessedTableManager? get bottomId {
    final $_column = $_itemColumn<int>('bottom_id');
    if ($_column == null) return null;
    final manager = $$ItemsTableTableManager(
      $_db,
      $_db.items,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bottomIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ItemsTable _shoesIdTable(_$AppDatabase db) =>
      db.items.createAlias('outfits__shoes_id__items__id');

  $$ItemsTableProcessedTableManager? get shoesId {
    final $_column = $_itemColumn<int>('shoes_id');
    if ($_column == null) return null;
    final manager = $$ItemsTableTableManager(
      $_db,
      $_db.items,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_shoesIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$OutfitExtrasTable, List<OutfitExtra>>
  _outfitExtrasRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.outfitExtras,
    aliasName: 'outfits__id__outfit_extras__outfit_id',
  );

  $$OutfitExtrasTableProcessedTableManager get outfitExtrasRefs {
    final manager = $$OutfitExtrasTableTableManager(
      $_db,
      $_db.outfitExtras,
    ).filter((f) => f.outfitId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_outfitExtrasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$OutfitsTableFilterComposer
    extends Composer<_$AppDatabase, $OutfitsTable> {
  $$OutfitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get favorite => $composableBuilder(
    column: $table.favorite,
    builder: (column) => ColumnFilters(column),
  );

  $$ItemsTableFilterComposer get topId {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableFilterComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemsTableFilterComposer get bottomId {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bottomId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableFilterComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemsTableFilterComposer get shoesId {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shoesId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableFilterComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> outfitExtrasRefs(
    Expression<bool> Function($$OutfitExtrasTableFilterComposer f) f,
  ) {
    final $$OutfitExtrasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.outfitExtras,
      getReferencedColumn: (t) => t.outfitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OutfitExtrasTableFilterComposer(
            $db: $db,
            $table: $db.outfitExtras,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$OutfitsTableOrderingComposer
    extends Composer<_$AppDatabase, $OutfitsTable> {
  $$OutfitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get favorite => $composableBuilder(
    column: $table.favorite,
    builder: (column) => ColumnOrderings(column),
  );

  $$ItemsTableOrderingComposer get topId {
    final $$ItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableOrderingComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemsTableOrderingComposer get bottomId {
    final $$ItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bottomId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableOrderingComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemsTableOrderingComposer get shoesId {
    final $$ItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shoesId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableOrderingComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OutfitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OutfitsTable> {
  $$OutfitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get favorite =>
      $composableBuilder(column: $table.favorite, builder: (column) => column);

  $$ItemsTableAnnotationComposer get topId {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemsTableAnnotationComposer get bottomId {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bottomId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemsTableAnnotationComposer get shoesId {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shoesId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> outfitExtrasRefs<T extends Object>(
    Expression<T> Function($$OutfitExtrasTableAnnotationComposer a) f,
  ) {
    final $$OutfitExtrasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.outfitExtras,
      getReferencedColumn: (t) => t.outfitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OutfitExtrasTableAnnotationComposer(
            $db: $db,
            $table: $db.outfitExtras,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$OutfitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OutfitsTable,
          Outfit,
          $$OutfitsTableFilterComposer,
          $$OutfitsTableOrderingComposer,
          $$OutfitsTableAnnotationComposer,
          $$OutfitsTableCreateCompanionBuilder,
          $$OutfitsTableUpdateCompanionBuilder,
          (Outfit, $$OutfitsTableReferences),
          Outfit,
          PrefetchHooks Function({
            bool topId,
            bool bottomId,
            bool shoesId,
            bool outfitExtrasRefs,
          })
        > {
  $$OutfitsTableTableManager(_$AppDatabase db, $OutfitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OutfitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OutfitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OutfitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> favorite = const Value.absent(),
                Value<int?> topId = const Value.absent(),
                Value<int?> bottomId = const Value.absent(),
                Value<int?> shoesId = const Value.absent(),
              }) => OutfitsCompanion(
                id: id,
                createdAt: createdAt,
                favorite: favorite,
                topId: topId,
                bottomId: bottomId,
                shoesId: shoesId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> favorite = const Value.absent(),
                Value<int?> topId = const Value.absent(),
                Value<int?> bottomId = const Value.absent(),
                Value<int?> shoesId = const Value.absent(),
              }) => OutfitsCompanion.insert(
                id: id,
                createdAt: createdAt,
                favorite: favorite,
                topId: topId,
                bottomId: bottomId,
                shoesId: shoesId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$OutfitsTable, Outfit>(table),
                  $$OutfitsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                topId = false,
                bottomId = false,
                shoesId = false,
                outfitExtrasRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (outfitExtrasRefs) db.outfitExtras,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (topId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.topId,
                            referencedTable: $$OutfitsTableReferences
                                ._topIdTable(db),
                            referencedColumn: $$OutfitsTableReferences
                                ._topIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (bottomId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.bottomId,
                            referencedTable: $$OutfitsTableReferences
                                ._bottomIdTable(db),
                            referencedColumn: $$OutfitsTableReferences
                                ._bottomIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (shoesId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.shoesId,
                            referencedTable: $$OutfitsTableReferences
                                ._shoesIdTable(db),
                            referencedColumn: $$OutfitsTableReferences
                                ._shoesIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (outfitExtrasRefs)
                        await $_getPrefetchedData<
                          Outfit,
                          $OutfitsTable,
                          OutfitExtra
                        >(
                          currentTable: table,
                          referencedTable: $$OutfitsTableReferences
                              ._outfitExtrasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OutfitsTableReferences(
                                db,
                                table,
                                p0,
                              ).outfitExtrasRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.outfitId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$OutfitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OutfitsTable,
      Outfit,
      $$OutfitsTableFilterComposer,
      $$OutfitsTableOrderingComposer,
      $$OutfitsTableAnnotationComposer,
      $$OutfitsTableCreateCompanionBuilder,
      $$OutfitsTableUpdateCompanionBuilder,
      (Outfit, $$OutfitsTableReferences),
      Outfit,
      PrefetchHooks Function({
        bool topId,
        bool bottomId,
        bool shoesId,
        bool outfitExtrasRefs,
      })
    >;
typedef $$OutfitExtrasTableCreateCompanionBuilder =
    OutfitExtrasCompanion Function({
      required int outfitId,
      required int itemId,
      Value<int> rowid,
    });
typedef $$OutfitExtrasTableUpdateCompanionBuilder =
    OutfitExtrasCompanion Function({
      Value<int> outfitId,
      Value<int> itemId,
      Value<int> rowid,
    });

final class $$OutfitExtrasTableReferences
    extends BaseReferences<_$AppDatabase, $OutfitExtrasTable, OutfitExtra> {
  $$OutfitExtrasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OutfitsTable _outfitIdTable(_$AppDatabase db) =>
      db.outfits.createAlias('outfit_extras__outfit_id__outfits__id');

  $$OutfitsTableProcessedTableManager get outfitId {
    final $_column = $_itemColumn<int>('outfit_id')!;

    final manager = $$OutfitsTableTableManager(
      $_db,
      $_db.outfits,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_outfitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ItemsTable _itemIdTable(_$AppDatabase db) =>
      db.items.createAlias('outfit_extras__item_id__items__id');

  $$ItemsTableProcessedTableManager get itemId {
    final $_column = $_itemColumn<int>('item_id')!;

    final manager = $$ItemsTableTableManager(
      $_db,
      $_db.items,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$OutfitExtrasTableFilterComposer
    extends Composer<_$AppDatabase, $OutfitExtrasTable> {
  $$OutfitExtrasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$OutfitsTableFilterComposer get outfitId {
    final $$OutfitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.outfitId,
      referencedTable: $db.outfits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OutfitsTableFilterComposer(
            $db: $db,
            $table: $db.outfits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemsTableFilterComposer get itemId {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableFilterComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OutfitExtrasTableOrderingComposer
    extends Composer<_$AppDatabase, $OutfitExtrasTable> {
  $$OutfitExtrasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$OutfitsTableOrderingComposer get outfitId {
    final $$OutfitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.outfitId,
      referencedTable: $db.outfits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OutfitsTableOrderingComposer(
            $db: $db,
            $table: $db.outfits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemsTableOrderingComposer get itemId {
    final $$ItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableOrderingComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OutfitExtrasTableAnnotationComposer
    extends Composer<_$AppDatabase, $OutfitExtrasTable> {
  $$OutfitExtrasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$OutfitsTableAnnotationComposer get outfitId {
    final $$OutfitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.outfitId,
      referencedTable: $db.outfits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OutfitsTableAnnotationComposer(
            $db: $db,
            $table: $db.outfits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemsTableAnnotationComposer get itemId {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OutfitExtrasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OutfitExtrasTable,
          OutfitExtra,
          $$OutfitExtrasTableFilterComposer,
          $$OutfitExtrasTableOrderingComposer,
          $$OutfitExtrasTableAnnotationComposer,
          $$OutfitExtrasTableCreateCompanionBuilder,
          $$OutfitExtrasTableUpdateCompanionBuilder,
          (OutfitExtra, $$OutfitExtrasTableReferences),
          OutfitExtra,
          PrefetchHooks Function({bool outfitId, bool itemId})
        > {
  $$OutfitExtrasTableTableManager(_$AppDatabase db, $OutfitExtrasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OutfitExtrasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OutfitExtrasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OutfitExtrasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> outfitId = const Value.absent(),
                Value<int> itemId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OutfitExtrasCompanion(
                outfitId: outfitId,
                itemId: itemId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int outfitId,
                required int itemId,
                Value<int> rowid = const Value.absent(),
              }) => OutfitExtrasCompanion.insert(
                outfitId: outfitId,
                itemId: itemId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$OutfitExtrasTable, OutfitExtra>(table),
                  $$OutfitExtrasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({outfitId = false, itemId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (outfitId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.outfitId,
                        referencedTable: $$OutfitExtrasTableReferences
                            ._outfitIdTable(db),
                        referencedColumn: $$OutfitExtrasTableReferences
                            ._outfitIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (itemId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.itemId,
                        referencedTable: $$OutfitExtrasTableReferences
                            ._itemIdTable(db),
                        referencedColumn: $$OutfitExtrasTableReferences
                            ._itemIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$OutfitExtrasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OutfitExtrasTable,
      OutfitExtra,
      $$OutfitExtrasTableFilterComposer,
      $$OutfitExtrasTableOrderingComposer,
      $$OutfitExtrasTableAnnotationComposer,
      $$OutfitExtrasTableCreateCompanionBuilder,
      $$OutfitExtrasTableUpdateCompanionBuilder,
      (OutfitExtra, $$OutfitExtrasTableReferences),
      OutfitExtra,
      PrefetchHooks Function({bool outfitId, bool itemId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FurnituresTableTableManager get furnitures =>
      $$FurnituresTableTableManager(_db, _db.furnitures);
  $$ZonesTableTableManager get zones =>
      $$ZonesTableTableManager(_db, _db.zones);
  $$ItemsTableTableManager get items =>
      $$ItemsTableTableManager(_db, _db.items);
  $$WeatherLogsTableTableManager get weatherLogs =>
      $$WeatherLogsTableTableManager(_db, _db.weatherLogs);
  $$LogItemsTableTableManager get logItems =>
      $$LogItemsTableTableManager(_db, _db.logItems);
  $$OutfitsTableTableManager get outfits =>
      $$OutfitsTableTableManager(_db, _db.outfits);
  $$OutfitExtrasTableTableManager get outfitExtras =>
      $$OutfitExtrasTableTableManager(_db, _db.outfitExtras);
}
