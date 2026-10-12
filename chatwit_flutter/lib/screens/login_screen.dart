import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:chatwit_flutter/core/client.dart';
import 'package:chatwit_flutter/core/google_auth_config.dart';
import 'package:chatwit_flutter/screens/settings/terms_conditions_screen.dart';
import 'package:chatwit_flutter/screens/settings/privacy_policy_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final EmailAuthController _controller;
  bool _agreedToTerms = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();

    // Ensure the auth provider is linked to the client
    client.authKeyProvider = authManager;

    _controller = EmailAuthController(
      client: client,
      startScreen: EmailFlowScreen.login,
      onAuthenticated: () {
        // AuthGate handles navigation via authInfoListenable.
      },
      onError: (error) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      },
    );

    _controller.addListener(_handleControllerChange);

    // Add listeners to controllers to update the UI (button state) when text changes
    _controller.emailController.addListener(_handleControllerChange);
    _controller.passwordController.addListener(_handleControllerChange);
  }

  void _handleControllerChange() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleControllerChange);
    _controller.dispose();
    super.dispose();
  }

  void _navigateToTerms() async {
    final agreed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const TermsConditionsScreen(showAgreeButton: true),
      ),
    );
    if (agreed == true) {
      setState(() {
        _agreedToTerms = true;
      });
    }
  }

  void _navigateToPrivacy() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PrivacyPolicyScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Chatwit",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: -1,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Happening now",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Join Chatwit today",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),

                    if (googleSignInConfigurationError == null)
                      Stack(
                        children: [
                          GoogleSignInWidget(
                            client: client,
                            onAuthenticated: () {},
                            onError: (error) {
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error: $error')),
                              );
                            },
                          ),
                          if (!_agreedToTerms)
                            Positioned.fill(
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Please agree to terms to continue',
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      )
                    else
                      Text(
                        googleSignInConfigurationError!,
                        style: const TextStyle(color: Colors.red),
                      ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey[200])),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            "or",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey[200])),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // --- EMAIL SIGN IN (Strictly Enforced) ---
                    _buildCustomLoginForm(),

                    const SizedBox(height: 40),

                    Center(
                      child: Column(
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                            ),
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Terms & Conditions section
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[100]!)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                          value: _agreedToTerms,
                          activeColor: Theme.of(context).colorScheme.primary,
                          onChanged: (value) {
                            setState(() {
                              _agreedToTerms = value ?? false;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: 'By continuing, you agree to our ',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              height: 1.4,
                            ),
                            children: [
                              TextSpan(
                                text: 'Terms of Service',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _navigateToTerms,
                              ),
                              const TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _navigateToPrivacy,
                              ),
                              const TextSpan(text: ', including Cookie Use.'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Sign in with email",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _controller.emailController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.mail_outline),
            hintText: "Email",
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[200]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[200]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _controller.passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
            hintText: "Password",
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[200]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[200]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () =>
                _controller.navigateTo(EmailFlowScreen.requestPasswordReset),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 0),
            ),
            child: const Text(
              "Forgot password?",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed:
                (_controller.emailController.text.isNotEmpty &&
                    _controller.passwordController.text.isNotEmpty &&
                    !_controller.isLoading)
                ? () {
                    if (!_agreedToTerms) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please agree to terms to continue'),
                        ),
                      );
                      return;
                    }
                    _controller.login();
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 0,
            ),
            child: _controller.isLoading
                ? const CircularProgressIndicator()
                : const Text(
                    "Sign in",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
          ),
        ),
      ],
    );
  }
}
