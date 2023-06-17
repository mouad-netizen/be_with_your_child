import 'package:flutter/material.dart';
import 'package:tpcities/database/db.dart';
import 'package:badges/badges.dart';
import 'package:intl/intl.dart';



class ParentMessage extends StatefulWidget {
  const ParentMessage({Key? key}) : super(key: key);

  @override
  State<ParentMessage> createState() => _ParentMessageState();
}

class _ParentMessageState extends State<ParentMessage> {




  List<Map<String,dynamic>> messages = [];


  TextEditingController _textEditingController = TextEditingController();

  void _refreshData() async{
    messages = await SqlDb.getAllMessages();
    messages =messages.reversed.toList();
    setState(() {
      _allMessages =messages;
    });

  }
  List<Map<String,dynamic>> _allMessages=[];
  void _sendMessage(String message) {
    SqlDb.createMessage('parent', message);
    _refreshData();
    _textEditingController.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.png"), // Replace with your own image asset path
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: _allMessages.length,
                itemBuilder: (BuildContext context, int index) {
                  final isMe = _allMessages[index]['author'] == 'parent';
                  final messageTime = DateTime.parse(_allMessages[index]['createdAt']);
                  final formattedTime = DateFormat('h:mm a').format(messageTime);// Format the message time
                  return Container(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(


                      decoration: BoxDecoration(

                        color: isMe ? Colors.blue[200] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _allMessages[index]['content'],
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(width: 8), // Add spacing between the message and the time
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,

                            children: [

                              Text(
                                formattedTime,
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(width: 10,),
                              Icon(
                                Icons.check,
                                size: 16,
                              ), // Add the checked icon// Add spacing between the time and the checked icon

                            ],
                          ) // Add the formatted message time
                        ],
                      ),
                    ),
                  );
                },
              ),

            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      _sendMessage(_textEditingController.text);

                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
