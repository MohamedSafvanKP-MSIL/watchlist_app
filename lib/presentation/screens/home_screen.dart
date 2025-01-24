import 'package:flutter/material.dart';
import 'package:watchlist_test/presentation/screens/watchlist_screen.dart';

import 'order_pad_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: const [
          WatchlistScreen(),
          OrderPadScreen()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Watchlist'),
          BottomNavigationBarItem(icon: Icon(Icons.library_add), label: 'Order'),
        ],
      ),
    );
  }
}