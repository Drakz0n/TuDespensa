import 'package:flutter/material.dart';
import '../models/pantry.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); 
    
    final List<Pantry> despensas = [
      Pantry(id: '1', name: 'Despensa Cocina'),
      Pantry(id: '2', name: 'Despensa Congelador'),
      Pantry(id: '3', name: 'Despensa MiniBar'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Despensas'),
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
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Dejarmos la navegacion hacia los productos en la despensa
            }, 
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 0, 
        backgroundColor: theme.colorScheme.primaryContainer,
        child: Icon(Icons.add, color: theme.colorScheme.onPrimaryContainer),
      ),
    );
  }
}