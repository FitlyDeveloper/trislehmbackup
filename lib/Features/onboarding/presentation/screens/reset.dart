import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fitness_app/Features/onboarding/presentation/screens/signin.dart';
import 'package:fitness_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/Features/onboarding/presentation/screens/sign_screen.dart';

class ResetScreen extends StatefulWidget {
  final String email;

  const ResetScreen({
    super.key,
    required this.email,
  });

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final AuthService _auth = AuthServiceFactory.getAuthService();
  bool _isVerified = false;
  bool _isChecking = false;
  bool _showErrorMessage = false;
  Timer? _timer;
  int _resendCountdown = 30;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    // Store the email in the mock service when the screen loads
    _initializeUser();
    // Start countdown immediately
    _resendCountdown = 30;
    _startResendCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _startResendCountdown() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendCountdown > 0) {
          _resendCountdown--;
        } else {
          _countdownTimer?.cancel();
        }
      });
    });
  }

  void _resetResendCountdown() {
    setState(() {
      _resendCountdown = 30;
    });
    _countdownTimer?.cancel();
    _startResendCountdown();
  }

  Future<void> _resendResetEmail() async {
    try {
      setState(() {
        _isChecking = true;
      });

      // Send password reset email
      await _auth.sendPasswordResetEmail(widget.email);
      _resetResendCountdown();

      // No SnackBar notification to avoid unwanted popups
    } catch (e) {
      print('Failed to resend: ${e.toString()}');
      // No SnackBar notification to avoid unwanted popups
    } finally {
      if (mounted) {
        setState(() {
          _isChecking = false;
        });
      }
    }
  }

  Future<void> _initializeUser() async {
    // If we're using the mock service, make sure the email is registered
    if (AuthServiceFactory.useMockAuth) {
      final mockAuth = _auth as MockAuthService;
      await mockAuth.ensureUserExists(widget.email);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check if we're using the mock service
    final bool isTestMode = AuthServiceFactory.useMockAuth;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background gradient (matching sign_screen)
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.grey[100]!.withOpacity(0.9),
                ],
              ),
            ),
          ),

          // Test mode indicator
          if (isTestMode)
            Positioned(
              top: 40,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'TEST MODE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with back button and progress bar
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 24),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back,
                            color: Colors.black, size: 24),
                        onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInScreen(),
                          ),
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: const LinearProgressIndicator(
                          value: 2 / 13,
                          minHeight: 2,
                          backgroundColor: Color(0xFFE5E5EA),
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),

                // Title and subtitle
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Password Reset',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          fontFamily: '.SF Pro Display',
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Check your email & reset your password.',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          fontFamily: '.SF Pro Display',
                          color: Color(0xFF666666),
                        ),
                      ),
                    ],
                  ),
                ),

                // Expanded area with verification card
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Center(
                      child: Transform.translate(
                        offset: const Offset(0, -60),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          margin: const EdgeInsets.symmetric(vertical: 24),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                spreadRadius: 0,
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "We've sent an email to:",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: '.SF Pro Display',
                                  color: Color(0xFF666666),
                                ),
                              ),
                              const SizedBox(height: 5.4),
                              Text(
                                widget.email,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: '.SF Pro Display',
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Image.asset(
                                'assets/images/email.png',
                                width: 70,
                                height: 70,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                "Didn't get the email?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: '.SF Pro Display',
                                  color: Color(0xFF666666),
                                ),
                              ),
                              const SizedBox(height: 5.4),
                              TextButton(
                                onPressed: _resendCountdown == 0
                                    ? _resendResetEmail
                                    : null,
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.zero),
                                  minimumSize:
                                      MaterialStateProperty.all(Size.zero),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  splashFactory: NoSplash.splashFactory,
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  foregroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                          (states) {
                                    return _resendCountdown == 0
                                        ? Colors.black
                                        : const Color(0xFF666666);
                                  }),
                                ),
                                child: _isChecking
                                    ? const SizedBox(
                                        height: 15,
                                        width: 15,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.black,
                                        ),
                                      )
                                    : Text(
                                        _resendCountdown > 0
                                            ? "Resend in ${_resendCountdown}s"
                                            : "Resend",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: '.SF Pro Display',
                                          color: _resendCountdown == 0
                                              ? Colors.black
                                              : const Color(0xFF666666),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Error message - positioned below the card
          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).size.height * 0.25 - 40,
            child: Visibility(
              visible: _showErrorMessage,
              child: const Center(
                child: Text(
                  'Please check your inbox for the password reset link.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFFF6565),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: '.SF Pro Display',
                  ),
                ),
              ),
            ),
          ),

          // White box at bottom - OUTSIDE of SafeArea
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: MediaQuery.of(context).size.height * 0.148887,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),

          // Next button - OUTSIDE of SafeArea
          Positioned(
            left: 24,
            right: 24,
            bottom: MediaQuery.of(context).size.height * 0.06,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.0689,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(28),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    fontFamily: '.SF Pro Display',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
