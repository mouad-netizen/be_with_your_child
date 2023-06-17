import 'package:flutter/material.dart';





class choose extends StatelessWidget {
  const choose({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 60,),
          Text('BE WITH YOUR CHILD',style: TextStyle(letterSpacing: 2,fontSize: 24,fontFamily: 'tilt'),),
          Text('ANYWHERE',style: TextStyle(letterSpacing: 2,fontSize: 24,fontFamily: 'tilt'),),
          SizedBox(height: 20,),
          Image.asset('assets/logo.jpg'),
          SizedBox(height: 40,),
          TextButton(

            style: TextButton.styleFrom(
              fixedSize: Size(250, 60),
              backgroundColor: Colors.amber, // Set the background color
            //  padding: EdgeInsets.symmetric(vertical: 20,horizontal: 100), // Set the padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Set the border radius
              ),
              // You can add more styles as per your requirements
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/childHome');
            },
            child: Text(
              'Child',
              style: TextStyle(
                color: Colors.white, // Set the text color
                  fontSize: 24,
                  letterSpacing: 2/// Set the text size
              ),
            ),
          ),
          SizedBox(height: 40,),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.deepOrange[400],
              fixedSize: Size(250, 60),// Set the background color
              //padding: EdgeInsets.symmetric(vertical: 20,horizontal: 100), // Set the padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Set the border radius
              ),
              // You can add more styles as per your requirements
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: Text(
              'Parent',
              style: TextStyle(
                color: Colors.white, // Set the text color
                fontSize: 24,
                letterSpacing: 2// Set the text size
              ),
            ),
          ),


        ],
      ),
    );
  }
}
