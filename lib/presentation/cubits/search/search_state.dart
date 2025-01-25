part of 'search_cubit.dart';

class SearchState extends Equatable {
  final List<String> symbols;
  final String query;

  const SearchState({
    required this.symbols,
    required this.query,
  });

  SearchState copyWith({
    List<String>? symbols,
    String? query,
  }) {
    return SearchState(
      symbols: symbols ?? this.symbols,
      query: query ?? this.query,
    );
  }

  @override
  List<Object> get props => [symbols, query];
}
