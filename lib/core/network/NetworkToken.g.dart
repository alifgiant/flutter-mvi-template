// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NetworkToken.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkToken _$NetworkTokenFromJson(Map<String, dynamic> json) {
  return NetworkToken(
    json['access_token'] as String ?? '',
    tokenType: json['token_type'] as String,
    expireAt: json['expires_at'] as String,
  );
}

Map<String, dynamic> _$NetworkTokenToJson(NetworkToken instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'expires_at': instance.expireAt,
    };
