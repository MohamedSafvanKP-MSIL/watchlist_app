part of 'watchlist_cubit.dart';

class WatchlistState extends Equatable {
  const WatchlistState(
      {this.loadingStatus = LoadingStatus.initial,
      this.symbols,
      this.groupName,
      this.isEditMode,
      this.groups});

  final LoadingStatus loadingStatus;
  final List<SymbolItem>? symbols;
  final String? groupName;
  final bool? isEditMode;
  final List<String>? groups;

  @override
  List<Object?> get props =>
      [loadingStatus, symbols, groupName, isEditMode, groups];

  WatchlistState copyWith(
      {LoadingStatus? loadingStatus,
      List<SymbolItem>? symbols,
      String? groupName,
      bool? isEditMode,
      List<String>? groups}) {
    return WatchlistState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        symbols: symbols ?? this.symbols,
        groupName: groupName ?? this.groupName,
        isEditMode: isEditMode ?? this.isEditMode,
        groups: groups ?? this.groups);
  }
}
