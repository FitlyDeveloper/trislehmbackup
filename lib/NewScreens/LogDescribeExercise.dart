import 'package:flutter/material.dart';
import 'SaveWorkout.dart';

class LogDescribeExercise extends StatefulWidget {
  const LogDescribeExercise({Key? key}) : super(key: key);

  @override
  State<LogDescribeExercise> createState() => _LogDescribeExerciseState();
}

class _LogDescribeExerciseState extends State<LogDescribeExercise> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  String _selectedExerciseType = '';
  final List<String> exerciseTypes = [
    'Strength',
    'Cardio',
    'Flexibility',
    'Balance',
    'Other'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _caloriesController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  void _selectExerciseType(String type) {
    setState(() {
      if (_selectedExerciseType == type) {
        _selectedExerciseType = '';
      } else {
        _selectedExerciseType = type;
      }
    });
  }

  void _navigateToSaveWorkout() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SaveWorkout(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background4.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Column(
                children: [
                  // AppBar
                  PreferredSize(
                    preferredSize: Size.fromHeight(kToolbarHeight),
                    child: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      flexibleSpace: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 29)
                                .copyWith(top: 16, bottom: 8.5),
                            child: Stack(
                              children: [
                                Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Custom Exercise',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'SF Pro Display',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  child: IconButton(
                                    icon: Icon(Icons.arrow_back,
                                        color: Colors.black, size: 24),
                                    onPressed: () => Navigator.pop(context),
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Divider line
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 29),
                    height: 0.5,
                    color: Color(0xFFBDBDBD),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 29),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30),

                          // Exercise name
                          Text(
                            'Exercise Name',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'SF Pro Display',
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.grey[300]!),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: TextField(
                                controller: _nameController,
                                cursorColor: Colors.black,
                                cursorWidth: 1.2,
                                textAlign: TextAlign.left,
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontFamily: 'SF Pro Display',
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Name your exercise',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'SF Pro Display',
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 15),
                                  isCollapsed: true,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 20),

                          // Exercise type
                          Text(
                            'Exercise Type',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'SF Pro Display',
                            ),
                          ),
                          SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            runSpacing: 10,
                            children: exerciseTypes.map((type) {
                              bool isSelected = _selectedExerciseType == type;
                              return ChoiceChip(
                                label: Text(
                                  type,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'SF Pro Display',
                                  ),
                                ),
                                selected: isSelected,
                                backgroundColor: Colors.white,
                                selectedColor: Colors.black,
                                side: BorderSide(color: Colors.grey[300]!),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                onSelected: (selected) {
                                  if (selected) {
                                    _selectExerciseType(type);
                                  }
                                },
                              );
                            }).toList(),
                          ),

                          SizedBox(height: 20),

                          // Duration
                          Text(
                            'Duration (minutes)',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'SF Pro Display',
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.grey[300]!),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: TextField(
                                controller: _durationController,
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.black,
                                cursorWidth: 1.2,
                                textAlign: TextAlign.left,
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontFamily: 'SF Pro Display',
                                ),
                                decoration: InputDecoration(
                                  hintText: 'How long did you exercise?',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'SF Pro Display',
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 15),
                                  isCollapsed: true,
                                  suffixText: 'min',
                                  suffixStyle: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'SF Pro Display',
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 20),

                          // Calories
                          Text(
                            'Calories Burned (estimated)',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'SF Pro Display',
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.grey[300]!),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: TextField(
                                controller: _caloriesController,
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.black,
                                cursorWidth: 1.2,
                                textAlign: TextAlign.left,
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontFamily: 'SF Pro Display',
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Estimate calories burned',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'SF Pro Display',
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 15),
                                  isCollapsed: true,
                                  suffixText: 'kcal',
                                  suffixStyle: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'SF Pro Display',
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 20),

                          // Description
                          Text(
                            'Description (Optional)',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'SF Pro Display',
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey[300]!),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: _descriptionController,
                              maxLines: 4,
                              cursorColor: Colors.black,
                              cursorWidth: 1.2,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontFamily: 'SF Pro Display',
                              ),
                              decoration: InputDecoration(
                                hintText: 'Add notes about your exercise',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'SF Pro Display',
                                ),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                contentPadding: EdgeInsets.all(15),
                              ),
                            ),
                          ),

                          SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // White box at bottom
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: MediaQuery.of(context).size.height * 0.148887,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.zero,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: Offset(0, -5),
                      ),
                    ],
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
                    onPressed: _navigateToSaveWorkout,
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'SF Pro Display',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
