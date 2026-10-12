import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import '../generated/protocol.dart';

class UserRegistrationEndpoint extends Endpoint {
  // Check if the user has already completed registration
  Future<bool> isRegistrationComplete(Session session) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return false;

    final registration = await UserRegistration.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );

    return registration != null;
  }

  // Save the registration details
  Future<bool> submitRegistration(
    Session session, {
    required String firstName,
    required String surname,
    String? middleName,
    required String username,
    required DateTime dateOfBirth,
    required String sex,
    String? occupation,
    String? location,
    String? website,
  }) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw Exception('User is not authenticated');
    }

    // Check if username is already taken
    final existing = await UserRegistration.db.findFirstRow(
      session,
      where: (t) => t.username.equals(username),
    );
    if (existing != null) {
      throw Exception('Username is already taken');
    }

    // Insert user registration data
    final registration = UserRegistration(
      authUserId: authUserId,
      firstName: firstName,
      surname: surname,
      middleName: middleName,
      username: username,
      dateOfBirth: dateOfBirth,
      gender: sex,
      occupation: occupation,
      location: location,
      website: website,
      createdAt: DateTime.now(),
      isLocationPublic: true,
      isDobPublic: false,
    );

    await UserRegistration.db.insertRow(session, registration);
    return true;
  }

  Future<bool> deleteAccount(Session session) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return false;

    await UserRegistration.db.deleteWhere(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    await ProfilePhoto.db.deleteWhere(
      session,
      where: (t) => t.userId.equals(authUserId.toString()),
    );

    final userId = session.authenticated!.userIdentifier;
    final userPosts = await Post.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );
    final postIds = userPosts.map((post) => post.id!).toSet();
    await PostShare.db.deleteWhere(
      session,
      where: (t) =>
          t.userId.equals(userId) |
          (postIds.isEmpty ? t.postId.equals(-1) : t.postId.inSet(postIds)),
    );
    await Post.db.deleteWhere(session, where: (t) => t.userId.equals(userId));

    return true;
  }

  Future<UserRegistration?> getUserInfo(Session session, String userId) async {
    final authUserId = UuidValue.fromString(userId);
    final registration = await UserRegistration.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );

    if (registration != null) {
      // 1. Format Join Date logic
      registration.createdAt ??= DateTime(2026, 7, 1); // July 2026 fallback

      // 2. Safe Profile Image Enrichment
      String? profileImageUrl = registration.profileImageUrl;
      if (profileImageUrl == null || profileImageUrl.isEmpty) {
        final userProfile = await const UserProfiles()
            .maybeFindUserProfileByUserId(session, authUserId);
        profileImageUrl = userProfile?.imageUrl?.toString();
      }

      if (profileImageUrl != null && !profileImageUrl.startsWith('http')) {
        registration.profileImageUrl = await _getPublicUrlSafe(
          session,
          profileImageUrl,
        );
      } else {
        registration.profileImageUrl = profileImageUrl;
      }

      // 3. Safe Background Image Enrichment
      if (registration.backgroundUrl != null &&
          !registration.backgroundUrl!.startsWith('http')) {
        registration.backgroundUrl = await _getPublicUrlSafe(
          session,
          registration.backgroundUrl!,
        );
      }
    }

    return registration;
  }

  Future<bool> updateBio(Session session, String bio) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return false;

    final registration = await UserRegistration.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (registration == null) return false;

    registration.bio = bio;
    await UserRegistration.db.updateRow(session, registration);
    return true;
  }

  Future<bool> updateBackgroundUrl(
    Session session,
    String backgroundUrl,
  ) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return false;

    final registration = await UserRegistration.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (registration == null) return false;

    await _recordProfilePhoto(
      session,
      registration.authUserId.toString(),
      'background',
      registration.backgroundUrl,
    );
    registration.backgroundUrl = backgroundUrl;
    await UserRegistration.db.updateRow(session, registration);
    await _recordProfilePhoto(
      session,
      registration.authUserId.toString(),
      'background',
      backgroundUrl,
    );
    return true;
  }

  Future<bool> updateProfileImageUrl(
    Session session,
    String profileImageUrl,
  ) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return false;

    final registration = await UserRegistration.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (registration == null) return false;

    var previousProfileImageUrl = registration.profileImageUrl;
    if (previousProfileImageUrl == null || previousProfileImageUrl.isEmpty) {
      final authProfile = await const UserProfiles()
          .maybeFindUserProfileByUserId(session, authUserId);
      previousProfileImageUrl = authProfile?.imageUrl?.toString();
    }
    await _recordProfilePhoto(
      session,
      registration.authUserId.toString(),
      'profile',
      previousProfileImageUrl,
    );
    registration.profileImageUrl = profileImageUrl;
    await UserRegistration.db.updateRow(session, registration);
    await _recordProfilePhoto(
      session,
      registration.authUserId.toString(),
      'profile',
      profileImageUrl,
    );
    return true;
  }

  Future<List<ProfilePhoto>> getProfilePhotoHistory(
    Session session,
    String userId,
  ) async {
    final authUserId = UuidValue.fromString(userId);
    final registration = await UserRegistration.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (registration == null) return [];

    final id = registration.authUserId.toString();
    var profileImageUrl = registration.profileImageUrl;
    if (profileImageUrl == null || profileImageUrl.isEmpty) {
      final authProfile = await const UserProfiles()
          .maybeFindUserProfileByUserId(session, registration.authUserId);
      profileImageUrl = authProfile?.imageUrl?.toString();
    }
    await _recordProfilePhoto(
      session,
      id,
      'profile',
      profileImageUrl,
    );
    await _recordProfilePhoto(
      session,
      id,
      'background',
      registration.backgroundUrl,
    );

    final photos = await ProfilePhoto.db.find(
      session,
      where: (t) => t.userId.equals(id),
      orderBy: (t) => t.createdAt.desc(),
    );
    for (final photo in photos) {
      if (!photo.imageUrl.startsWith('http')) {
        photo.imageUrl =
            await _getPublicUrlSafe(session, photo.imageUrl) ?? photo.imageUrl;
      }
    }
    return photos;
  }

  Future<bool> deleteProfilePhoto(Session session, int photoId) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return false;

    final photo = await ProfilePhoto.db.findById(session, photoId);
    if (photo == null ||
        photo.userId != authUserId.toString() ||
        (photo.imageType != 'profile' && photo.imageType != 'background')) {
      return false;
    }

    final registration = await UserRegistration.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (registration == null) return false;

    if (photo.imageUrl.startsWith('profiles/avatars/') ||
        photo.imageUrl.startsWith('profiles/backgrounds/')) {
      await session.storage.deleteFile(
        storageId: 'public',
        path: photo.imageUrl,
      );
    }
    await ProfilePhoto.db.deleteRow(session, photo);
    final currentUrl = photo.imageType == 'profile'
        ? registration.profileImageUrl
        : registration.backgroundUrl;
    if (currentUrl == photo.imageUrl) {
      final remainingPhotos = await ProfilePhoto.db.find(
        session,
        where: (t) =>
            t.userId.equals(photo.userId) & t.imageType.equals(photo.imageType),
        orderBy: (t) => t.createdAt.desc(),
      );
      if (photo.imageType == 'profile') {
        registration.profileImageUrl = remainingPhotos.isEmpty
            ? null
            : remainingPhotos.first.imageUrl;
      } else if (photo.imageType == 'background') {
        registration.backgroundUrl = remainingPhotos.isEmpty
            ? null
            : remainingPhotos.first.imageUrl;
      } else {
        return false;
      }
      await UserRegistration.db.updateRow(session, registration);
    }
    return true;
  }

  Future<void> _recordProfilePhoto(
    Session session,
    String userId,
    String imageType,
    String? imageUrl,
  ) async {
    if (imageUrl == null || imageUrl.isEmpty) return;
    final existing = await ProfilePhoto.db.findFirstRow(
      session,
      where: (t) =>
          t.userId.equals(userId) &
          t.imageType.equals(imageType) &
          t.imageUrl.equals(imageUrl),
    );
    if (existing != null) return;

    await ProfilePhoto.db.insertRow(
      session,
      ProfilePhoto(
        userId: userId,
        imageType: imageType,
        imageUrl: imageUrl,
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<List<UserRegistration>> getAllUsers(Session session) async {
    return await UserRegistration.db.find(session);
  }

  Future<List<UserRegistration>> searchUsers(
    Session session,
    String query,
  ) async {
    if (query.isEmpty) return [];

    final results = await UserRegistration.db.find(
      session,
      where: (t) =>
          t.username.ilike('%$query%') |
          t.firstName.ilike('%$query%') |
          t.surname.ilike('%$query%'),
      limit: 20,
    );

    for (var user in results) {
      // Safe Profile Image Enrichment
      String? profileImageUrl = user.profileImageUrl;
      if (profileImageUrl == null || profileImageUrl.isEmpty) {
        final userProfile = await const UserProfiles()
            .maybeFindUserProfileByUserId(session, user.authUserId);
        profileImageUrl = userProfile?.imageUrl?.toString();
      }

      if (profileImageUrl != null && !profileImageUrl.startsWith('http')) {
        user.profileImageUrl = await _getPublicUrlSafe(
          session,
          profileImageUrl,
        );
      } else {
        user.profileImageUrl = profileImageUrl;
      }
    }

    return results;
  }

  Future<String?> getUploadDescription(Session session, String path) async {
    return await session.storage.createUploadDescription(
      storageId: 'public',
      path: path,
    );
  }

  Future<bool> updateProfile(
    Session session, {
    required String firstName,
    required String surname,
    String? bio,
    String? occupation,
    String? website,
    String? location,
    bool? isLocationPublic,
    bool? isDobPublic,
    required DateTime dateOfBirth,
  }) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return false;

    final registration = await UserRegistration.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );

    if (registration == null) return false;

    registration.firstName = firstName;
    registration.surname = surname;
    registration.bio = bio;
    registration.occupation = occupation;
    registration.website = website;
    registration.location = location;
    if (isLocationPublic != null) {
      registration.isLocationPublic = isLocationPublic;
    }
    if (isDobPublic != null) {
      registration.isDobPublic = isDobPublic;
    }
    registration.dateOfBirth = dateOfBirth;

    await UserRegistration.db.updateRow(session, registration);
    return true;
  }

  Future<bool> verifyUpload(Session session, String path) async {
    return await session.storage.verifyUpload(storageId: 'public', path: path);
  }

  Future<String?> _getPublicUrlSafe(Session session, String path) async {
    // Zero-latency optimization: Construct the S3 URL manually to bypass network/DNS checks
    // This resolves the 5-second hang caused by Failed host lookup.
    return 'https://chatwit-storage.s3.eu-north-1.amazonaws.com/$path';
  }
}
