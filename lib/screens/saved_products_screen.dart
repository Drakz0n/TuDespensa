import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/product_registry.dart';

class SavedProductsScreen extends StatelessWidget {
  const SavedProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos Guardados'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar producto...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: ProductRegistry.savedProducts.length,
              itemBuilder: (context, index) {
                final product = ProductRegistry.savedProducts[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    backgroundImage: product.ImagePath != null 
                        ? AssetImage(product.ImagePath!) 
                        : null,
                    child: product.ImagePath == null ? const Icon(Icons.fastfood) : null,
                  ),
                  title: Text(product.name),
                  subtitle: Text('Precio : \$${product.price.toInt()}'),
                  trailing: const Icon(Icons.add_circle_outline, color: Colors.green),
                  onTap: () {
                    // devuelve el producto seleccionado
                    Navigator.pop(context, product);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}