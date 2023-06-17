
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tpcities/utility/User.dart';
import 'package:path/path.dart' as path;

import '../database/db.dart';




class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  SqlDb sqlDb =SqlDb();
  User? user ;
  final _formfield =GlobalKey<FormState>();
  final emailControler= TextEditingController();
  final firstNameControler= TextEditingController();
  final lastNameControler= TextEditingController();
  final phoneNumberControler= TextEditingController();
  final passwordControler= TextEditingController();
  final passwordControler1= TextEditingController();
  String? image;
  bool passToggle =true;
  bool passToggle1 =true;


  Future<dynamic> _captureImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.camera);

    if (pickedImage != null) {
      Directory directory = await getApplicationDocumentsDirectory();
      String imagePath = path.join(directory.path, path.basename(pickedImage.path));
      image =imagePath;
      File imageFile = File(pickedImage.path);
      print("$image");
      await imageFile.copy(imagePath);

      return imagePath;
    }
    return null;
  }
  Future<dynamic> _uploadimage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      Directory directory = await getApplicationDocumentsDirectory();
      String imagePath = path.join(directory.path, path.basename(pickedImage.path));
      image =imagePath;
      File imageFile = File(pickedImage.path);

      await imageFile.copy(imagePath);

      return imagePath;
    }
    return null;
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 60),
          child: Form(
            key: _formfield,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: firstNameControler,
                  decoration: InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.account_circle_outlined)
                  ),
                  validator: (value){
                    if(value!.isEmpty)
                      return 'required field';
                  },

                ),
                SizedBox(height: 20,),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: lastNameControler,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.account_circle_outlined),

                  ),
                  validator: (value){
                    if(value!.isEmpty)
                      return 'required field';
                  },

                ),
                SizedBox(height: 20,),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailControler,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email)
                  ),
                  validator: (value){
                    if(value!.isEmpty ){
                      return "Enter Email";
                    }
                    bool emailValid = RegExp(r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$').hasMatch(value);
                    if(!emailValid ){
                      return "Please Enter  Valid Email";
                    }

                  },
                ),
                SizedBox(height: 20,), TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: phoneNumberControler,
                  decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone)
                  ),
                  validator: (value){
                    if(value!.isEmpty)
                      return 'required field';
                  },

                ),
                SizedBox(height: 20,),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller:passwordControler ,
                  obscureText: passToggle,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    suffix: InkWell(
                      onTap: (){
                        setState(() {

                          passToggle =!passToggle;
                        });
                      },
                      child: Icon(passToggle ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                  validator: (value){
                    if(value!.isEmpty)
                      return 'Enter Password';
                    else if(value.length < 6)
                      return 'password requird more than 6 characters';
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller:passwordControler1 ,
                  obscureText: passToggle1,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    suffix: InkWell(
                      onTap: (){
                        setState(() {
                          passToggle1 =!passToggle1;
                        });
                      },
                      child: Icon(passToggle1 ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                  validator: (value){
                    if(value!.isEmpty)
                      return 'Enter Password';
                    else if(value.length < 6)
                      return 'password requird more than 6 characters';
                    else if(!(value.compareTo(passwordControler.text)==0))
                      return "passwords are not compatible";
                  },
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    IconButton(onPressed: ()async{
                      await _captureImage();
                    }, icon: Icon(Icons.camera)),IconButton(onPressed: ()async{
                      await _uploadimage();
                    }, icon: Icon(Icons.photo_camera_back_outlined)),
                  ],
                ),
                SizedBox(height: 10,),
                InkWell(
                  onTap: ()async{
                    if(_formfield.currentState!.validate()){
                      User user= User(firstName: firstNameControler.text, lastName: lastNameControler.text, email: emailControler.text, phoneNumber: phoneNumberControler.text, password: passwordControler.text,image:image );
                      await SqlDb.createDatauser(user);
                      print("data has inserted successfuly ===========================>");
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Center(
                      child: Text('Submit',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 26),),
                    ),
                  ),
                ),

              ],
            ),

          ),
        ),
      ),
    );
  }
}
