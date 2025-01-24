import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist_test/core/enums/common.dart';
import 'package:watchlist_test/data/model/symbol_model.dart';
import 'package:watchlist_test/data/repositories/watchlist_repository_impl.dart';

part 'watchlist_state.dart';

class WatchlistBloc extends Cubit<WatchlistState> {
  final MockWatchlistRepositoryImpl _repository;

  // local persist for the order of watchlist
  final Map<String, List<SymbolItem>> _watchlistSymbolMap = {};

  WatchlistBloc(this._repository) : super(const WatchlistState()) {
    switchGroup(_repository.getGroups().first);
  }

  void getGroups() {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));
    final groups = _repository.getGroups();
    emit(state.copyWith(groups: groups, loadingStatus: LoadingStatus.success));
  }

  void switchGroup(String groupName) {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));
    final symbols = _watchlistSymbolMap[groupName] ??
        _repository.getSymbolsByGroup(groupName);
    emit(state.copyWith(
        symbols: symbols,
        groupName: groupName,
        isEditMode: false,
        loadingStatus: LoadingStatus.success));
  }

  void toggleEditMode(bool isEditMode) {
    emit(state.copyWith(isEditMode: isEditMode));
  }

  void reorderSymbols(int oldIndex, int newIndex) {
    if (state.symbols != null) {
      final symbols = List<SymbolItem>.of(state.symbols!);
      final symbol = symbols.removeAt(oldIndex);
      symbols.insert(newIndex > oldIndex ? newIndex - 1 : newIndex, symbol);

      _watchlistSymbolMap[state.groupName!] = symbols;
      emit(state.copyWith(symbols: symbols));
    }
  }

  void handleSearchOrGroupChange() {
    if (state.isEditMode ?? false) {
      emit(state.copyWith(isEditMode: false));
    }
  }
}
