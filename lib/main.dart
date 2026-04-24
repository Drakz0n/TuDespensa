import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/inventory_screen.dart'; 
import 'screens/budget_screen.dart';    

void main() => runApp(const TuDespensaApp());

class TuDespensaApp extends StatelessWidget {
  const TuDespensaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TuDespensa',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true, 
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    InventoryScreen(),
    BudgetScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Muestra la pantalla según el índice seleccionado
      body: _screens[_selectedIndex], 
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green[700],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Despensa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Presupuesto',
          ),
        ],
      ),
    );
  }
}