import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Chatwit'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF374151),
              child: Icon(Icons.chat_bubble, size: 50, color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              'Chatwit',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text('Version 1.0.0'),
            SizedBox(height: 24),
            Text(
              'Chatwit is a modern social platform designed to bring people together. Share your thoughts, connect with friends, and explore a world of conversations.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text(
              'Developed with ❤️ by the Chatwit Team.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 48),
            Text(
              '© 2026 Chatwit Inc.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
