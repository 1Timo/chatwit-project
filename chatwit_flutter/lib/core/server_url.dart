class ServerUrl {
  ServerUrl._();

  static const _configuredUrl = String.fromEnvironment('SERVER_URL');
  static const _defaultUrl = 'http://10.0.2.2:8080/';

  static Uri get baseUri => _asBaseUri(
    _configuredUrl.isEmpty ? _defaultUrl : _configuredUrl,
  );

  static String resolveMediaUrl(String path) =>
      resolveMediaUrlAgainst(path, baseUrl: baseUri.toString());

  static String resolveMediaUrlAgainst(
    String path, {
    required String baseUrl,
  }) {
    final uri = Uri.tryParse(path);
    if (uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.hasAuthority) {
      return uri.toString();
    }

    final relativePath = path.startsWith('/') ? path.substring(1) : path;
    return _asBaseUri(baseUrl).resolve(relativePath).toString();
  }

  static Uri _asBaseUri(String value) {
    final uri = Uri.parse(value);
    if (uri.path.endsWith('/')) return uri;
    return uri.replace(path: '${uri.path}/');
  }
}
