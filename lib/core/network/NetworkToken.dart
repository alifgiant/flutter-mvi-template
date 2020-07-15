import 'package:aset_ku/core/storage/app_config.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'NetworkToken.g.dart';

@JsonSerializable(explicitToJson: true)
class NetworkToken extends Equatable {
  final String accessToken;
  final String tokenType;
  final String expireAt;

  const NetworkToken(
    this.accessToken, {
    this.tokenType = 'bearer',
    this.expireAt: 'never',
  });

  String encode() => '$tokenType $accessToken';

  static NetworkToken _singleton;
  static void set(NetworkToken token) {
    AppConfig.token.val = token;
    _singleton = token;
  }

  static NetworkToken get() {
    if (_singleton == null) _singleton = AppConfig.token.val;
    return _singleton;
  }

  static NetworkToken dataParser(Map<String, dynamic> json) {
    return NetworkToken(
      json[KEY_ACCESS_TOKEN],
      tokenType: json[KEY_TOKEN_TYPE],
      expireAt: json[KEY_EXPIRES_AT],
    );
  }

  static const NetworkToken defToken = NetworkToken('');

  static const KEY_ACCESS_TOKEN = 'access_token';
  static const KEY_TOKEN_TYPE = 'token_type';
  static const KEY_EXPIRES_AT = 'expires_at';

  @override
  List<Object> get props => [accessToken, tokenType, expireAt];

  factory NetworkToken.fromJson(Map<String, dynamic> json) =>
      _$NetworkTokenFromJson(json);

  static Map<String, dynamic> buildJson(NetworkToken token) =>
      _$NetworkTokenToJson(token);

  Map<String, dynamic> toJson() => buildJson(this);
}
