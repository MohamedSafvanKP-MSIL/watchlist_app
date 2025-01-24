import '../../data/model/symbol_model.dart';

abstract class WatchlistRepository {
  List<String> getGroups();

  List<SymbolItem> getSymbolsByGroup(String groupName);
}
