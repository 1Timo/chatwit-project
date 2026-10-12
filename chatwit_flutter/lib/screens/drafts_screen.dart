import 'package:flutter/material.dart';
import 'package:chatwit_flutter/core/draft_service.dart';
import 'package:chatwit_flutter/screens/create_post_screen.dart';

class DraftsScreen extends StatefulWidget {
  const DraftsScreen({super.key});

  @override
  State<DraftsScreen> createState() => _DraftsScreenState();
}

class _DraftsScreenState extends State<DraftsScreen> {
  List<DraftPost> _drafts = [];

  @override
  void initState() {
    super.initState();
    _loadDrafts();
  }

  void _loadDrafts() {
    setState(() {
      _drafts = DraftService.getDrafts();
    });
  }

  void _deleteDraft(String id) async {
    await DraftService.deleteDraft(id);
    _loadDrafts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Drafts',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: _drafts.isEmpty
          ? const Center(child: Text('No drafts saved.'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _drafts.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final draft = _drafts[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    draft.text.isEmpty ? "(No text)" : draft.text,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    "#${draft.category} • ${draft.createdAt.toString().substring(0, 16)}",
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (draft.imagePath != null || draft.videoPath != null)
                        Icon(
                          draft.videoPath != null
                              ? Icons.videocam
                              : Icons.image,
                          size: 20,
                          color: const Color(0xFF6B7280),
                        ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                        onPressed: () => _deleteDraft(draft.id!),
                      ),
                    ],
                  ),
                  onTap: () async {
                    final bool? posted = await Navigator.push<bool>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostScreen(draft: draft),
                      ),
                    );
                    if (posted == true) {
                      await DraftService.deleteDraft(draft.id!);
                      _loadDrafts();
                    }
                  },
                );
              },
            ),
    );
  }
}
