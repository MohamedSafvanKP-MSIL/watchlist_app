import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/search/search_cubit.dart';
import '../cubits/watchlist/watchlist_cubit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          SearchCubit()..initialize(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Search Symbols'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  onChanged: (query) {
                    context.read<SearchCubit>().filterSymbols(
                        query);
                  },
                  decoration: InputDecoration(
                    labelText: 'Search',
                    hintText: 'Search symbols...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
                const SizedBox(height: 20),

                // Displaying symbols
                Expanded(
                  child: BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      if (state.symbols.isEmpty) {
                        return const Center(child: Text('No symbols found'));
                      }

                      return ListView.builder(
                        itemCount: state.symbols.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(state.symbols[index]),
                            onTap: () {
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
