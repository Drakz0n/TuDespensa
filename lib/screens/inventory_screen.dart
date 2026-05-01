import 'package:flutter/material.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); 
    
    final List<String> despensas = [
      'Despensa Cocina',
      'Despensa Congelador',
      'Despensa MiniBar',
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
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            leading: Icon(
              Icons.inventory_2_outlined, 
              color: theme.colorScheme.primary,
            ),
            title: Text(
              despensas[index],
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {}, 
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