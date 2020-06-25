// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Example _$ExampleFromJson(Map<String, dynamic> json) {
  return Example(
    json['id'] as String,
    json['name'] as String,
    json['unit'] as String,
    (json['balance'] as num)?.toDouble(),
    json['kind'] == null
        ? null
        : ExampleKind.fromJson(json['kind'] as Map<String, dynamic>),
    json['iconId'] as String,
    json['labelColor'] as String,
  );
}

Map<String, dynamic> _$ExampleToJson(Example instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'unit': instance.unit,
      'balance': instance.balance,
      'kind': instance.kind?.toJson(),
      'iconId': instance.iconId,
      'labelColor': instance.labelColor,
    };
