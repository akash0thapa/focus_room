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
  double timerValue=15;
  int memberCount=0;
  // late DateTime endTime;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.transparent,
      body:  SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 0,horizontal: 50),
            child: Form(   
              key: _formKey,           
              child: Column(
                children: [
                  Container(
                    height: 5,
                    margin:EdgeInsets.fromLTRB(100, 5, 100, 5) ,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)
      
                      ),
                  ),
                    Text('Create New Room',
                    style: textDesign.copyWith(fontSize: 30,),
                    ),
                  SizedBox(height: 20,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Room Name',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                         color: Colors.grey[500]
                      )
                    ),
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'Enter Room Name';
                      }
                      else if(value.length>20){
                        return 'Name should be 20 characters only';
                      }
                      else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        name=value.toString();
                      });
                    },
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    validator: (value) => value!.isEmpty?'Enter the Topic!':null,
                    onChanged:(value) {
                      setState(() {
                        topic=value.toString();
                      });
                    },
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Topic',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey
                      )
                    ),                                     
                  ),
                  SizedBox(height: 20,),
                  SizedBox(                      
                    child: TextFormField(
                      validator: (value) => value!.isEmpty?'Enter the Description!':null,
                      onChanged:(value) {
                        setState(() {
                          description=value.toString();
                        });
                    },  
                      decoration: textInputDecoration.copyWith(
                        hintText: 'Description',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey
                        )
                      ),  
                      maxLines: 4,
                      minLines: 4,
                      maxLength: 100,                      
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text('Session Time',style: textDesign.copyWith(
                    fontSize: 20
                  ),),
                  Slider(
                    value: timerValue, 
                    onChanged: (value){
                      setState(() {
                        timerValue=value;
                        // endTime=Duration(minutes: timerValue.toInt()).
                        // DateTime.now().add(Duration(minutes: timerValue.toInt()));
                      });
                    },
                    divisions: 7,
                    min: 15,
                    max: 120,
                    label: '${timerValue.toInt()}min',
                    
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey,
                    ),
                  TextButton(              
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    elevation: 5,
                    shadowColor: Colors.black,
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),                                       
                    )
                  ),
                   onPressed: ()async{
                     if(_formKey.currentState!.validate()){
                        Navigator.pop(context);
                     //to create a room in firebase collection.
                     await DatabaseService().createRoom(name,topic,description,memberCount);
                     // print(room)
                     }
                    
                   }, 
                   child:Text('Create',
                   style: textDesign.copyWith(
                     fontSize: 24,
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