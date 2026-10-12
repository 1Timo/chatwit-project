import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  final bool showAgreeButton;
  const TermsConditionsScreen({super.key, this.showAgreeButton = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Column(
        children: [
          const Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '''Standard Terms & Conditions for Chatwit Social App

1. Acceptance of Terms: By accessing or using Chatwit, you agree to be bound by these terms.
2. User Conduct: You are responsible for your content and interactions. No harassment, hate speech, or illegal activities.
3. Content Ownership: You retain ownership of your content, but grant Chatwit a license to host and share it.
4. Privacy: Your use is also governed by our Privacy Policy.
5. Termination: We reserve the right to suspend or terminate accounts that violate these terms.
6. Liability: Chatwit is provided "as is" without warranties.
... (Standard Clauses continue)''',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          if (showAgreeButton)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Agree and Continue'),
              ),
            ),
        ],
      ),
    );
  }
}
