import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de TuDespensa'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shopping_cart, size: 60, color: Colors.green),
              const SizedBox(height: 16),
              const Text(
                'TuDespensa',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Creado por Martin Bravo - 2026',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              
              // --- SECCIÓN: EXPLICACIÓN DE USO ---
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '¿Cómo utilizar la app?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              
              _buildStep(
                icon: Icons.add_circle_outline,
                title: 'Registra tus productos',
                description: 'Añade los productos que sueles comprar a tu catálogo para no tener que escribirlos siempre.',
              ),
              _buildStep(
                icon: Icons.inventory_2_outlined,
                title: 'Organiza por Despensas',
                description: 'Crea diferentes despensas (Cocina, MiniBar, etc.) y asigna productos según su prioridad.',
              ),
              _buildStep(
                icon: Icons.account_balance_wallet_outlined,
                title: 'Controla tu presupuesto',
                description: 'Asigna tu presupuesto mensual y revisa cuánto te queda disponible según lo que planeas comprar.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget auxiliar para cada paso de la explicación
  Widget _buildStep({required IconData icon, required String title, required String description}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.green[700], size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(color: Colors.black54, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}