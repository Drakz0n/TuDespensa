enum PriorityLevel {
  low,
  medium,
  high,
}

class Product {
  final String id;
  final String name;
  final double price;
  final PriorityLevel priority;
  final String? ImagePath;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.priority,
    this.ImagePath,
  });
}