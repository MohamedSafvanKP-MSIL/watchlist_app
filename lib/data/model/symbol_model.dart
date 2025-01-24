import 'package:equatable/equatable.dart';

class SymbolItem extends Equatable {
  final String name;

  const SymbolItem({required this.name});

  factory SymbolItem.fromJson(Map<String, dynamic> json) {
    return SymbolItem(name: json['name']);
  }

  Map<String, dynamic> toJson() => {'name': name};

  @override
  List<Object> get props => [name];
}