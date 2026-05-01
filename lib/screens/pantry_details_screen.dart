import 'package:flutter/material.dart';
import '../models/pantry.dart';
import '../models/product.dart';

class PantryDetailsScreen extends StatelessWidget {
  final Pantry pantry;

  const PantryDetailsScreen({super.key, required this.pantry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pantry.name),
      ),
      body: ListView(
        children: [
          _buildPriorityList(context, 'Alta Prioridad', pantry.highPriorityProducts, Colors.red),
          _buildPriorityList(context, 'Prioridad Media', pantry.mediumPriorityProducts, Colors.orange),
          _buildPriorityList(context, 'Baja Prioridad', pantry.lowPriorityProducts, Colors.blue),
        ],
      ),
    );
  }

  Widget _buildPriorityList(BuildContext context, String title, List<Product> products, Color color) {
    if (products.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        ...products.map((product) => ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: product.ImagePath != null
                ? Image.asset(
                    product.ImagePath!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                  )
                : const Icon(Icons.image_outlined),
              ),
            ),
          title: Text(product.name),
          trailing: Text('\$${product.price.toInt()}'),
        )).toList(),
        const Divider(),
      ],
    );
  }
}