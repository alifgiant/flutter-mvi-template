// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NetworkToken.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkToken _$NetworkTokenFromJson(Map<String, dynamic> json) {
  return NetworkToken(
    json['accessToken'] as String,
    tokenType: json['tokenType'] as String,
    expireAt: json['expireAt'] as String,
  );
}

Map<String, dynamic> _$NetworkTokenToJson(NetworkToken instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'tokenType': instance.tokenType,
      'expireAt': instance.expireAt,
    };
