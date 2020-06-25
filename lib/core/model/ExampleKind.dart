import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ExampleKind.g.dart';

@JsonSerializable()
class ExampleKind extends Equatable {
  final String id;
  final String name;
  final String unit;
  final bool isPrefix;
  final bool isActive;

  const ExampleKind(
    this.id,
    this.name,
    this.unit, {
    this.isPrefix = true,
    this.isActive = true,
  });

  @override
  List<Object> get props => [this.id, this.name, this.isActive];

  factory ExampleKind.fromJson(Map<String, dynamic> json) =>
      _$ExampleKindFromJson(json);
  Map<String, dynamic> toJson() => _$ExampleKindToJson(this);

  static const cash = ExampleKind('1', 'Cash', 'Rp');
  static const bank = ExampleKind('2', 'Bank', 'Rp');
  static const forex = ExampleKind('3', 'ForEx', '\$');
  static const deposit = ExampleKind('4', 'Deposit', 'Rp');
  static const insurance = ExampleKind('5', 'Insurance', 'Rp');
  static const mineral = ExampleKind('6', 'Precious Mineral', 'gr');
  static const stock = ExampleKind('7', 'Stock', 'lot', isPrefix: false);
  static const mutFund = ExampleKind('8', 'Mutual Fund', 'lot', isPrefix: false);
  static const bond = ExampleKind('9', 'Bond', 'lot', isPrefix: false);
  static const property = ExampleKind('10', 'Property', 'Rp');

  // wallet types
  static const List<ExampleKind> defaults = const <ExampleKind>[
    cash,
    bank,
    forex,
    deposit,
    insurance,
    mineral,
    stock,
    mutFund,
    bond,
    property,
  ];
}
