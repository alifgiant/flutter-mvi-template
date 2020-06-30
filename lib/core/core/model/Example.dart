import 'package:aset_ku/core/model/ExampleKind.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Example.g.dart';

@JsonSerializable(explicitToJson: true)
class Example extends Equatable {
  final String id;
  final String name;
  final String unit;
  final double balance;
  final ExampleKind kind;
  final String iconId;
  final String labelColor;

  const Example(this.id, this.name, this.unit, this.balance, this.kind,
      this.iconId, this.labelColor);

  @override
  List<Object> get props {
    return <Object>[
      this.id,
      this.name,
      this.unit,
      this.balance,
      this.kind,
      this.iconId,
      this.labelColor
    ];
  }

  factory Example.fromJson(Map<String, dynamic> json) =>
      _$ExampleFromJson(json);
  Map<String, dynamic> toJson() => _$ExampleToJson(this);

  static const mock = Example("1", "Dompet", "Rp", 100000, ExampleKind.cash,
      'Icons.account_balance_wallet', 'Colors.orangeAccent');

  static Example get mockCreate => Example("1", "Dompet", "Rp", 100000,
      ExampleKind.cash, 'Icons.account_balance_wallet', 'Colors.orangeAccent');
}
