// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ExampleKind.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExampleKind _$ExampleKindFromJson(Map<String, dynamic> json) {
  return ExampleKind(
    json['id'] as String,
    json['name'] as String,
    json['unit'] as String,
    isPrefix: json['isPrefix'] as bool,
    isActive: json['isActive'] as bool,
  );
}

Map<String, dynamic> _$ExampleKindToJson(ExampleKind instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'unit': instance.unit,
      'isPrefix': instance.isPrefix,
      'isActive': instance.isActive,
    };
