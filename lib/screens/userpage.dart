import 'package:flutter/material.dart';







class Userpage extends StatelessWidget {
  const Userpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 50,
              color: Colors.purple,
              child:Row(
                children: [
                  TextButton(onPressed: (){}, child: Icon(Icons.account_circle)),
                ],
              ),
            )
          ],
        ),
      ),


    );
  }
}

