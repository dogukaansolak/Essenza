class Perfume {
  final String name;
  final String brand;
  final String image;
  final double price;
  final String category;
  final String description;

  Perfume({
    required this.name,
    required this.brand,
    required this.image,
    required this.price,
    required this.category,
    required this.description,
  });

  factory Perfume.fromJson(Map<String, dynamic> json) {
    return Perfume(
      name: json['name'],
      brand: json['brand'],
      image: json['image'],
      price: (json['price'] as num).toDouble(),
      category: json['category'],
      description: json['description'],
    );
  }
}