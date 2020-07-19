import 'package:aset_ku/core/storage/app_config.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'NetworkToken.g.dart';

@JsonSerializable(explicitToJson: true)
class NetworkToken extends Equatable {
  @JsonKey(name: 'access_token', defaultValue: '')
  final String accessToken;
  @JsonKey(name: 'token_type')
  final String tokenType;
  @JsonKey(name: 'expires_at')
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

  static const NetworkToken defToken = NetworkToken('');

  @override
  List<Object> get props => [accessToken, tokenType, expireAt];

  factory NetworkToken.fromJson(Map<String, dynamic> json) =>
      _$NetworkTokenFromJson(json);

  static Map<String, dynamic> buildJson(NetworkToken token) =>
      _$NetworkTokenToJson(token);

  Map<String, dynamic> toJson() => buildJson(this);
}
