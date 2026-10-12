import 'dart:async';

import 'package:chatwit_flutter/core/client.dart';
import 'package:chatwit_flutter/core/follow_users.dart';
import 'package:chatwit_flutter/core/image_utils.dart';
import 'package:flutter/material.dart';

class FollowerPostShareSheet extends StatefulWidget {
  const FollowerPostShareSheet({super.key});

  @override
  State<FollowerPostShareSheet> createState() => _FollowerPostShareSheetState();
}

class _FollowerPostShareSheetState extends State<FollowerPostShareSheet> {
  static const _loadTimeout = Duration(seconds: 20);

  List<UserRegistration> _followers = [];
  final Set<String> _selectedIds = {};
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadFollowers();
  }

  Future<void> _loadFollowers() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final followers = await _fetchFollowers().timeout(_loadTimeout);
      if (!mounted) return;
      setState(() {
        _followers = followers;
        _isLoading = false;
      });
    } on TimeoutException {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = 'Loading followers timed out. Check your connection.';
      });
    } catch (error) {
      debugPrint('Could not load followers for post sharing: $error');
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = 'Could not load followers. Please try again.';
      });
    }
  }

  Future<List<UserRegistration>> _fetchFollowers() async {
    final follows = await client.follow.getFollowers();
    return resolveFollowUsers(follows, areFollowers: true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.75,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Share with followers',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (!_isLoading && _errorMessage == null)
                    Text('${_selectedIds.length} selected'),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(child: _buildBody()),
            if (!_isLoading && _errorMessage == null && _followers.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _selectedIds.isEmpty
                        ? null
                        : () {
                            Navigator.pop(
                              context,
                              _followers
                                  .where(
                                    (follower) => _selectedIds.contains(
                                      follower.authUserId.toString(),
                                    ),
                                  )
                                  .toList(),
                            );
                          },
                    child: Text('Send to ${_selectedIds.length}'),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12),
            Text('Loading followers...'),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_errorMessage!, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: _loadFollowers,
                child: const Text('Try again'),
              ),
            ],
          ),
        ),
      );
    }

    if (_followers.isEmpty) {
      return const Center(child: Text('You do not have any followers yet.'));
    }

    return ListView.builder(
      itemCount: _followers.length,
      itemBuilder: (context, index) {
        final follower = _followers[index];
        final followerId = follower.authUserId.toString();
        final displayName = '${follower.firstName} ${follower.surname}'.trim();
        final isSelected = _selectedIds.contains(followerId);
        return CheckboxListTile(
          value: isSelected,
          secondary: ChatwitImage.avatar(follower.profileImageUrl, radius: 20),
          title: Text(
            displayName.isEmpty ? '@${follower.username}' : displayName,
          ),
          subtitle: Text('@${follower.username}'),
          onChanged: (selected) {
            setState(() {
              if (selected ?? false) {
                _selectedIds.add(followerId);
              } else {
                _selectedIds.remove(followerId);
              }
            });
          },
        );
      },
    );
  }
}
