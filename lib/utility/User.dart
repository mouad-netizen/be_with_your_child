import 'package:flutter/material.dart';






class User{

  late String firstName;
  late String lastName;
  late String email;
  late String phoneNumber;
  late String password;
  late String? image;



  User({required this.firstName,required this.lastName,required this.email,required this.phoneNumber,required this.password,this.image});

  Map<String,dynamic> UserTomap(User user){
    return {
      'firstName':user.firstName,
      'lastName':user.lastName,
      'email':user.email,
      'phoneNumber':user.phoneNumber,
      'password':user.password,
      'image':user.image
    };

  }

  User fromMapToUser(Map<String,dynamic> user){
    return User(firstName: user['firstName'], lastName: user['lastName'], email: user['email'], phoneNumber:user['phoneNumber'] , password:user['password'],image: user['image'] );

  }


}