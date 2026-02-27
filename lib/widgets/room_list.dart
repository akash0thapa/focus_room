import 'package:flutter/material.dart';
import 'package:focus_room/models/room_model.dart';
import 'package:focus_room/widgets/room_tile.dart';
import 'package:provider/provider.dart';

class RoomList extends StatefulWidget {
  const RoomList({super.key});

  @override
  State<RoomList> createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  @override
  Widget build(BuildContext context) {
    final roomList=Provider.of<List<RoomModel>>(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return RoomTile(roomModel:  roomList[index],);
        },
        childCount: roomList.length
        ),    
      );
      // child: ListView.builder(
      //   itemCount: roomList.length,
      //   itemBuilder: (context,index){
      //     return RoomTile(roomModel: roomList[index],);
      //   }
      //   ),
  }
}