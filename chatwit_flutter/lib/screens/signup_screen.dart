import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:chatwit_flutter/core/client.dart';
import 'package:chatwit_flutter/screens/settings/terms_conditions_screen.dart';
import 'package:chatwit_flutter/screens/settings/privacy_policy_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final EmailAuthController _controller;
  bool _agreedToTerms = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _controller = EmailAuthController(
      client: client,
      startScreen: EmailFlowScreen.startRegistration,
      onAuthenticated: () {
        // AuthGate handles navigation via authInfoListenable.
      },
      onError: (error) {
        if (!mounted) return;
        _handleSignUpError(error);
      },
    );

    _controller.addListener(_handleControllerChange);
    _controller.emailController.addListener(_handleControllerChange);
    _controller.passwordController.addListener(_handleControllerChange);
    _controller.verificationCodeController.addListener(_handleControllerChange);
  }

  void _handleSignUpError(Object error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error.toString()),
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Restart',
          textColor: Colors.white,
          onPressed: () {
            _controller.navigateTo(EmailFlowScreen.startRegistration);
          },
        ),
      ),
    );
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (_controller.canNavigateBack) {
              _controller.navigateBack();
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text(
          "Chatwit",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
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
                    Text(
                      _getTitle(),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 40),

                    _buildCurrentStepForm(),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            if (_controller.currentScreen == EmailFlowScreen.startRegistration)
              _buildTermsSection(),
          ],
        ),
      ),
    );
  }

  String _getTitle() {
    return switch (_controller.currentScreen) {
      EmailFlowScreen.startRegistration => "Create your account",
      EmailFlowScreen.verifyRegistration => "Verify your email",
      EmailFlowScreen.completeRegistration => "Set your password",
      _ => "Sign up",
    };
  }

  Widget _buildCurrentStepForm() {
    return switch (_controller.currentScreen) {
      EmailFlowScreen.startRegistration => _buildEmailStep(),
      EmailFlowScreen.verifyRegistration => _buildVerifyStep(),
      EmailFlowScreen.completeRegistration => _buildPasswordStep(),
      _ => const SizedBox.shrink(),
    };
  }

  Widget _buildEmailStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Step 1: Enter your email",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        TextField(
          controller: _controller.emailController,
          keyboardType: TextInputType.emailAddress,
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
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed:
                (_controller.emailController.text.isNotEmpty &&
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
                    _controller.startRegistration();
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
                    "Next",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildVerifyStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Step 2: Enter code sent to ${_controller.emailController.text}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        TextField(
          controller: _controller.verificationCodeController,
          keyboardType: TextInputType.text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
          decoration: InputDecoration(
            hintText: "Enter Code",
            hintStyle: const TextStyle(
              color: Colors.grey,
              letterSpacing: 0,
              fontSize: 16,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[200]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[200]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed:
                (_controller.verificationCodeController.text
                        .trim()
                        .isNotEmpty &&
                    !_controller.isLoading)
                ? () => _controller.verifyRegistrationCode()
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
                    "Verify",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: TextButton(
            onPressed: _controller.isLoading
                ? null
                : () => _controller.startRegistration(),
            child: Text(
              "Resend code",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Step 3: Create a password",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        const Text(
          "Password must be at least 8 characters long and include an uppercase letter, a lowercase letter, a number, and a special character.",
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
        const SizedBox(height: 24),
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
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed:
                (_controller.passwordController.text.isNotEmpty &&
                    !_controller.isLoading)
                ? () => _controller.finishRegistration()
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
                    "Complete",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsSection() {
    return Container(
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
    );
  }
}
