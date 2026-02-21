import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:focus_room/services/database.dart';
import 'package:focus_room/styles/text_design.dart';
import 'package:focus_room/models/room_model.dart';
import 'package:slide_countdown/slide_countdown.dart';

class ShowRoomDetails extends StatefulWidget {
    final RoomModel roomModel;
  const ShowRoomDetails({super.key,required this.roomModel});
  @override
  State<ShowRoomDetails> createState() => _ShowRoomDetailsState();
}

class _ShowRoomDetailsState extends State<ShowRoomDetails> {
  bool joined = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService().roomStream(widget.roomModel.id),
      builder: (context, snapshot) {
        if(snapshot.hasData){      
          final room=snapshot.data;   
          final remaining=room!.endTime.difference(DateTime.now());
          // ignore: deprecated_member_use
          return WillPopScope(
            onWillPop: () async{
              if(joined){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('You must leave the room to go back!'),
                    duration: Duration(seconds: 1),
                    )
                  );
                  return false;
              }
              return true;
            },
            child: Scaffold(
            extendBody: true,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.blue[900],
              title: Text('Room Details',
              style: textDesign.copyWith(
                fontSize: 20,
              ),
              ),
              iconTheme: IconThemeData(
                color: Colors.white
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person,
                    color: (room.memberCount<1)?Colors.red:Colors.green,),
                    Text(room.memberCount.toString(),
                    style: textDesign.copyWith(
                      fontSize: 18
                    ),),
                    SizedBox(width: 10,)
                  ],
                )
              ],
            ),
            body: SingleChildScrollView(             
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(30,10,30,10),
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(15, 10 , 15, 10),
                      decoration: BoxDecoration(             
                        color: Colors.blue[900],
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [ 
                          Text('Topic',
                          style: textDesign.copyWith(
                            fontSize: 18
                          ),),    
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            alignment:Alignment.center,
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                            decoration: BoxDecoration(
                              color: Colors.blue[700],
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                    BoxShadow(
                                      color: Colors.white,
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                    )
                                  ]
                              ),
                            child: Text(room.name,
                            style: textDesign.copyWith(
                              fontSize: 20
                            ),
                            ),
                          ),
                          
                          SizedBox(height:10,),
                          Text('Goal',
                          style: textDesign.copyWith(
                            fontSize: 18
                          ),), 
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            alignment:Alignment.center,
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                            decoration: BoxDecoration(
                              color: Colors.blue[700],
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                    BoxShadow(
                                      color: Colors.white,
                                      blurRadius: 5,
                                      spreadRadius: 2
                    
                                    )
                                  ]
                              ),
                            child: Text(room.topic,
                            style: textDesign.copyWith(
                              fontSize: 16
                            ),
                            ),
                          ),                                  
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20,10,20,10),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(             
                        color: Colors.blue[900],
                        borderRadius: BorderRadius.circular(15),
                        
                      ),
                      child: Column(
                        children: [
                          Text('Description',
                          style: textDesign.copyWith(
                            fontSize: 18
                          ),),
                          Container(     
                            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),                
                                alignment:Alignment.topCenter,
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                decoration: BoxDecoration(
                                  color: Colors.blue[700],
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white,
                                      blurRadius: 5,
                                      spreadRadius: 2                               
                                    ),
                                    
                                    
                                  ]
                                  ),
                                child: Text(room.description,
                                style: textDesign.copyWith(
                                  fontSize: 20
                                ),
                                ),
                              ),
                        ],
                      ),
                  ),
                  SizedBox(height: 10,),
                  Text('Session Time Remaining:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(height: 20,),
                  SlideCountdownSeparated(
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                    duration: remaining
                  ),
                  SizedBox(height: 30,),
                  InnerShadow(
                    shadows: [
                      Shadow(
                          color: Colors.black.withOpacity(0.6),
                        blurRadius: 8,
                        offset: Offset(0, 0),
                      )
                    ],
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color:joined?Colors.red: Colors.green,
                        

                      ),
                      child: TextButton(     
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                            
                          ),
                          onPressed: () async{
                            if(joined){
                            await DatabaseService().leaveRoom(room.id);
                            }
                            else{
                            await DatabaseService().joinRoom(room.id);
                            }
                            setState(() {
                              joined=!joined;
                            });
                          }, 
                          child:joined?Text('Leave',style: textDesign.copyWith(
                            fontSize: 24,
                          ),):
                          Text('Join',
                          style: textDesign.copyWith(
                            fontSize: 22,
                          ),)
                          ),
                    ),
                  ),
                  
                ],
              ),      
            ),
            // bottomNavigationBar: BottomAppBar(
            //   color: Colors.transparent,
            //   child: Container(                   
            //     margin: EdgeInsets.symmetric(horizontal: 90,vertical: 0),
            //         height: 50,
            //         width: 100,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(15),
            //           color: joined?Colors.redAccent:Colors.green,
            //         boxShadow: [
            //           BoxShadow(
            //             color: Colors.black,
            //             blurRadius: 3,
            //           )
            //         ]
            //         ),
            //         child: 
            //       ),
            // )
                 ),
          );
        }
        else{
          return const Center(child: CircularProgressIndicator());
        }
        
      }
    );
  }
}