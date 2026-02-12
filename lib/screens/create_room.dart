import 'package:flutter/material.dart';
import 'package:focus_room/styles/text_design.dart';
import 'package:focus_room/styles/textinput_decoration.dart';

class CreateRoom extends StatefulWidget {
  const CreateRoom({super.key});

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        title: Text('Create New Room',
        style: textDesign.copyWith(fontSize: 24,),),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.only(
      bottom: MediaQuery.of(context).viewInsets.bottom,
    ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 50),
          child: Form(     
            child: Column(
              children: [
                TextFormField(
                  decoration: textInputDecoration,
                  
                ),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: textInputDecoration,
                  
                ),
                SizedBox(height: 20,),
                TextFormField(
                  
                )
              ],
            ),
            
          ),
        ),
      ),
    );
  }
}