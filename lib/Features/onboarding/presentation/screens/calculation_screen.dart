import 'package:flutter/material.dart';
import 'package:fitness_app/Features/onboarding/presentation/screens/comfort_screen.dart';

class CalculationScreen extends StatelessWidget {
  final bool isMetric;
  final int initialWeight;
  final int dreamWeight;
  final bool isGaining;
  final double speedValue;
  final String gender;
  final int heightInCm;
  final DateTime birthDate;
  final String gymGoal;
  late final int calculatedCalories;
  late final int tdee;
  late final int dailyDeficit;
  late final int proteinGrams;
  late final int fatGrams;
  late final int carbGrams;

  CalculationScreen({
    super.key,
    required this.isMetric,
    required this.initialWeight,
    required this.dreamWeight,
    required this.isGaining,
    required this.speedValue,
    required this.gender,
    required this.heightInCm,
    required this.birthDate,
    required this.gymGoal,
  }) {
    // Print debug values
    print('Initial values:');
    print('Weight: $initialWeight ${isMetric ? 'kg' : 'lbs'}');
    print('Height: $heightInCm ${isMetric ? 'cm' : 'inches'}');
    print('Speed: $speedValue ${isMetric ? 'kg' : 'lbs'}/week');

    // Convert measurements if using imperial units
    final weightInKg =
        isMetric ? initialWeight : (initialWeight * 0.453592).round();
    final dreamWeightInKg =
        isMetric ? dreamWeight : (dreamWeight * 0.453592).round();
    final heightConverted = heightInCm;

    print('Converted values:');
    print('Weight in kg: $weightInKg');
    print('Height in cm: $heightConverted');

    // Calculate TDEE first
    tdee = calculateTDEE(
      gender: gender,
      weightKg: weightInKg,
      heightCm: heightConverted,
      birthDate: birthDate,
    );

    print('TDEE calculated: $tdee');

    // Calculate daily deficit/surplus based on unit system
    if (isMetric) {
      // Metric: Use 7700 kcal per kg
      dailyDeficit =
          (speedValue * 7700 / 7).round(); // Weekly kg to daily calories
    } else {
      // Imperial: Use 3500 kcal per lb, no need to convert speed since it's already in lbs
      dailyDeficit =
          (speedValue * 3500 / 7).round(); // Weekly lbs to daily calories
    }

    print('Daily deficit calculated: $dailyDeficit');

    // Calculate final target calories
    calculatedCalories = isGaining ? tdee + dailyDeficit : tdee - dailyDeficit;

    // Update the macro calculations to consider gym goals
    final proteinMultiplier = getProteinMultiplier(gymGoal);
    final proteinCalories = calculatedCalories * proteinMultiplier;
    final remainingCalories = calculatedCalories - proteinCalories;
    final fatCalories = remainingCalories * 0.357;
    final carbCalories = remainingCalories * 0.643;

    // Convert calories to grams
    proteinGrams = (proteinCalories / 4).round();
    fatGrams = (fatCalories / 9).round();
    carbGrams = (carbCalories / 4).round();

    print('Macronutrient targets:');
    print('Protein: ${proteinGrams}g (${proteinCalories.round()} kcal)');
    print('Fat: ${fatGrams}g (${fatCalories.round()} kcal)');
    print('Carbs: ${carbGrams}g (${carbCalories.round()} kcal)');
    print('Total calories: $calculatedCalories');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            value: 11 / 13,
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
                      const Text(
                        'Your Personalized\nNutrition Plan',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                          height: 1.21,
                          fontFamily: '.SF Pro Display',
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Just a glimpse of what\'s coming.',
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

          // Nutrition Plan Card
          Positioned(
            top: MediaQuery.of(context).size.height * 0.37,
            left: 32,
            right: 32,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 15,
              ),
              height: MediaQuery.of(context).size.height * 0.276,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 6),
                    blurRadius: 20,
                    spreadRadius: -4,
                    color: Colors.black.withOpacity(0.08),
                  ),
                ],
              ),
              child: OverflowBox(
                maxHeight: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    // Circle gauge image
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/images/circle.png',
                          height: MediaQuery.of(context).size.height * 0.154,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '$calculatedCalories',
                              style: const TextStyle(
                                fontSize: 16.2,
                                fontWeight: FontWeight.w600,
                                fontFamily: '.SF Pro Display',
                              ),
                            ),
                            const Text(
                              'Remaining',
                              style: TextStyle(
                                fontSize: 11.1,
                                color: Colors.black,
                                fontFamily: '.SF Pro Display',
                              ),
                            ),
                          ],
                        ),
                        // Left text position (Deficit)
                        Positioned(
                          left: 0,
                          child: Transform.translate(
                            offset: const Offset(-70, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '-$tdee', // Show maintenance/TDEE as deficit since no food eaten yet
                                  style: const TextStyle(
                                    fontSize: 15.1,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: '.SF Pro Display',
                                  ),
                                ),
                                const Text(
                                  'Deficit',
                                  style: TextStyle(
                                    fontSize: 10.3,
                                    color: Colors.black,
                                    fontFamily: '.SF Pro Display',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Right text position (Burned)
                        Positioned(
                          right: 0,
                          child: Transform.translate(
                            offset: const Offset(68, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  '0', // Start at 0 burned calories
                                  style: TextStyle(
                                    fontSize: 15.1,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: '.SF Pro Display',
                                  ),
                                ),
                                Text(
                                  'Burned',
                                  style: TextStyle(
                                    fontSize: 10.3,
                                    color: Colors.black,
                                    fontFamily: '.SF Pro Display',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 0),
                    // Macro bars row
                    Transform.translate(
                      offset: const Offset(0, -15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Text labels above
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Transform.translate(
                                offset: const Offset(-8, 20),
                                child: Container(
                                  width: 70,
                                  child: const Text(
                                    'Protein',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: '.SF Pro Display',
                                    ),
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: const Offset(0, 20),
                                child: Container(
                                  width: 70,
                                  child: const Text(
                                    'Fat',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: '.SF Pro Display',
                                    ),
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: const Offset(8, 20),
                                child: Container(
                                  width: 70,
                                  child: const Text(
                                    'Carbs',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: '.SF Pro Display',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Bars row with numbers
                          SizedBox(
                            height: 81,
                            child: OverflowBox(
                              maxHeight: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: 70,
                                        height: 70,
                                        child: Image.asset(
                                          'assets/images/protein.png',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Transform.translate(
                                        offset: const Offset(0, -20),
                                        child: Text(
                                          '0 / $proteinGrams g',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: '.SF Pro Display',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: 70,
                                        height: 70,
                                        child: Image.asset(
                                          'assets/images/fat.png',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Transform.translate(
                                        offset: const Offset(0, -20),
                                        child: Text(
                                          '0 / $fatGrams g',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: '.SF Pro Display',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: 70,
                                        height: 70,
                                        child: Image.asset(
                                          'assets/images/carbs.png',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Transform.translate(
                                        offset: const Offset(0, -20),
                                        child: Text(
                                          '0 / $carbGrams g',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: '.SF Pro Display',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // White box at bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: MediaQuery.of(context).size.height * 0.153887,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.zero,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 6),
                    blurRadius: 20,
                    spreadRadius: -4,
                    color: Colors.black.withOpacity(0.08),
                  ),
                ],
              ),
            ),
          ),

          // Next button
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
                      builder: (context) => ComfortScreen(
                        isMetric: isMetric,
                        initialWeight: initialWeight,
                        dreamWeight: dreamWeight,
                        isGaining: isGaining,
                        speedValue: speedValue,
                        isMaintaining: speedValue == 0,
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
        ],
      ),
    );
  }

  Widget _buildMacroBar(String label, int current, int total, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontFamily: '.SF Pro Display',
              ),
            ),
            Text(
              '$current/$total g',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                fontFamily: '.SF Pro Display',
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(2),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: current / total,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Helper method for the numbers
  Widget _buildNumber(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            fontFamily: '.SF Pro Display',
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
            fontFamily: '.SF Pro Display',
          ),
        ),
      ],
    );
  }

  int calculateTDEE({
    required String gender,
    required int weightKg,
    required int heightCm,
    required DateTime birthDate,
  }) {
    // Calculate age
    final age = DateTime.now().difference(birthDate).inDays ~/ 365;

    // Calculate BMR using Mifflin-St Jeor Equation
    double bmr;
    if (gender == 'Male') {
      bmr = (10 * weightKg) + (6.25 * heightCm) - (5 * age) + 5;
    } else {
      bmr = (10 * weightKg) + (6.25 * heightCm) - (5 * age) - 161;
    }

    // Apply activity multiplier (1.2 for sedentary - little/no exercise)
    final tdee = bmr * 1.2;

    return tdee.round();
  }

  // Helper method to determine protein needs based on both gym and weight goals
  double getProteinMultiplier(String gymGoal) {
    // Base multiplier depending on weight goal
    double baseMultiplier = isGaining ? 0.30 : 0.25;

    // If maintaining or no specific goal, return base multiplier
    if (gymGoal == 'Maintain') {
      return baseMultiplier;
    }

    // Adjust based on gym goal
    switch (gymGoal) {
      case 'Build Muscle':
        return baseMultiplier + 0.10;
      case 'Gain Strength':
        return baseMultiplier + 0.08;
      case 'Boost Endurance':
        return baseMultiplier + 0.05;
      default:
        return baseMultiplier;
    }
  }
}

class CalorieArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height * 2);
    final paint = Paint()
      ..color = Colors.grey[200]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;

    canvas.drawArc(
      rect,
      -3.14,
      3.14,
      false,
      paint,
    );

    final progressPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;

    canvas.drawArc(
      rect,
      -3.14,
      2.1,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
