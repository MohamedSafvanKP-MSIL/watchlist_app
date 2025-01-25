import '../../domain/repositories/watchlist_repository.dart';
import '../mock_data/mock_symbols.dart';
import '../model/symbol_model.dart';

class MockWatchlistRepositoryImpl implements WatchlistRepository {
  @override
  List<String> getGroups() {
    return mockData.map((group) => group['watchListName'] as String).toList();
  }

  @override
  List<SymbolItem> getSymbolsByGroup(String groupName) {
    final group = mockData.firstWhere(
          (group) => group['watchListName'] == groupName,
      orElse: () => {'symbols': []},
    );
    return (group['symbols'] as List)
        .map((symbolData) => SymbolItem.fromJson(symbolData))
        .toList();
  }
}