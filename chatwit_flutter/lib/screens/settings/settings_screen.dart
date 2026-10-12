import 'package:flutter/material.dart';
import 'package:chatwit_flutter/screens/settings/account_screen.dart';
import 'package:chatwit_flutter/screens/settings/support_screen.dart';
import 'package:chatwit_flutter/screens/settings/feedback_screen.dart';
import 'package:chatwit_flutter/screens/settings/about_screen.dart';
import 'package:chatwit_flutter/screens/settings/terms_conditions_screen.dart';
import 'package:chatwit_flutter/screens/settings/privacy_policy_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.account_circle_outlined),
            title: const Text('Account'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccountScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Support'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SupportScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.feedback_outlined),
            title: const Text('Feedback'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FeedbackScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              );
            },
          ),
          const Spacer(),
          const Divider(),
          ListTile(
            title: const Text('Terms & Condition'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TermsConditionsScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Privacy Policy'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicyScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
