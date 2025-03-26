import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'dart:math' as math;
import 'package:fitness_app/Features/onboarding/presentation/screens/speed_screen.dart';

class WeightGoalCopyScreen extends StatefulWidget {
  final bool isMetric;
  final int initialWeight;
  final String? selectedGoal;
  final String gender;
  final int heightInCm;
  final DateTime birthDate;
  final String? gymGoal;

  const WeightGoalCopyScreen({
    super.key,
    required this.isMetric,
    required this.initialWeight,
    required this.selectedGoal,
    required this.gender,
    required this.heightInCm,
    required this.birthDate,
    this.gymGoal,
  });

  @override
  State<WeightGoalCopyScreen> createState() => _WeightGoalCopyScreenState();
}

class _WeightGoalCopyScreenState extends State<WeightGoalCopyScreen> {
  late int selectedWeight;
  late int initialWeight;
  late double maxWeight;
  late double minWeight;
  ValueNotifier<int> _currentWeight = ValueNotifier<int>(0);
  double _dragAccumulator = 0;
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    initialWeight = widget.initialWeight;
    selectedWeight = initialWeight;
    _currentWeight.value = selectedWeight;

    if (widget.isMetric) {
      minWeight = initialWeight * 0.5;
      maxWeight = initialWeight * 1.5;
    } else {
      minWeight = initialWeight * 0.5;
      maxWeight = initialWeight * 1.5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: _handleKeyPress,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Background gradient
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

            // Header content
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back,
                              color: Colors.black, size: 24),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: const LinearProgressIndicator(
                              value: 10 / 13,
                              minHeight: 2,
                              backgroundColor: Color(0xFFE5E5EA),
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 21.2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.selectedGoal == 'Gain weight'
                              ? 'Set a target weight gain'
                              : 'Set a target weight loss',
                          style: const TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w700,
                            height: 1.21,
                            fontFamily: '.SF Pro Display',
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "We'll help you get there - slow and steady.",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            height: 1.3,
                            fontFamily: '.SF Pro Display',
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // White box at bottom
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

            // Continue button
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpeedScreen(
                          isMetric: widget.isMetric,
                          initialWeight: widget.initialWeight,
                          isGaining: widget.selectedGoal == 'Gain weight',
                          dreamWeight: _currentWeight.value,
                          gender: widget.gender,
                          heightInCm: widget.heightInCm,
                          birthDate: widget.birthDate,
                          gymGoal: widget.gymGoal,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      fontFamily: '.SF Pro Display',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            // Weight slider visualization in middle
            Positioned(
              top: MediaQuery.of(context).size.height * 0.4,
              left: 24,
              right: 24,
              child: Column(
                children: [
                  // Current weight text
                  ValueListenableBuilder<int>(
                    valueListenable: _currentWeight,
                    builder: (context, value, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$value',
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                              fontFamily: '.SF Pro Display',
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.isMetric ? 'kg' : 'lb',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              fontFamily: '.SF Pro Display',
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 40),

                  // Slider
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 2,
                      activeTrackColor: Colors.black,
                      inactiveTrackColor: Colors.grey[300],
                      thumbColor: Colors.white,
                      overlayColor: Colors.black.withOpacity(0.05),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 17,
                      ),
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 12,
                        elevation: 4,
                      ),
                    ),
                    child: Slider(
                      value: _currentWeight.value.toDouble(),
                      min: minWeight,
                      max: maxWeight,
                      onChanged: (value) {
                        setState(() {
                          _currentWeight.value = value.round();
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Weight range text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${minWeight.round()} ${widget.isMetric ? 'kg' : 'lb'}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[600],
                          fontFamily: '.SF Pro Display',
                        ),
                      ),
                      Text(
                        '${maxWeight.round()} ${widget.isMetric ? 'kg' : 'lb'}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[600],
                          fontFamily: '.SF Pro Display',
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

  void _handleKeyPress(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        setState(() {
          if (_currentWeight.value > minWeight) {
            _currentWeight.value--;
          }
        });
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        setState(() {
          if (_currentWeight.value < maxWeight) {
            _currentWeight.value++;
          }
        });
      }
    }
  }

  Widget _buildOption(String text, {required int index}) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : const Color(0xFFF0F1F3),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Center(
          child: Text(
            text,
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
