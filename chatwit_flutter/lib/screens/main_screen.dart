import 'package:flutter/material.dart';
import 'package:chatwit_flutter/core/client.dart';
import 'package:chatwit_flutter/screens/login_screen.dart';
import 'package:chatwit_flutter/screens/registration_screen.dart';
import 'feed_screen.dart';

class Gateway extends StatefulWidget {
  const Gateway({super.key});

  @override
  State<Gateway> createState() => GatewayState();
}

class GatewayState extends State<Gateway> {
  @override
  void initState() {
    super.initState();
    client.auth.authInfoListenable.addListener(_onAuthStateChanged);
  }

  @override
  void dispose() {
    client.auth.authInfoListenable.removeListener(_onAuthStateChanged);
    super.dispose();
  }

  void _onAuthStateChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!client.auth.isAuthenticated) {
      return const LoginScreen();
    }

    return FutureBuilder<bool>(
      future: client.userRegistration.isRegistrationComplete(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text("Error: ${snapshot.error}")),
          );
        } else {
          final isRegistered = snapshot.data ?? false;

          if (isRegistered) {
            return const FeedScreen();
          } else {
            return const RegistrationScreen();
          }
        }
      },
    );
  }
}
