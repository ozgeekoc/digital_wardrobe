/// Mobilya türüne göre kıyafet kategorileri
const categoryOptions = {
  'wardrobe': [
    'Askılı',
    'Kısa kollu',
    'Uzun kollu',
    'Sweatshirt',
    'Kazak',
    'Kot pantolon',
    'Diğer pantolon',
    'Elbise',
    'Etek',
  ],
  'dresser': ['Pijama'],
  'rack': ['Ayakkabı', 'Bot', 'Ceket/Mont'],
};

/// Kombindeki ana kutulara hangi kategoriler girebilir
const slotCategories = {
  'top': ['Askılı', 'Kısa kollu', 'Uzun kollu', 'Sweatshirt', 'Kazak', 'Elbise'],
  'bottom': ['Kot pantolon', 'Diğer pantolon', 'Etek'],
  'shoes': ['Ayakkabı', 'Bot'],
};

/// Seçim ekranının ayarları. null = normal (seçimsiz) mod.
class PickConfig {
  final bool single; // true: tek dokunuşla seç ve dön
  final Set<String>? categories; // null: hepsi
  final String title;
  const PickConfig({
    this.single = false,
    this.categories,
    this.title = 'Giydiklerini seç',
  });
}