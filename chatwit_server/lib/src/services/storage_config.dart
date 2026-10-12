import 'dart:io';

/// Centralized S3 storage configuration, env-driven for all deployments.
class StorageConfig {
  /// Resolved from environment or defaults
  final String bucket;
  final String region;
  final String publicDomain;

  StorageConfig({
    required this.bucket,
    required this.region,
    required this.publicDomain,
  });

  /// Factory constructor that reads from environment variables
  factory StorageConfig.fromEnvironment() {
    final bucket = _envRequired('S3_BUCKET', 'chatwit-storage');
    final region = _envRequired('S3_REGION', 'eu-north-1');
    
    // Allow custom domain for CDN or custom S3 endpoint
    final publicDomain = _envOptional(
      'S3_PUBLIC_DOMAIN',
      '$bucket.s3.$region.amazonaws.com',
    );

    return StorageConfig(
      bucket: bucket,
      region: region,
      publicDomain: publicDomain,
    );
  }

  /// Construct a public-facing URL for a storage object
  String getPublicUrl(String path) {
    // Ensure path doesn't start with a slash
    final cleanPath = path.startsWith('/') ? path.substring(1) : path;
    return 'https://$publicDomain/$cleanPath';
  }

  /// Get S3 connection string for Serverpod S3CloudStorage
  String get s3ConnectionString => bucket;
}

/// Helper to get required environment variables, with optional default fallback
String _envRequired(String key, [String? defaultValue]) {
  final value = Platform.environment[key]?.trim();
  if (value != null && value.isNotEmpty) {
    return value;
  }
  if (defaultValue != null) {
    return defaultValue;
  }
  throw StateError('Missing required environment variable: $key');
}

/// Helper to get optional environment variables, with fallback
String _envOptional(String key, String defaultValue) {
  final value = Platform.environment[key]?.trim();
  return (value != null && value.isNotEmpty) ? value : defaultValue;
}
