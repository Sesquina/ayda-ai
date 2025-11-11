import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../common/widgets/ayda_primary_button.dart';
import '../data/auth_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isRegisterMode = false;
  bool _isSubmitting = false;
  String? _errorMessage;
  late final AuthRepository _authRepository;

  @override
  void initState() {
    super.initState();
    _authRepository = AuthRepository();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) {
      return;
    }

    setState(() {
      _errorMessage = null;
      _isSubmitting = true;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      if (_isRegisterMode) {
        await _authRepository.registerWithEmail(email: email, password: password);
      } else {
        await _authRepository.signInWithEmail(email: email, password: password);
      }
      if (!mounted) return;
      // AuthGate listens to FirebaseAuth state changes and will route the user
      // to the upload flow automatically once authenticated.
    } on FirebaseAuthException catch (error) {
      setState(() {
        _errorMessage = _mapAuthError(error);
      });
    } catch (error) {
      setState(() {
        _errorMessage = 'Something went wrong. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  void _toggleMode() {
    setState(() {
      _isRegisterMode = !_isRegisterMode;
      _errorMessage = null;
    });
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter your email address';
    }
    final email = value.trim();
    if (!email.contains('@')) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter your password';
    }
    if (value.trim().length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleText = _isRegisterMode ? 'Create your account' : 'Welcome back';
    final submitLabel = _isRegisterMode ? 'Sign up with email' : 'Sign in with email';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayda AI'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titleText,
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Use your caregiver email to access the Ayda workspace.',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.mail_outline),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: const [AutofillHints.email],
                        validator: _validateEmail,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock_outline),
                        ),
                        obscureText: true,
                        autofillHints: const [AutofillHints.password],
                        validator: _validatePassword,
                      ),
                    ],
                  ),
                ),
                if (_errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                AydaPrimaryButton(
                  label: submitLabel,
                  icon: Icons.mail_outline,
                  onPressed: _submit,
                  isLoading: _isSubmitting,
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: _isSubmitting ? null : _toggleMode,
                  child: Text(
                    _isRegisterMode
                        ? 'Already have an account? Sign in'
                        : 'Need an account? Create one',
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Google Sign-In will be available after OAuth credentials are configured in Firebase.',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _mapAuthError(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'user-disabled':
        return 'This account has been disabled. Contact support for help.';
      case 'user-not-found':
        return 'No account found for that email. Try signing up first.';
      case 'wrong-password':
        return 'Incorrect password. Try again or reset your password.';
      case 'email-already-in-use':
        return 'An account already exists for that email.';
      case 'weak-password':
        return 'Choose a stronger password (at least 6 characters).';
      default:
        return exception.message ?? 'Unable to authenticate. Please try again.';
    }
  }
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Ayda AI'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Caregiver insights at your fingertips',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Text(
              'Sign in to explore the caregiver assistant experience. ',
              style: theme.textTheme.bodyMedium,
            ),
            const Spacer(),
            AydaPrimaryButton(
              label: 'Continue with Email',
              icon: Icons.mail_outline,
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  UploadScreen.routeName,
                );
              },
            ),
            const SizedBox(height: 12),
            AydaPrimaryButton(
              label: 'Continue with Google',
              icon: Icons.account_circle_outlined,
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  UploadScreen.routeName,
                );
              },
            ),
            const SizedBox(height: 32),
            Text(
              'Authentication is mocked for now. Hook up Firebase Auth to enable real sign-in.',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
