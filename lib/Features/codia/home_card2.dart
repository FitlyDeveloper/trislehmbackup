import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The back side of the flip card showing activity information
class HomeCard2 extends StatefulWidget {
  const HomeCard2({Key? key}) : super(key: key);

  @override
  _HomeCard2State createState() => _HomeCard2State();
}

class _HomeCard2State extends State<HomeCard2> {
  int _steps = 0;
  double _distance = 0.0;
  int _activeMinutes = 0;

  @override
  void initState() {
    super.initState();
    _loadActivityData();
  }

  /// Load activity data from SharedPreferences
  Future<void> _loadActivityData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      setState(() {
        _steps = prefs.getInt('steps') ?? 0;
        _distance = prefs.getDouble('distance') ?? 0.0;
        _activeMinutes = prefs.getInt('active_minutes') ?? 0;
      });
    } catch (e) {
      print('Error loading activity data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and flip indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Activity',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Icon(
                Icons.swap_horiz,
                color: Colors.grey,
                size: 24,
              ),
            ],
          ),

          SizedBox(height: 20),

          // Steps row
          Row(
            children: [
              Image.asset(
                'assets/images/steps.png',
                width: 30,
                height: 30,
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Steps',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    '$_steps',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 20),

          // Distance row
          Row(
            children: [
              Image.asset(
                'assets/images/distance.png',
                width: 30,
                height: 30,
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Distance',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    '${_distance.toStringAsFixed(1)} km',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 20),

          // Active minutes row
          Row(
            children: [
              Image.asset(
                'assets/images/clock.png',
                width: 30,
                height: 30,
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Active Minutes',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    '$_activeMinutes min',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
