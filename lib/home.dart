import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tpcities/database/db.dart';


import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tpcities/utility/User.dart';






class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Map<String,dynamic>> _allData =[];
  Map<String,dynamic> userdata={};
  bool _isLoading = true;
  String? image;
  User? _user;




  void refreshData() async {
    final data = await SqlDb.getAllData();
    userdata= ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    setState(() {
      _allData = data;
      _isLoading =false;


        });

  }

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    refreshData();


  }


  Future<void> _addData ()async{
    int id = await SqlDb.createData(textcontroller.text, desccontroller.text,image);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: Colors.blue, content: Text('data added')));
    print('the id added is =========================>$id');
    refreshData();

  }

  Future<void> _updateData(int id) async {
    await SqlDb.updateData(id, textcontroller.text, desccontroller.text,image);
    refreshData();
  }

  void _deleteData(int id) async{
    await SqlDb.deleteData(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: Colors.redAccent, content: Text('data deleted')));
    refreshData();
  }

  void _deleteDatabase() async{
    await SqlDb.deletDatabase();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: Colors.redAccent, content: Text('database deleted',textAlign: TextAlign.center,)));
    refreshData();
  }
  late DateTime dateTime ;
  final textcontroller = TextEditingController();
  final desccontroller = TextEditingController();


  void showBottomSheet(int? id ) async{
    if(id != null){
      final existingData = _allData.firstWhere((element) => element['id'] == id);
      textcontroller.text=existingData['title'];
      desccontroller.text=existingData['desc'];
      image=existingData['imagePath'];
    }



    showModalBottomSheet(

        context: context,
        builder: (_)=>Container(
          padding: EdgeInsets.only(
              top: 30,
              left: 15,
              right: 15,
              bottom: (MediaQuery.of(context).viewInsets.bottom + 50)
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: textcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Title'
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: desccontroller,
                  maxLines: 4,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'descreption'
                  ),
                ),
                SizedBox(height: 10,),
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
                SizedBox(height: 20,),

                Center(
                  child: ElevatedButton(
                    onPressed: (){
                      if(id ==null)
                        _addData();
                      else
                        _updateData(id);
                      textcontroller.text ='';
                      desccontroller.text ='';
                      image=null;
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(18),
                      child: Text(id == null ? 'add ' : 'update ',style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                      ),),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        elevation: 5,
        isScrollControlled: true

    );
  }


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
      backgroundColor: Color(0xFFECEAF4),
      appBar: AppBar(
        title: Row(

          children: [
            userdata['firstName']==null ? Icon(Icons.account_circle):CircleAvatar(
              backgroundImage:FileImage(File(userdata['image'])),radius: 20,
            ),
            SizedBox(width: 5,),
            Text('${userdata['firstName']}')
          ],
        ),
      actions: [

        IconButton(onPressed: () async{
          Navigator.pushReplacementNamed(context, '/');

        }, icon: Icon(Icons.logout),),
      ],
      ),
      body: _isLoading ? Center(child: CircularProgressIndicator(),):
      ListView.builder(itemCount : _allData.length,itemBuilder: (context,index) =>Card(
          margin: EdgeInsets.all(15),
          child: Container(
            child: Column(
              children: [
                Text(_allData[index]['title'],style: TextStyle(fontSize: 20),),

                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:Container(

                      child: _allData[index]['imagePath']==null ? Image.asset('assets/rabat.jpg',fit: BoxFit.cover,width: 300,height:200 ,):Image.file(File(_allData[index]['imagePath']),fit:BoxFit.cover,width: 300,height:200),
                    )
                  ),
                ),
                ListTile(

                  subtitle: Text(_allData[index]['desc']),

                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: ()=>showBottomSheet(_allData[index]['id'])
                      ,
                      icon: Icon(Icons.edit,
                        color: Colors.grey,),
                    ),

                    IconButton(onPressed: (){
                      _deleteData(_allData[index]['id']);
                    },icon: Icon(Icons.delete,color: Colors.grey,),)

                  ],
                )
              ],
            ),
          )


      )


      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>showBottomSheet(null),
        child: Icon(Icons.add),
      ),
    );
  }
}
