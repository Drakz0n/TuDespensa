import 'dart:ui'; // para usar el blur en los detalles importantes
import 'package:flutter/material.dart';
import '../models/pantry.dart';
import '../models/product.dart';
import 'saved_products_screen.dart';

class PantryDetailsScreen extends StatefulWidget {
  final Pantry pantry;

  const PantryDetailsScreen({super.key, required this.pantry});

  @override
  State<PantryDetailsScreen> createState() => _PantryDetailsScreenState();
}

class _PantryDetailsScreenState extends State<PantryDetailsScreen> {
  bool _isBudgetVisible = false; // Controla el blur del presupuesto

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pantry.name),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // HEADER con informacion general de la despensa
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              border: Border(
                bottom: BorderSide(color: theme.colorScheme.outlineVariant, width: 1),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'PRESUPUESTO TOTAL',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.secondary,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Botón para mostrar la plata
                    GestureDetector(
                      onTap: () => setState(() => _isBudgetVisible = !_isBudgetVisible),
                      child: Icon(
                        _isBudgetVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        size: 18,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                // Efecto de Blur aplicado al presupuesto
                _isBudgetVisible 
                  ? Text(
                      '\$${widget.pantry.totalPrice.toInt()}',
                      style: theme.textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: theme.colorScheme.primary,
                      ),
                    )
                  : ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Text(
                        '\$999999',
                        style: theme.textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: theme.colorScheme.primary.withOpacity(0.5),
                        ),
                      ),
                    ),
                
                const SizedBox(height: 20),
                
                // Presupuestos por prioridad con efecto blur aplicado
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    // Effecto blur para cada prioridad
                    _isBudgetVisible
                      ? _buildTextCounter('Alta: \$${widget.pantry.highPrice.toInt()}', Colors.red)
                      : ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: _buildTextCounter('Alta: \$99999', Colors.red.withOpacity(0.5)),
                        ),
                    _buildDivider(),
                    _isBudgetVisible
                      ? _buildTextCounter('Media: \$${widget.pantry.mediumPrice.toInt()}', Colors.orange)
                      : ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: _buildTextCounter('Media: \$99999', Colors.orange.withOpacity(0.5)),
                        ),
                    _buildDivider(),
                    _isBudgetVisible
                      ? _buildTextCounter('Baja: \$${widget.pantry.lowPrice.toInt()}', Colors.blue)
                      : ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: _buildTextCounter('Baja: \$99999', Colors.blue.withOpacity(0.5)),
                        ), 
                  ],
                ),
              ],
            ),
          ),
          
          // LISTA DE PRODUCTOS
          Expanded(
            child: ListView(
              children: [
                _buildPriorityList(context, 'Alta Prioridad', widget.pantry.highPriorityProducts, Colors.red),
                _buildPriorityList(context, 'Prioridad Media', widget.pantry.mediumPriorityProducts, Colors.orange),
                _buildPriorityList(context, 'Baja Prioridad', widget.pantry.lowPriorityProducts, Colors.blue),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddOptions(context),
        backgroundColor: theme.colorScheme.primary,
        child: const Icon(Icons.add_shopping_cart, color: Colors.white),
      ),
    );
  }

  Widget _buildTextCounter(String text, Color color) {
    return Text(text, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 15));
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Text('|', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300)),
    );
  }

  Widget _buildPriorityList(BuildContext context, String title, List<Product> products, Color color) {
    if (products.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
          child: Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        ...products.map((product) => ListTile(
          leading: Container(
            width: 52, height: 52,
            decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: product.ImagePath != null
                  ? Image.asset(product.ImagePath!, fit: BoxFit.cover)
                  : const Icon(Icons.image_outlined),
            ),
          ),
          title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.w500)),
          trailing: Text('\$${product.price.toInt()}', style: const TextStyle(fontWeight: FontWeight.bold)),
        )).toList(),
        const Divider(indent: 16, endIndent: 16),
      ],
    );
  }

  void _showAddOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.search), 
              title: const Text('Agregar producto existente'), 
              onTap: () async { 
                Navigator.pop(context); // Cierra el menú 
                
                // Navega a la pantalla de productos guardados
                final productSelected = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SavedProductsScreen()),
                );

                if (productSelected != null) {
                  // vacio por ahora.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${productSelected.name} añadido a la despensa')),
                  );
                }
              },
            ),
            ListTile(leading: const Icon(Icons.add_box_outlined), title: const Text('Crear nuevo producto'), onTap: () { Navigator.pop(context); _showCreateProductDialog(context); }),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

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