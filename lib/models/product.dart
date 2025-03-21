class Product {
  final int? id;
  final String name;
  final String description;
  final double price;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'description': description, 'price': price};
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int?,
      name: map['name'] as String,
      description: map['description'] as String,
      price: (map['price'] as num).toDouble(),
    );
  }

  Product copyWith({
    int? id,
    String? name,
    String? description,
    double? price,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
    );
  }
}
