import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';
import 'package:fitness_app/core/widgets/responsive_scaffold.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  static const int totalSteps = 7;
  static const int currentStep = 1;
  String? selectedGender;

  double get progress => currentStep / totalSteps;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: [], // This hides status bar and navigation bar
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      backgroundColor: Colors.white,
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (event) {
          if (event is RawKeyDownEvent) {
            // Add keyboard handling like in I screen
          }
        },
        child: Stack(
          children: [
            // Box 4 (main white background with gradient) - FIRST in stack
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
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
            ),

            // Box 1 (main content)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(height: 12),
                    const LinearProgressIndicator(
                      value: 1 / 7,
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'How do you identify?',
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        height: 1.21,
                        fontFamily: '.SF Pro Display',
                        letterSpacing: -0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This helps us personalize your plan',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        height: 1.3,
                        fontFamily: '.SF Pro Display',
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    _buildGenderOption('Male'),
                    const SizedBox(height: 12),
                    _buildGenderOption('Female'),
                    const SizedBox(height: 12),
                    _buildGenderOption('Other'),
                    const Spacer(),
                  ],
                ),
              ),
            ),

            // Box 5 (white box at bottom)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 1351.0 * 0.148887,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ),

            // Box 3 (black button)
            Positioned(
              left: 24,
              right: 24,
              bottom: 1351.0 * 0.0374,
              child: Container(
                width: double.infinity,
                height: 1351.0 * 0.0689, // Same height as Box 3 (93.08 pixels)
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: TextButton(
                  onPressed: selectedGender != null
                      ? () {
                          // Navigate to next question
                        }
                      : null,
                  child: const Text(
                    'Next',
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
      ),
    );
  }

  Widget _buildGenderOption(String gender) {
    final isSelected = selectedGender == gender;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = gender;
        });
      },
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.grey[100],
          borderRadius: BorderRadius.circular(28),
        ),
        child: Center(
          child: Text(
            gender,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.black,
              fontFamily: '.SF Pro Display',
            ),
          ),
        ),
      ),
    );
  }
}
