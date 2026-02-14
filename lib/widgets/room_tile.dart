import 'package:flutter/material.dart';
import 'package:focus_room/models/room_model.dart';
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
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: ListTile(
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(15)
        ),
        tileColor: Colors.blue[700],
        title: Text('Title',
        style: textDesign.copyWith(fontSize: 24)
        ),
        subtitle: Text('Topic',      
        style: textDesign.copyWith(fontSize: 16)
        ),
        trailing: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person,
            size: 35,
            color: Colors.green,
             shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 10
                    )
                  ]
                ),
                Text('0',
                style: textDesign.copyWith(
                  fontSize: 25
                ))
          ],
        ),
        onTap: () {
          
        },
      ),
    );
  }
}