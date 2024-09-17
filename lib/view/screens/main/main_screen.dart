import 'package:exam_project/view/screens/incomes/incomes_screen.dart';
import 'package:exam_project/view/screens/outcomes_screen/expenses_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPage = 0;

  final pages = [const IncomesScreen(), const ExpensesScreen()];

  setPage(page) => setState(() => _currentPage = page);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentPage,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentPage,
        onDestinationSelected: setPage,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.download_rounded),
            label: "Incomes",
          ),
          NavigationDestination(
            icon: Icon(Icons.upload),
            label: "Expenses",
          ),
        ],
      ),
    );
  }
}
