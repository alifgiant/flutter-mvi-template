const String PROTOCOL_HTTP = 'http';
const String PROTOCOL_HTTPS = 'https';

class UriData {
  final String envName;
  final String protocol;
  final String domain;
  final String port;
  final String path;

  const UriData(this.envName, this.protocol, this.domain, this.port, this.path);
}

class NetworkEnv {
  final UriData uriData;

  const NetworkEnv._(this.uriData);

  String get root {
    String url = '${uriData.protocol}://${uriData.domain}';
    if (uriData.port.isNotEmpty) url += ':${uriData.port}';
    return url;
  }

  String get url => root + uriData.path;

  static NetworkEnv _singleton;
  static void set(NetworkEnv env) => _singleton = env;
  static NetworkEnv get() {
    if (_singleton == null) _singleton = PRODUCTION;
    return _singleton;
  }

  static const NetworkEnv PRODUCTION = const NetworkEnv._(UriData(
    "production",
    PROTOCOL_HTTPS,
    "asetku.luxinfity.com",
    "",
    "/api",
  ));

  static const NetworkEnv DEBUG = const NetworkEnv._(UriData(
    "debug",
    PROTOCOL_HTTPS,
    "asetdev.luxinfity.com",
    "",
    "/api",
  ));

  static const NetworkEnv MOCK = const NetworkEnv._(UriData(
    "mock",
    PROTOCOL_HTTPS,
    "7185f494-c7e3-4565-ba39-5c3529b66469.mock.pstmn.io",
    "",
    "/api",
  ));
}
