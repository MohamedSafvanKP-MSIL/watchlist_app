import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist_test/presentation/cubits/%20bottom_navigation/bottom_nav_cubit.dart';
import 'package:watchlist_test/presentation/screens/watchlist_screen.dart';

import 'order_pad_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;


  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
      buildWhen: (oldState , newState) => oldState.index != newState.index,
      builder: (BuildContext context, BottomNavigationState state) {
        return Scaffold(
          body: PageView(
            controller: _pageController,
            children: const [
              WatchlistScreen(),
              OrderPadScreen()
            ],
            onPageChanged: ( index){
              context.read<BottomNavigationCubit>().selectTab(index);
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.index,
            onTap: (index){
              context.read<BottomNavigationCubit>().selectTab(index);
              _pageController.jumpToPage(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.list), label: 'Watchlist'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.library_add), label: 'Order'),
            ],
          ),
        );
      },
    );
  }
}