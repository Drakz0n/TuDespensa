import 'product.dart';

class Pantry {
  final String id;
  final String name;
  //Lista de productos
  final List<Product> products;

  Pantry({
    required this.id,
    required this.name,
    this.products = const [],
  });

  // Getters para obtener las listas de productos por prioridad
  List<Product> get lowPriorityProducts => // Prioridad baja
      products.where((p) => p.priority == PriorityLevel.low).toList();  

  List<Product> get mediumPriorityProducts => // Prioridad media
      products.where((p) => p.priority == PriorityLevel.medium).toList();

  List<Product> get highPriorityProducts => // Prioridad alta
      products.where((p) => p.priority == PriorityLevel.high).toList();
}