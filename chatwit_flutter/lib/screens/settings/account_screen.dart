import 'package:flutter/material.dart';
import 'package:chatwit_flutter/screens/settings/user_profile_edit_screen.dart';
import 'package:chatwit_flutter/screens/settings/security_password_screen.dart';
import 'package:chatwit_flutter/core/client.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  Future<void> _deleteAccount(BuildContext context) async {
    try {
      final success = await client.userRegistration.deleteAccount();
      if (success) {
        await authManager.signOutDevice();
        if (context.mounted) {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil('/login', (route) => false);
        }
      }
    } catch (e) {
      debugPrint('Error deleting account: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete account: $e')),
        );
      }
    }
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to permanently delete your account? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              _deleteAccount(context);
            },
            child: const Text(
              'Yes, Delete',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('User Profile'),
            subtitle: const Text('Bio and profile details'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserProfileEditScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: const Text('Security & Password'),
            subtitle: const Text('Reset password and security settings'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SecurityPasswordScreen(),
                ),
              );
            },
          ),
          const Spacer(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text(
              'Delete Account',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () => _showDeleteConfirmation(context),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
