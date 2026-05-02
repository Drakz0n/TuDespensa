import 'dart:ui'; // para usar el blur en los detalles importantes
import 'package:flutter/material.dart';
import '../models/pantry.dart';
import '../models/product.dart';
import 'pantry_details_screen.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Lista de despensas con datos de prueba para la maqueta
    final List<Pantry> despensas = [
      Pantry(
        id: '1', 
        name: 'Despensa Cocina',
        products: [
          Product(id: '1', name: 'Aceite', price: 3000, priority: PriorityLevel.high, imagePath: 'assets/images/Aceite.png'),
          Product(id: '2', name: 'Arroz', price: 1500, priority: PriorityLevel.high, imagePath: 'assets/images/Arroz.png'),
          Product(id: '3', name: 'Fideos', price: 900, priority: PriorityLevel.medium, imagePath: 'assets/images/Fideos.png'),
        ]
      ),
      Pantry(
        id: '2', 
        name: 'Despensa Congelador',
        products: [
          Product(id: '4', name: 'Carne Molida', price: 4500, priority: PriorityLevel.high, imagePath: 'assets/images/CarneMolidaCongelada.png'),
          Product(id: '5', name: 'Papas Duquesas', price: 3800, priority: PriorityLevel.medium, imagePath: 'assets/images/PapasDuquesasCongeladas.png'),
        ]
      ),
      Pantry(
        id: '3', 
        name: 'Despensa MiniBar',
        products: [
          Product(id: '6', name: 'Lemon Stone', price: 1200, priority: PriorityLevel.low, imagePath: 'assets/images/LemonStone.png'),
          Product(id: '7', name: 'Galletas', price: 800, priority: PriorityLevel.low, imagePath: 'assets/images/Galletas.png'),
        ]
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Despensas'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: despensas.length,
        separatorBuilder: (context, index) => const Divider(), 
        itemBuilder: (context, index) {
          return PantryTile(pantry: despensas[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPantryDialog(context),
        backgroundColor: theme.colorScheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showAddPantryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nueva Despensa'),
        content: const TextField(
          decoration: InputDecoration(hintText: 'Nombre (ej. Bodega)'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text('Crear'),
          ),
        ],
      ),
    );
  }
}

class PantryTile extends StatefulWidget {
  final Pantry pantry;
  const PantryTile({super.key, required this.pantry});

  @override
  State<PantryTile> createState() => _PantryTileState();
}

class _PantryTileState extends State<PantryTile> {
  bool _showPrice = false; // Controla si se ve el precio o el blur

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      leading: Icon(
        Icons.inventory_2_outlined, 
        color: theme.colorScheme.primary,
        size: 28,
      ),
      title: Text(
        widget.pantry.name, 
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        'Alta: ${widget.pantry.highCount} | Media: ${widget.pantry.mediumCount} | Baja: ${widget.pantry.lowCount}\nTotal: ${widget.pantry.products.length} productos',
        style: theme.textTheme.bodySmall,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Precio con efecto desenfocado
          _showPrice 
            ? Text(
                '\$${widget.pantry.totalPrice.toInt()}', 
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            : ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: const Text('\$99999'), 
              ),
          const SizedBox(width: 4),
          // Botón del ojito para revelar el precio
          IconButton(
            icon: Icon(
              _showPrice ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              size: 20,
              color: theme.colorScheme.primary,
            ),
            onPressed: () {
              setState(() {
                _showPrice = !_showPrice;
              });
            },
          ),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PantryDetailsScreen(pantry: widget.pantry),
          ),
        );
      },
    );
  }
}