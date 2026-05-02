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
  final String? imagePath;
  int quantity; // Cantidad del producto en la despensa

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.priority,
    this.imagePath,
    this.quantity = 1,
  });
}