import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/pantry.dart';
import '../models/product_registry.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  bool _isSensitiveVisible = false;
  double _presupuestoAsignado = 150000;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Datos de las despensas
    final List<Pantry> todasLasDespensas = [
      Pantry(id: '1', name: 'Cocina', products: [ProductRegistry.savedProducts[0], ProductRegistry.savedProducts[1], ProductRegistry.savedProducts[3]]),
      Pantry(id: '2', name: 'Congelador', products: [ProductRegistry.savedProducts[2], ProductRegistry.savedProducts[6], ProductRegistry.savedProducts[4], ProductRegistry.savedProducts[5]]),
      Pantry(id: '3', name: 'MiniBar', products: [ProductRegistry.savedProducts[5]]),
    ];

    // Cálculos de costos por prioridad
    final double sumaAlta = todasLasDespensas.fold(0.0, (sum, p) => sum + p.highPriorityProducts.fold(0.0, (s, prod) => s + prod.price));
    final double sumaMedia = todasLasDespensas.fold(0.0, (sum, p) => sum + p.mediumPriorityProducts.fold(0.0, (s, prod) => s + prod.price));
    final double sumaBaja = todasLasDespensas.fold(0.0, (sum, p) => sum + p.lowPriorityProducts.fold(0.0, (s, prod) => s + prod.price));
    final double sumaTotal = sumaAlta + sumaMedia + sumaBaja;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Presupuesto Mensual'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              border: Border(
                bottom: BorderSide(color: theme.colorScheme.outlineVariant, width: 1),
              ),
            ),
            child: Column(
              children: [
                Text(
                  'DINERO DISPONIBLE',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.secondary,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildMonetaryText(
                      '\$${_presupuestoAsignado.toInt()}', 
                      theme.textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Icon(
                        _isSensitiveVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                      onPressed: () => setState(() => _isSensitiveVisible = !_isSensitiveVisible),
                    ),
                  ],
                ),
                TextButton.icon(
                  onPressed: _showSetBudgetDialog,
                  icon: const Icon(Icons.edit_outlined, size: 16),
                  label: const Text('Asignar Monto'),
                ),
              ],
            ),
          ),

          // LISTA DE PROYECCIONES
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 10),
              children: [
                _buildProjectionSection(
                  'RESUMEN GLOBAL', 
                  {
                    'Prioridad Alta': sumaAlta,
                    'Prioridad Media': sumaMedia,
                    'Prioridad Baja': sumaBaja,
                  }, 
                  _presupuestoAsignado - sumaTotal,
                ),
                
                _buildProjectionSection(
                  'SOLO ESENCIALES', 
                  {
                    'Total Alta + Media': sumaAlta + sumaMedia,
                  }, 
                  _presupuestoAsignado - (sumaAlta + sumaMedia),
                ),

                _buildProjectionSection(
                  'MUY ESENCIALES', 
                  {
                    'Solo Prioridad Alta': sumaAlta,
                  }, 
                  _presupuestoAsignado - sumaAlta,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectionSection(String title, Map<String, double> items, double saldo) {
    final theme = Theme.of(context);
    final isNegative = saldo < 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
          child: Text(
            title, 
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold, 
              color: Colors.grey[600],
              letterSpacing: 1.1,
            ),
          ),
        ),
        ...items.entries.map((e) => ListTile(
          dense: true,
          title: Text(e.key, style: const TextStyle(fontSize: 15)),
          trailing: _buildMonetaryText(
            '\$${e.value.toInt()}', 
            const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
        )).toList(),
        ListTile(
          title: const Text('Saldo Restante', style: TextStyle(fontWeight: FontWeight.bold)),
          trailing: _buildMonetaryText(
            '\$${saldo.toInt()}',
            TextStyle(
              fontWeight: FontWeight.bold, 
              color: isNegative ? Colors.red : Colors.green, 
              fontSize: 16,
            ),
          ),
        ),
        const Divider(indent: 16, endIndent: 16),
      ],
    );
  }

  Widget _buildMonetaryText(String text, TextStyle? style) {
    return _isSensitiveVisible
        ? Text(text, style: style)
        : ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Text(text.replaceAll(RegExp(r'[0-9]'), '9'), style: style),
          );
  }

  void _showSetBudgetDialog() {
    final controller = TextEditingController(text: _presupuestoAsignado.toInt().toString());
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Asignar Presupuesto'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(prefixText: '\$ '),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              setState(() => _presupuestoAsignado = double.tryParse(controller.text) ?? 0);
              Navigator.pop(context);
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}