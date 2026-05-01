import 'package:flutter/material.dart';
import '../models/pantry.dart';
import '../models/product.dart';
import 'pantry_details_screen.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Lista de despensas base para la maqueta
    final List<Pantry> despensas = [
      Pantry(id: '1', name: 'Despensa Cocina'),
      Pantry(id: '2', name: 'Despensa Congelador'),
      Pantry(id: '3', name: 'Despensa MiniBar'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Despensas'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: despensas.length,
        separatorBuilder: (context, index) => const Divider(height: 1), 
        itemBuilder: (context, index) {
          final pantry = despensas[index];

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            leading: Icon(
              Icons.inventory_2_outlined, 
              color: theme.colorScheme.primary,
            ),
            title: Text(
              pantry.name,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              final pantryConDatos = Pantry(
                id: pantry.id,
                name: pantry.name,
                products: [
                  Product(id: '1', name: 'Arroz', price: 1500, priority: PriorityLevel.high),
                  Product(id: '2', name: 'Aceite', price: 3000, priority: PriorityLevel.high),
                  Product(id: '3', name: 'Fideos', price: 900, priority: PriorityLevel.medium),
                  Product(id: '4', name: 'Galletas', price: 1200, priority: PriorityLevel.low),
                ],
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PantryDetailsScreen(pantry: pantryConDatos),
                ),
              );
            }, 
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        elevation: 0, 
        backgroundColor: theme.colorScheme.primaryContainer,
        child: Icon(Icons.add, color: theme.colorScheme.onPrimaryContainer),
      ),
    );
  }
}