import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist_test/core/enums/common.dart';
import 'package:watchlist_test/presentation/screens/search_screen.dart';

import '../cubits/watchlist/watchlist_cubit.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<WatchlistBloc>().getGroups();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              context.read<WatchlistBloc>().handleSearchOrGroupChange();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<WatchlistBloc, WatchlistState>(
        buildWhen: (oldState, newState) =>
            oldState.symbols != newState.symbols ||
            oldState.groups != newState.groups,
        builder: (BuildContext context, WatchlistState state) {
          if (state.loadingStatus.isSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WatchlistTabs(
                  watchlists: state.groups ?? [],
                ),
                Expanded(
                    child: ReorderableListView.builder(
                  shrinkWrap: true,
                  itemCount: state.symbols?.length ?? 0,
                  onReorder: (oldIndex, newIndex) {
                    context
                        .read<WatchlistBloc>()
                        .reorderSymbols(oldIndex, newIndex);
                  },
                  itemBuilder: (context, index) {
                    final symbol = state.symbols![index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      key: ValueKey(symbol.name),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(6) ,
                        title: Text(symbol.name),
                        tileColor: Colors.white,
                      ),
                    );
                  },
                )),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        listener: (BuildContext context, WatchlistState state) {},
      ),
    );
  }
}

class WatchlistTabs extends StatelessWidget {
  const WatchlistTabs({super.key, required this.watchlists});

  final List<String> watchlists;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: watchlists.map((group) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: ElevatedButton(
              onPressed: () {
                context.read<WatchlistBloc>().handleSearchOrGroupChange();
                context.read<WatchlistBloc>().switchGroup(group);
              },
              child: Text(group),
            ),
          );
        }).toList(),
      ),
    );
  }
}
