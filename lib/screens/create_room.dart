import 'package:flutter/material.dart';
import 'package:focus_room/services/database.dart';
import 'package:focus_room/styles/text_design.dart';
import 'package:focus_room/styles/textinput_decoration.dart';

class CreateRoom extends StatefulWidget {
  const CreateRoom({super.key});

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {

  final _formKey=GlobalKey<FormState>();
  String name='';
  String topic='';
  String description='';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.blue[700],
        // appBar: AppBar(
        //   title: Text('Create New Room',
        //   style: textDesign.copyWith(fontSize: 24,),),
        //   centerTitle: true,
        //   backgroundColor: Colors.blue[900],
        // ),
        body: SingleChildScrollView(         
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 50),
            child: Form(   
              key: _formKey,  
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Text('Create New Room',
                    style: textDesign.copyWith(fontSize: 30,),
                    ),
                  SizedBox(height: 30,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Room Name',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                         color: Colors.grey[500]
                      )
                    ),
                    validator:(value) => value!.isEmpty?"Enter the Room Name!":null,
                    onChanged: (value) {
                      name=value;
                    },
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    validator: (value) => value!.isEmpty?'Enter the Topic!':null,
                    onChanged:(value) {
                      topic=value;
                    },
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Topic',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey
                      )
                    ),                                     
                  ),
                  SizedBox(height: 30,),
                  SizedBox(                 
                    child: TextFormField(
                      validator: (value) => value!.isEmpty?'Enter the Description!':null,
                      onChanged:(value) {
                      description=value;
                    },   
                      decoration: textInputDecoration.copyWith(
                        hintText: 'Description',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey
                        )
                      ),  
                      keyboardType: TextInputType.multiline,
                      maxLines: 10,
                      minLines: 4,
                      textAlignVertical: TextAlignVertical.top,       
                    ),
                  ),
                  SizedBox(height: 50,),
                 TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10)
                    )
                  ),
                  onPressed: ()async{
                    if(_formKey.currentState!.validate()){
                       Navigator.pop(context);
                    //to create a room in firebase collection.
                    await DatabaseService(uid: 'uid').createRoom('id','name', 'topic', 'description');
                    // print(room)
                    }
                   
                  }, 
                  child:Text('Create',
                  style: textDesign.copyWith(
                    fontSize: 30,
                  ),
                  ),
                   ),
                ],
              ),
              
            ),
          ),
        ),
      ),
    );
  }
}