import 'package:flutter/material.dart';



class Message{

  String content;
  String author;

  Message({required this.content,required this.author});



  Map<String ,dynamic> fromMessageTomap(Message message){
    return {
      'message':message.content,
      'author': message.author
    };
  }

  Message mapTomessage(Map<String,dynamic> map){
    return Message(content: map['message'], author: map['author']);
  }










}