class Store {
  final int? id;
  final String name;
  final String category;
  final String description;
  final String? imagePath;

  Store({
    this.id,
    required this.name,
    required this.category,
    required this.description,
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'imagePath': imagePath,
    };
  }

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
      id: map['id'] as int?,
      name: map['name'] as String,
      category: map['category'] as String,
      description: map['description'] as String,
      imagePath: map['imagePath'] as String?,
    );
  }

  Store copyWith({
    int? id,
    String? name,
    String? category,
    String? description,
    String? imagePath,
  }) {
    return Store(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
