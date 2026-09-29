import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Galeriden fotoğraf seçer, uygulama klasörüne kopyalar, yolunu döner.
Future<String?> pickAndSavePhoto(String prefix) async {
  final picked = await ImagePicker()
      .pickImage(source: ImageSource.gallery, maxWidth: 1600, imageQuality: 85);
  if (picked == null) return null;
  final dir = await getApplicationDocumentsDirectory();
  final dest = p.join(
      dir.path, '${prefix}_${DateTime.now().millisecondsSinceEpoch}.jpg');
  await File(picked.path).copy(dest);
  return dest;
}