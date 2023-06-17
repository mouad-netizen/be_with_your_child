import 'package:flutter/material.dart';





class DailyChild extends StatefulWidget {
  const DailyChild({Key? key}) : super(key: key);

  @override
  State<DailyChild> createState() => _DailyChildState();
}

class _DailyChildState extends State<DailyChild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/profil.png'),
            ),
            SizedBox(height: 20),
            Text(
              'John Doe Father',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Age: 48',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
