import 'package:flutter/material.dart';

class HomeCard2 extends StatelessWidget {
  const HomeCard2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Activity Summary',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(height: 15),

          // Activity stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildActivityStat('Steps', '0', 'assets/images/steps.png'),
              _buildActivityStat(
                  'Distance', '0 km', 'assets/images/distance.png'),
              _buildActivityStat('Calories', '0', 'assets/images/energy.png'),
            ],
          ),

          SizedBox(height: 20),

          // Activity progress
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildActivityProgress(
                'Steps',
                0,
                10000,
                Color(0xFFD7C1FF),
              ),
              _buildActivityProgress(
                'Workout',
                0,
                60,
                Color(0xFFFFD8B1),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityStat(String label, String value, String iconPath) {
    return Column(
      children: [
        Image.asset(
          iconPath,
          width: 24,
          height: 24,
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            decoration: TextDecoration.none,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }

  Widget _buildActivityProgress(
    String label,
    int current,
    int target,
    Color color,
  ) {
    final progress = current / target;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            decoration: TextDecoration.none,
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: 140,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Color(0xFFEEEEEE),
          ),
          child: FractionallySizedBox(
            widthFactor: progress.clamp(0, 1),
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: color,
              ),
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          '$current / $target',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }
}
