import 'package:hive/hive.dart';

class DraftPost {
  final String? id;
  final String text;
  final String? imagePath;
  final String? videoPath;
  final String category;
  final String? location;
  final String audience;
  final List<String> sharedWithUserIds;
  final DateTime createdAt;

  DraftPost({
    this.id,
    required this.text,
    this.imagePath,
    this.videoPath,
    required this.category,
    this.location,
    this.audience = 'everyone',
    this.sharedWithUserIds = const [],
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id ?? createdAt.millisecondsSinceEpoch.toString(),
      'text': text,
      'imagePath': imagePath,
      'videoPath': videoPath,
      'category': category,
      'location': location,
      'audience': audience,
      'sharedWithUserIds': sharedWithUserIds,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory DraftPost.fromMap(Map<String, dynamic> map) {
    return DraftPost(
      id: map['id'],
      text: map['text'] ?? '',
      imagePath: map['imagePath'],
      videoPath: map['videoPath'],
      category: map['category'] ?? 'General',
      location: map['location'],
      audience: map['audience'] ?? 'everyone',
      sharedWithUserIds: List<String>.from(
        map['sharedWithUserIds'] ?? const <String>[],
      ),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}

class DraftService {
  static const String _boxName = 'post_drafts';

  static Future<void> saveDraft(DraftPost draft) async {
    final box = Hive.box(_boxName);
    await box.put(
      draft.id ?? draft.createdAt.millisecondsSinceEpoch.toString(),
      draft.toMap(),
    );
  }

  static List<DraftPost> getDrafts() {
    final box = Hive.box(_boxName);
    return box.values
        .map((e) => DraftPost.fromMap(Map<String, dynamic>.from(e)))
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  static Future<void> deleteDraft(String id) async {
    final box = Hive.box(_boxName);
    await box.delete(id);
  }
}
