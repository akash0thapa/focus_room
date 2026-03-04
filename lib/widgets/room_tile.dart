import 'package:flutter/material.dart';
import 'package:focus_room/models/room_model.dart';
import 'package:focus_room/screens/show_room_details.dart';
import 'package:focus_room/services/database.dart';
import 'package:slide_countdown/slide_countdown.dart';

class RoomTile extends StatelessWidget {
  final RoomModel roomModel;
  const RoomTile({
    super.key,
    required this.roomModel,
    });

  @override
  Widget build(BuildContext context) {
    dynamic remaining=roomModel.endTime.difference(DateTime.now());
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black, width: 0.5),
        gradient: LinearGradient(
          colors:  [
            Colors.white70,
            Colors.blue[700]!,
             Colors.blue[900]!,            
             ]),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(150),
            blurRadius: 5,
             spreadRadius: 1,
            offset: Offset(0, 2),
            blurStyle: BlurStyle.inner,
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            shape:RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(15),              
            ),
            tileColor: Color(0xFF003E8F),
            title: Text(roomModel.topic,
            style:TextStyle(
            color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20)
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(roomModel.goal,      
                style:TextStyle(
                  color: Colors.black,
                  letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
                fontSize: 16
                )               
                ),
                Row(
                  children: [
                    Icon(Icons.people,
                    color:(roomModel.memberCount<1)?Colors.red:Colors.green,                   
                    ),
                    SizedBox(width: 5,),
                    Text("${roomModel.memberCount} Participant(s)",
                    style:TextStyle(
                    color: Colors.black,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1
                    ),
                    ),
                  ],
                )
              ],
            ),
            trailing: Container(
              height: 100,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: SlideCountdownSeparated(
                slideAnimationCurve: Curves.easeOutQuint,
                separatorStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blue[700],                  
                ),             
                duration: remaining,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
                onDone: () async{
                  // await Future.delayed(const Duration(seconds: 2));
                  await DatabaseService().deleteRoom(roomModel.id);
                },

              ),
            ),
            onTap: () {
             Navigator.push(context, MaterialPageRoute(builder: (context){
              return ShowRoomDetails(roomModel:roomModel,);
             }));
            },
          ),
        ],
      ),
    );
  }
}