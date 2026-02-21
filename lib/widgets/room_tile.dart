import 'package:flutter/material.dart';
import 'package:focus_room/models/room_model.dart';
import 'package:focus_room/screens/show_room_details.dart';
import 'package:focus_room/services/database.dart';
import 'package:focus_room/styles/text_design.dart';
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
      padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
      child: ListTile(
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(15)
        ),
        tileColor: Color(0xFF003E8F),
        title: Text(roomModel.name,
        style: textDesign.copyWith(fontSize: 24)
        ),
        subtitle: Text(roomModel.topic,      
        style: textDesign.copyWith(fontSize: 16)
        ),
        trailing: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.symmetric(vertical: 15),
              child: SlideCountdownSeparated(
                separatorStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blue[700],
                  
                ),             
                duration: remaining,
                onDone: () async{
                  await DatabaseService().deleteRoom(roomModel.id);
                },
              ),
            ),
            Icon(Icons.person,
            size: 35,
            color:(roomModel.memberCount<1)?Colors.red:Colors.green,
             shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 10
                    )
                  ]
                ),
                Text(roomModel.memberCount.toString(),
                style: textDesign.copyWith(
                  fontSize: 25
                ))
          ],
        ),
        onTap: () {
         Navigator.push(context, MaterialPageRoute(builder: (context){
          return ShowRoomDetails(roomModel: roomModel,);
         }));
        },
      ),
    );
  }
}