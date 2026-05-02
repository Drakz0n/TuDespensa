import 'product.dart';

class ProductRegistry {
  // Lista Global de productos guardados (simula una base de datos)
  static List<Product> savedProducts = [
    Product(id: '1', name: 'Aceite', price: 3000, priority: PriorityLevel.high, ImagePath: 'assets/images/Aceite.png'),
    Product(id: '2', name: 'Arroz', price: 1500, priority: PriorityLevel.high, ImagePath: 'assets/images/Arroz.png'),
    Product(id: '3', name: 'Fideos', price: 900, priority: PriorityLevel.medium, ImagePath: 'assets/images/Fideos.png'),
    Product(id: '4', name: 'Carne Molida', price: 4500, priority: PriorityLevel.high, ImagePath: 'assets/images/CarneMolidaCongelada.png'),
    Product(id: '5', name: 'Papas Duquesas', price: 3800, priority: PriorityLevel.medium, ImagePath: 'assets/images/PapasDuquesasCongeladas.png'),
    Product(id: '6', name: 'Lemon Stone', price: 1200, priority: PriorityLevel.low, ImagePath: 'assets/images/LemonStone.png'),
    Product(id: '7', name: 'Galletas', price: 800, priority: PriorityLevel.low, ImagePath: 'assets/images/Galletas.png'),
  ];
}