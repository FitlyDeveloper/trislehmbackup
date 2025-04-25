import 'package:flutter/material.dart';

class CoachScreen extends StatefulWidget {
  const CoachScreen({Key? key}) : super(key: key);

  @override
  _CoachScreenState createState() => _CoachScreenState();
}

class _CoachScreenState extends State<CoachScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Coach'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Text(
          'Coach Screen',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
