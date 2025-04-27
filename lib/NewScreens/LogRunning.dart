import 'package:flutter/material.dart';
import 'SaveWorkout.dart';

class LogRunning extends StatefulWidget {
  const LogRunning({Key? key}) : super(key: key);

  @override
  State<LogRunning> createState() => _LogRunningState();
}

class _LogRunningState extends State<LogRunning> {
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String _selectedDistance = '';
  String _selectedTime = '';

  final List<String> distances = ['1 km', '5 km', '10 km', '15 km'];
  final List<String> times = ['15 min', '30 min', '60 min', '90 min'];

  @override
  void dispose() {
    _distanceController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _selectDistance(String distance) {
    setState(() {
      _selectedDistance = distance;
      _distanceController.text = distance;
    });
  }

  void _selectTime(String time) {
    setState(() {
      _selectedTime = time;
      _timeController.text = time;
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
                                        'Log Running',
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

                          // Distance input
                          Text(
                            'Distance',
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
                                controller: _distanceController,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
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
                                  hintText: 'Enter distance in km',
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
                                  suffixText: 'km',
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

                          SizedBox(height: 15),

                          // Distance selection chips
                          Wrap(
                            spacing: 8,
                            children: distances
                                .map((distance) => _buildDistanceChip(distance))
                                .toList(),
                          ),

                          SizedBox(height: 30),

                          // Time input
                          Text(
                            'Time',
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
                                controller: _timeController,
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
                                  hintText: 'Enter time in minutes',
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

                          SizedBox(height: 15),

                          // Time selection chips
                          Wrap(
                            spacing: 8,
                            children: times
                                .map((time) => _buildTimeChip(time))
                                .toList(),
                          ),

                          SizedBox(height: 30),

                          // Image with person running
                          Center(
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 15,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/running.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
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

              // Save button
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

  Widget _buildDistanceChip(String distance) {
    bool isSelected = _selectedDistance == distance;

    return ChoiceChip(
      label: Text(
        distance,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: 'SF Pro Display',
        ),
      ),
      selected: isSelected,
      backgroundColor: Colors.white,
      selectedColor: Colors.black,
      side: BorderSide(color: Colors.grey[300]!),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      onSelected: (selected) {
        if (selected) {
          _selectDistance(distance);
        }
      },
    );
  }

  Widget _buildTimeChip(String time) {
    bool isSelected = _selectedTime == time;

    return ChoiceChip(
      label: Text(
        time,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: 'SF Pro Display',
        ),
      ),
      selected: isSelected,
      backgroundColor: Colors.white,
      selectedColor: Colors.black,
      side: BorderSide(color: Colors.grey[300]!),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      onSelected: (selected) {
        if (selected) {
          _selectTime(time);
        }
      },
    );
  }
}
