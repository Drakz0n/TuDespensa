import 'product.dart';

class Pantry {
  final String id;
  final String name;
  final List<Product> products;

  Pantry({
    required this.id,
    required this.name,
    this.products = const [],
  });
}