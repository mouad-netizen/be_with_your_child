
import 'package:flutter/material.dart';
import 'package:tpcities/utility/User.dart';

import '../database/db.dart';


class FormValidation extends StatefulWidget {
  const FormValidation({Key? key}) : super(key: key);

  @override
  State<FormValidation> createState() => _FormValidationState();

}

class _FormValidationState extends State<FormValidation> {


  List<Map<String,dynamic>> _allData =[];
  bool _isLoading = true;
  User? user;
  int? id;
  String? firstName;
  String? imagePathsend;


  void refreshData() async {
     users = await SqlDb.getAllUserData();
    setState(() {

      _isLoading =false;
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshData();
  }

  final _formfield =GlobalKey<FormState>();
  final emailControler= TextEditingController();
  final passwordControler= TextEditingController();
  bool passToggle =true;
  List<Map> users=[];
  Map<dynamic,dynamic> tempmap={};
  returnUsers()async{
    users =await SqlDb.getAllUserData();
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
                Image.asset('assets/profil.png',
                  width: 200,
                  height: 200,),
                SizedBox(height: 40,),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailControler,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email)
                  ),
                  validator: (value) {
                    if(value!.isEmpty ){
                      return "Enter Email";
                    }
                    bool emailValid = RegExp(r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$').hasMatch(value);


                    bool emailstate =false;


                    for (Map<dynamic, dynamic> map in users) {
                      for (String key in map.keys) {
                        if (map[key] == value) {
                          tempmap = map;
                          emailstate=true;

                          break; // Found the key, exit the loop
                        }

                      }

                    }
                    print('==========================email founded $emailstate');
                    if(!emailValid || !emailstate){
                      return "Please Enter  Valid Email";
                    }



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
                    bool passState =false;

                    for (Map<dynamic, dynamic> map in users) {
                      for (String key in map.keys) {
                        if (tempmap[key] == value) {
                          passState =true;
                          id=tempmap['id_user'];
                          firstName=tempmap['firstName'];
                          imagePathsend=tempmap['image'];
                          print('$imagePathsend');

                          break; // Found the key, exit the loop
                        }

                      }

                    }



                    if(value!.isEmpty)
                      return 'Enter Password';
                    else if(!passState)
                      return 'incorrect password';
                  },
                ),
                SizedBox(height: 50,),
                InkWell(
                  onTap: ()async{

                    if(!users.isNotEmpty)
                      await returnUsers();
                    if(_formfield.currentState!.validate()){

                      emailControler.clear();
                      passwordControler.clear();
                      Navigator.pushReplacementNamed(context, '/parentHome',arguments: {
                        'id':id,
                        'firstName':firstName,
                        'image':imagePathsend
                      });
                    }

                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Center(
                      child: Text('Log in',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 26),),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account ?',style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold,fontSize: 18)),
                    TextButton(onPressed:(){
                      Navigator.pushNamed(context, '/signin');
                    }, child: Text('Sign Up',style: TextStyle(fontSize: 16),))
                  ],
                )
              ],
            ),

          ),
        ),
      ),



    );
  }
}
