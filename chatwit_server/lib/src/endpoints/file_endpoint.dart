import 'package:serverpod/serverpod.dart';

class FileEndpoint extends Endpoint {
  Future<String?> getUploadDescription(Session session, String path) async {
    return await session.storage.createUploadDescription(
      storageId: 'public',
      path: path,
    );
  }

  Future<bool> verifyUpload(Session session, String path) async {
    return await session.storage.verifyUpload(
      storageId: 'public',
      path: path,
    );
  }

  Future<String?> getPublicUrl(Session session, String path) async {
    final uri = await session.storage.publicDownloadUrl(
      storageId: 'public',
      path: path,
    );
    return uri.toString();
  }
}
