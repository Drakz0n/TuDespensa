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

  // Getters para cantidades por prioridad
  int get lowCount => lowPriorityProducts.length; // Cantidad de productos de prioridad
  int get mediumCount => mediumPriorityProducts.length; // Cantidad de productos de prioridad
  int get highCount => highPriorityProducts.length; // Cantidad de productos de prioridad

  // Calculo del precio total
  double get totalPrice => products.fold(0, (sum, p) => sum + p.price); // Precio total de los productos

  // Calculo del precio por prioridad
  double get lowPrice => lowPriorityProducts.fold(0, (sum, p) => sum + p.price); // Precio total de productos de prioridad
  double get mediumPrice => mediumPriorityProducts.fold(0, (sum, p) => sum + p.price); // Precio total de productos de prioridad
  double get highPrice => highPriorityProducts.fold(0, (sum, p) => sum + p.price); // Precio total de productos de prioridad
  
}