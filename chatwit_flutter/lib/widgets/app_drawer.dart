import 'package:flutter/material.dart';
import 'package:chatwit_flutter/core/image_utils.dart';
import 'package:chatwit_flutter/screens/profile_screen.dart';
import 'package:chatwit_flutter/screens/bookmark_screen.dart';
import 'package:chatwit_flutter/screens/drafts_screen.dart';
import 'package:chatwit_flutter/screens/settings/settings_screen.dart';
import 'package:chatwit_flutter/screens/about_app_screen.dart';
import 'package:chatwit_flutter/core/client.dart';

import 'package:chatwit_flutter/screens/login_screen.dart';
import 'package:chatwit_flutter/screens/registration_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _navigateToProfile(BuildContext context) {
    final authInfo = authManager.authInfo;
    Navigator.pop(context); // Close drawer
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileScreen(
          userId: authInfo?.authUserId.toString() ?? '',
          userName: "My Profile",
        ),
      ),
    );
  }

  void _showAccountOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person_add_alt_1),
              title: const Text('Create an account'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegistrationScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.group_add),
              title: const Text('Add existing account'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authInfo = authManager.authInfo;

    return Drawer(
      child: Column(
        children: [
          // Drawer Header
          FutureBuilder<UserRegistration?>(
            future: client.userRegistration.getUserInfo(
              authInfo?.authUserId.toString() ?? '',
            ),
            builder: (context, snapshot) {
              final registration = snapshot.data;
              final profileImageUrl = registration?.profileImageUrl;

              return GestureDetector(
                onTap: () => _navigateToProfile(context),
                child: DrawerHeader(
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.fromLTRB(20, 16, 12, 18),
                  decoration: const BoxDecoration(
                    color: Color(0xFF374151),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ChatwitImage.avatar(
                            profileImageUrl,
                            radius: 30,
                            backgroundColor: Colors.white,
                          ),
                          IconButton(
                            tooltip: 'Account options',
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 40,
                              minHeight: 40,
                            ),
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                            onPressed: () => _showAccountOptions(context),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        registration == null
                            ? 'My Profile'
                            : '${registration.firstName} ${registration.surname}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (registration?.username.isNotEmpty ?? false)
                        Text(
                          '@${registration!.username}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),

          // Main Menu Items
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Profile'),
            onTap: () => _navigateToProfile(context),
          ),
          ListTile(
            leading: const Icon(Icons.bookmark_border),
            title: const Text('Bookmark'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BookmarkScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit_note_outlined),
            title: const Text('Drafts'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DraftsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutAppScreen()),
              );
            },
          ),

          const Spacer(),

          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.black),
            title: const Text('Logout', style: TextStyle(color: Colors.black)),
            onTap: () async {
              await authManager.signOutDevice();
              if (context.mounted) {
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil('/login', (route) => false);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.no_accounts, color: Colors.black),
            title: const Text(
              'Deactivate Account',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              // Implementation for deactivate account
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
