import 'package:flutter/material.dart';
import 'package:focus_room/models/room_model.dart';
import 'package:focus_room/screens/show_room_details.dart';
import 'package:focus_room/styles/text_design.dart';

class RoomTile extends StatelessWidget {
  final RoomModel roomModel;
  const RoomTile({
    super.key,
    required this.roomModel,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
      child: ListTile(
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(15)
        ),
        tileColor: Colors.blue[700],
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