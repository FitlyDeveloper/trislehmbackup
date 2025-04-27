import 'package:flutter/material.dart';
import '../Features/codia/codia_page.dart';
import '../NewScreens/LogRunning.dart';

class HomeScreen extends StatefulWidget {
  // ... (existing code)
}

class _HomeScreenState extends State<HomeScreen> {
  // ... (existing code)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ... (existing code)
      body: SafeArea(
        // ... (existing code)
        child: Column(
          // ... (existing code)
          children: [
            // ... (existing code)

            // Add this new section before the end of the column children
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LogRunning()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.directions_run,
                            color: Colors.black,
                            size: 28,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Track Running',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'SF Pro Display',
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Log your running workouts',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  fontFamily: 'SF Pro Display',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey[400],
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // ... (existing code)
          ],
        ),
      ),
      // ... (existing code)
    );
  }
}
