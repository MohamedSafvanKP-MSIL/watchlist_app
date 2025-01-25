import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist_test/data/repositories/watchlist_repository_impl.dart';
import 'package:watchlist_test/presentation/cubits/%20bottom_navigation/bottom_nav_cubit.dart';
import 'package:watchlist_test/presentation/cubits/watchlist/watchlist_cubit.dart';
import 'package:watchlist_test/presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => WatchlistBloc(
                MockWatchlistRepositoryImpl()), // Your existing WatchlistBloc
          ),
          BlocProvider(
            create: (_) => BottomNavigationCubit(), // New BottomNavigationCubit
          ),
        ],
        child: const HomeScreen(),
      ),
    );
  }
}
