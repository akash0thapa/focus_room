import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:focus_room/screens/loading.dart';
import 'package:focus_room/services/database.dart';
import 'package:focus_room/styles/text_design.dart';
import 'package:focus_room/models/room_model.dart';
import 'package:slide_countdown/slide_countdown.dart';

class ShowRoomDetails extends StatefulWidget {
  final RoomModel roomModel;
  const ShowRoomDetails({super.key, required this.roomModel});

  @override
  State<ShowRoomDetails> createState() => _ShowRoomDetailsState();
}

class _ShowRoomDetailsState extends State<ShowRoomDetails> {
  bool joined = false;
  bool _isLoading = false;

   @override

  @override
  Widget build(BuildContext context) {
    final room = widget.roomModel;
    final remaining = room.endTime.difference(DateTime.now());

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        if (joined) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              content: Center(
                child: Text('You must leave the room to go back!'),
              ),
              duration: Duration(seconds: 1),
            ),
          );
          return false;
        }
        return true;
      },
      child: Center(
        child: Container(
          color: Colors.black,
          alignment: Alignment.center,
          child: Scaffold(
            extendBody: true,
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.blue[900],
              title: Text('Room Details', style: textDesign.copyWith(fontSize: 20)),
              iconTheme: IconThemeData(color: Colors.white),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      color: (room.memberCount < 1) ? Colors.red : Colors.green,
                    ),
                    Text(
                      room.memberCount.toString(),
                      style: textDesign.copyWith(fontSize: 18),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ],
            ),
            body: ScrollConfiguration(
              behavior: ScrollBehavior().copyWith(overscroll: false),
              child: Scrollbar(
                thumbVisibility: true,
                thickness: 5,
                radius: Radius.circular(30),
                child: Stack(
                  children: [ SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // --- Topic Section ---
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          decoration: BoxDecoration(
                            color: Colors.blue[900],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.label_outlined,
                                    color: Colors.white,
                                    shadows: [Shadow(color: Colors.black, blurRadius: 10)],
                                  ),
                                  SizedBox(width: 5),
                                  Text('TOPIC', style: textDesign.copyWith(fontSize: 18)),
                                ],
                              ),
                              Container(
                                height: 50,
                                margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(room.topic,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ),
                            ],
                          ),
                        ),
                  
                        // --- Goal Section ---
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          decoration: BoxDecoration(
                            color: Colors.blue[900],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.flag_outlined,
                                    color: Colors.white,
                                    shadows: [Shadow(color: Colors.black, blurRadius: 10)],
                                  ),
                                  SizedBox(width: 5),
                                  Text('GOAL', style: textDesign.copyWith(fontSize: 18)),
                                ],
                              ),
                              Container(
                                constraints: BoxConstraints(minHeight: 50),
                                margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(room.goal,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ),
                            ],
                          ),
                        ),
                  
                        // --- Description Section ---
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          decoration: BoxDecoration(
                            color: Colors.blue[900],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.description_outlined,
                                    color: Colors.white,
                                    shadows: [Shadow(color: Colors.black, blurRadius: 10)],
                                  ),
                                  SizedBox(width: 5),
                                  Text('DESCRIPTION', style: textDesign.copyWith(fontSize: 18)),
                                ],
                              ),
                              Container(
                                constraints: BoxConstraints(minHeight: 50),
                                margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(room.description,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ),
                            ],
                          ),
                        ),
                  
                        SizedBox(height: 10),
                        Text('Session Ends In:',
                            style: TextStyle(
                                fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold)),
                        SizedBox(height: 20),
                  
                        SlideCountdownSeparated(
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                          duration:  remaining,
                          onDone: () async {
                            // Delete from database first
                            await DatabaseService().deleteRoom(room.id);
                  
                            // Show popup
                            if (mounted) {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Session Ended!'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context); // close dialog
                                        Navigator.pop(context); // back to home
                                      },
                                      child: Text('Ok'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                  
                        SizedBox(height: 40),
                        InnerShadow(
                          shadows: [
                            Shadow(color: Colors.black.withOpacity(0.6), blurRadius: 8, offset: Offset(0, 0)),
                          ],
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: joined ? Colors.red : Colors.green,
                            ),
                            child: TextButton(
                              style: TextButton.styleFrom(padding: EdgeInsets.fromLTRB(30, 5, 30, 5)),
                              onPressed: () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                await Future.delayed(Duration(seconds: 1)); // slight delay for better UX
                                if (joined) {
                                  await DatabaseService().leaveRoom(room.id);
                                } else {
                                  await DatabaseService().joinRoom(room.id);
                                }
                                setState(() {
                                   Future.delayed(Duration(seconds: 2));
                                  joined = !joined;
                                  _isLoading = false;
                                });
                              },
                              child: joined
                                  ? Text('Leave', style: textDesign.copyWith(fontSize: 24))
                                  : Text('Join', style: textDesign.copyWith(fontSize: 22)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                   if (_isLoading)
          Container(
            color: Colors.black.withOpacity(0.4), // semi-transparent background
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          )
                  ]
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}