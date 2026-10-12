import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(const RegistrationApp());

class RegistrationApp extends StatelessWidget {
  const RegistrationApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Profile Setup · Lab 6',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF087F72)),
      scaffoldBackgroundColor: const Color(0xFFF4F7F6),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF7F9F8),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 17,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFDEE6E3)),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color(0xFF087F72),
      ),
    ),
    home: const RegistrationScreen(),
  );
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _confirmKey = GlobalKey<FormFieldState<String>>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmation = TextEditingController();
  String _role = 'Student';
  bool _hidePassword = true;
  bool _hideConfirmation = true;
  bool _submitted = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirmation.dispose();
    super.dispose();
  }

  String? _required(String? value, String label) =>
      value == null || value.trim().isEmpty ? '$label is required.' : null;

  void _register() {
    FocusScope.of(context).unfocus();
    setState(() => _submitted = true);
    if (!_formKey.currentState!.validate()) return;
    // Local assignment demo: print profile data without exposing passwords.
    if (kDebugMode) {
      debugPrint(
        'Registration: ${jsonEncode({'fullName': _name.text.trim(), 'email': _email.text.trim(), 'role': _role, 'acceptedTerms': true, 'password': '[redacted]'})}',
      );
    }
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'Registration successful! Welcome, ${_name.text.trim()}.',
          ),
          duration: const Duration(seconds: 5),
          showCloseIcon: true,
        ),
      );
  }

  InputDecoration _decoration(String label, String hint, IconData icon) =>
      InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, size: 21),
        errorMaxLines: 2,
      );

  Widget _toggle(bool hidden, VoidCallback onPressed) => IconButton(
    tooltip: hidden ? 'Show password' : 'Hide password',
    onPressed: onPressed,
    icon: Icon(
      hidden ? Icons.visibility_outlined : Icons.visibility_off_outlined,
      size: 21,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 26),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.person_add_alt_1_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'NARXOZ / LAB 06',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.7,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),
                  const Text(
                    'Make it yours.',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Create your account and set up your profile.',
                    style: TextStyle(fontSize: 15, color: Color(0xFF687B78)),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFE1E9E6)),
                    ),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: _submitted
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'YOUR DETAILS',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.8,
                              color: Color(0xFF687B78),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            key: const Key('fullName'),
                            controller: _name,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.next,
                            autofillHints: const [AutofillHints.name],
                            decoration: _decoration(
                              'Full name',
                              'Your full name',
                              Icons.person_outline,
                            ),
                            validator: (value) => _required(value, 'Full name'),
                          ),
                          const SizedBox(height: 18),
                          TextFormField(
                            key: const Key('email'),
                            controller: _email,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            autocorrect: false,
                            autofillHints: const [AutofillHints.email],
                            decoration: _decoration(
                              'Email address',
                              'name@narxoz.kz',
                              Icons.alternate_email,
                            ),
                            validator: (value) {
                              final required = _required(value, 'Email');
                              if (required != null) return required;
                              if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$')
                                  .hasMatch(value!.trim())) {
                                return 'Enter a valid email, e.g. name@narxoz.kz.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 18),
                          TextFormField(
                            key: const Key('password'),
                            controller: _password,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: _hidePassword,
                            enableSuggestions: false,
                            autocorrect: false,
                            textInputAction: TextInputAction.next,
                            decoration:
                                _decoration(
                                  'Password',
                                  'At least 6 characters',
                                  Icons.lock_outline,
                                ).copyWith(
                                  suffixIcon: _toggle(
                                    _hidePassword,
                                    () => setState(
                                      () => _hidePassword = !_hidePassword,
                                    ),
                                  ),
                                ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required.';
                              }
                              if (value.length < 6) {
                                return 'Use at least 6 characters.';
                              }
                              return null;
                            },
                            onChanged: (_) {
                              // Revalidate confirmation even when only the original password changes.
                              if (_confirmation.text.isNotEmpty || _submitted) {
                                _confirmKey.currentState?.validate();
                              }
                            },
                          ),
                          const SizedBox(height: 18),
                          TextFormField(
                            key: _confirmKey,
                            controller: _confirmation,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: _hideConfirmation,
                            enableSuggestions: false,
                            autocorrect: false,
                            textInputAction: TextInputAction.done,
                            decoration:
                                _decoration(
                                  'Confirm password',
                                  'Re-enter your password',
                                  Icons.lock_reset,
                                ).copyWith(
                                  suffixIcon: _toggle(
                                    _hideConfirmation,
                                    () => setState(
                                      () => _hideConfirmation =
                                          !_hideConfirmation,
                                    ),
                                  ),
                                ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password.';
                              }
                              if (value != _password.text) {
                                return 'Passwords must match exactly.';
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) => _register(),
                          ),
                          const SizedBox(height: 24),
                          DropdownButtonFormField<String>(
                            key: const Key('role'),
                            initialValue: _role,
                            decoration: _decoration(
                              'I am a',
                              '',
                              Icons.badge_outlined,
                            ),
                            items: ['Student', 'Teacher', 'Developer']
                                .map(
                                  (role) => DropdownMenuItem(
                                    value: role,
                                    child: Text(role),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) =>
                                setState(() => _role = value!),
                          ),
                          const SizedBox(height: 16),
                          FormField<bool>(
                            initialValue: false,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) => value == true ? null : 'Accept the Terms and Conditions to continue.',
                            builder: (field) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Material(
                                  color: Colors.transparent,
                                  child: CheckboxListTile(
                                    key: const Key('terms'),
                                    value: field.value ?? false,
                                    onChanged: (value) =>
                                        field.didChange(value ?? false),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                    title: const Text(
                                      'I accept the Terms and Conditions',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ),
                                if (field.hasError)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 12,
                                      bottom: 10,
                                    ),
                                    child: Text(
                                      field.errorText!,
                                      style: TextStyle(
                                        color: theme.colorScheme.error,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          FilledButton(
                            key: const Key('register'),
                            onPressed: _register,
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 17),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Create account',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(Icons.arrow_forward_rounded, size: 19),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'USER REGISTRATION & PROFILE SETUP',
                      style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 1.3,
                        color: Color(0xFF7B8C87),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
