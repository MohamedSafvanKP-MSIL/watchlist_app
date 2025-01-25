import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {

  final List<String> _defaultSymbols = [
    'TCS',
    'NOCL',
    'TATA STEEL',
    'TATA POWER',
    'IDEA',
    'COAL INDIA',
    'RELIANCE',
    'INFOSYS',
    'HDFC',
    'ICICI BANK',
  ];

  SearchCubit() : super(const SearchState(symbols: [], query: ''));


  void initialize() {
    emit(state.copyWith(symbols: _defaultSymbols));
  }

  void filterSymbols(String query) {
    final filteredSymbols = _defaultSymbols
        .where((symbol) => symbol.toLowerCase().contains(query.toLowerCase()))
        .toList();
    emit(state.copyWith(symbols: filteredSymbols, query: query));
  }
}
