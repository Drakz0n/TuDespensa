import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/pantry.dart';
import '../models/product_registry.dart';
import 'saved_products_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isMonthlyBudgetVisible = false;

  @override
  Widget build(BuildContext context) {
    // Datos de las despensas
    final List<Pantry> despensas = [
      Pantry(
        id: '1', 
        name: 'Despensa Cocina',
        products: [ProductRegistry.savedProducts[0], ProductRegistry.savedProducts[1], ProductRegistry.savedProducts[3]],
      ),
      Pantry(
        id: '2', 
        name: 'Despensa Congelador',
        products: [ProductRegistry.savedProducts[2], ProductRegistry.savedProducts[6], ProductRegistry.savedProducts[4], ProductRegistry.savedProducts[5]],
      ),
      Pantry(
        id: '3', 
        name: 'Despensa MiniBar',
        products: [ProductRegistry.savedProducts[5]],
      ),
    ];

    despensas.sort((a, b) => b.products.length.compareTo(a.products.length));
    final topDespensas = despensas.take(3).toList();
    final int productosRegistrados = ProductRegistry.savedProducts.length;

    return Scaffold(
      extendBody: true,
      body: Container(
        width: double.infinity,
        height: double.infinity, // Forzamos el color a toda la pantalla
        decoration: BoxDecoration(
          color: Colors.green[700],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        
                        // LOGO / SLOGAN
                        const Icon(Icons.shopping_cart, size: 90, color: Colors.white),
                        const SizedBox(height: 10),
                        const Text(
                          'TuDespensa',
                          style: TextStyle(color: Colors.white, fontSize: 38, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Optimiza tu bolsillo, organiza tu hogar.',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        
                        const Spacer(),
                        const Divider(color: Colors.white24, thickness: 1, indent: 40, endIndent: 40),
                        const Spacer(),

                        // PRESUPUESTO MENSUAL
                       const Text(
                        'PRESUPUESTO MENSUAL',
                        style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () => setState(() => _isMonthlyBudgetVisible = !_isMonthlyBudgetVisible),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center, 
                            mainAxisSize: MainAxisSize.min, 
                            children: [
                              // El presupuesto 
                              _isMonthlyBudgetVisible
                                  ? const Text(
                                      '\$150.000',
                                      style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.w900),
                                    )
                                  : ImageFiltered(
                                      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                                      child: const Text(
                                        '\$999.999',
                                        style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.w900),
                                      ),
                                    ),
                              const SizedBox(width: 12), 
                              Icon(
                                _isMonthlyBudgetVisible ? Icons.visibility_off : Icons.visibility,
                                color: Colors.white70,
                                size: 24,
                              ),
                            ],
                          ),
                        ),

                        const Spacer(),
                        const Divider(color: Colors.white24, thickness: 1, indent: 40, endIndent: 40),
                        const Spacer(), 

                        const Text(
                          'DESPENSAS PRINCIPALES',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 12),
                        ),
                        const SizedBox(height: 15),
                        ...topDespensas.map((p) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            '${p.name}: ${p.products.length} ítems',
                            style: const TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        )),

                        const Spacer(),
                        const Divider(color: Colors.white24, thickness: 1, indent: 40, endIndent: 40),
                        const Spacer(),
                        // PRODUCTOS REGISTRADOS
                        const Text(
                          'PRODUCTOS REGISTRADOS',
                          style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '$productosRegistrados',
                          style: const TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.w200),
                        ),
                        const Text(
                          'en tu catálogo personal',
                          style: TextStyle(color: Colors.white60, fontSize: 14),
                        ),
                        // Botón para explorar catálogo
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SavedProductsScreen()),
                            );
                          },
                          // Icono de búsqueda y texto del botón y estilos
                          icon: const Icon(Icons.search, color: Colors.green),
                          label: const Text('Explorar Catálogo'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.green[700],
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                        ),
                        
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}