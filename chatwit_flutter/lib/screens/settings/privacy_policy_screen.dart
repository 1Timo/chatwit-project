import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(
          '''Standard Privacy Policy for Chatwit Social App

1. Data Collection: We collect information you provide (profile, posts) and usage data.
2. Data Usage: We use data to provide services, improve Chatwit, and for safety.
3. Data Sharing: We do not sell your data. We share only with service providers or when required by law.
4. Security: We use industry-standard measures to protect your information.
5. User Rights: You can access, edit, or delete your data through account settings.
6. Cookies: We use cookies to enhance your experience.
... (Standard Clauses continue)''',
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
