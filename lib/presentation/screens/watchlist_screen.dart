import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist_test/core/enums/common.dart';

import '../cubits/watchlist_cubit.dart';

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
        title: Text('Watchlist'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              context.read<WatchlistBloc>().handleSearchOrGroupChange();
              // Navigate to search screen
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
              children: [
                WatchlistTabs(
                  watchlists: state.groups ?? [],
                ),
                Expanded(
                    child: ReorderableListView(
                  onReorder: context.read<WatchlistBloc>().reorderSymbols,
                  children: state.symbols!.map((symbol) {
                    return ListTile(
                      key: ValueKey(symbol.name),
                      title: Text(symbol.name),
                    );
                  }).toList(),
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
    return Row(
      children: watchlists.map((group) {
        return ElevatedButton(
          onPressed: () {
            context.read<WatchlistBloc>().handleSearchOrGroupChange();
            context.read<WatchlistBloc>().switchGroup(group);
          },
          child: Text(group),
        );
      }).toList(),
    );
  }
}
