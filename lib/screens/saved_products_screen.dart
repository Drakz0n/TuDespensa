import 'package:flutter/material.dart';
import '../models/product_registry.dart';

class SavedProductsScreen extends StatelessWidget {
  const SavedProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos Guardados'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: ProductRegistry.savedProducts.length,
        itemBuilder: (context, index) {
          final product = ProductRegistry.savedProducts[index];
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: product.imagePath != null 
                  ? Image.asset(product.imagePath!, width: 40, height: 40, fit: BoxFit.cover)
                  : Container(
                      width: 40, 
                      height: 40, 
                      color: Colors.grey[200], 
                      child: const Icon(Icons.image_outlined, color: Colors.grey),
                    ),
            ),
            title: Text(product.name),
            subtitle: Text('\$${product.price.toInt()}'),
            trailing: const Icon(Icons.add_circle_outline, color: Colors.green),
            onTap: () {
              Navigator.pop(context, product);
            },
          );
        },
      ),
      // boton para agregar nuevo producto al catálogo
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateProductDialog(context);
        },
        backgroundColor: Colors.green[700],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // Codigo previamente usado para agregar productos al catalogo.
  void _showCreateProductDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nuevo Producto'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Boton de Camara
            InkWell(
              onTap: () {}, // Simular abrir cámara
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.camera_alt, color: Colors.grey),
              ),
            ),
            const TextField(decoration: InputDecoration(labelText: 'Nombre')),
            const TextField(decoration: InputDecoration(labelText: 'Precio'), keyboardType: TextInputType.number),
            // Dropdown para Prioridad
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Prioridad'),
              items: const [
                DropdownMenuItem(value: 'high', child: Text('Alta')),
                DropdownMenuItem(value: 'medium', child: Text('Media')),
                DropdownMenuItem(value: 'low', child: Text('Baja')),
              ],
              onChanged: (value) {}, // Simular selección de prioridad
            ),  
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Guardar')),
        ],
      ),
    );
  }
}