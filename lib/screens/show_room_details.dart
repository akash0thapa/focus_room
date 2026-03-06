import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:focus_room/services/database.dart';
import 'package:focus_room/styles/text_design.dart';
import 'package:focus_room/models/room_model.dart';
import 'package:slide_countdown/slide_countdown.dart';

class ShowRoomDetails extends StatefulWidget {
  final RoomModel roomModel;

  const ShowRoomDetails({
    super.key,
    required this.roomModel,
  });

  @override
  State<ShowRoomDetails> createState() => _ShowRoomDetailsState();
}

class _ShowRoomDetailsState extends State<ShowRoomDetails> {
  bool joined = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final room = widget.roomModel;

    Duration remaining =
        room.endTime.difference(DateTime.now());

    // Prevent negative duration crash
    if (remaining.isNegative) {
      remaining = Duration.zero;
    }

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        if (joined) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(5),
              shape:RoundedRectangleBorder(
                borderRadius:BorderRadius.circular(15)
              ),
              duration: const Duration(seconds: 2),
              content: const Center(
                child: Text(
                  'You must leave the room to go back!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          );
          return false;
        }
        return true;
      },
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue[900],
          title:
              Text('Room Details', style: textDesign.copyWith(fontSize: 20)),
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            StreamBuilder<DocumentSnapshot>(
              stream: DatabaseService()
                  .roomCollection
                  .doc(room.id)
                  .snapshots(),
              builder: (context, snapshot) {
                int memberCount = room.memberCount;

                if (snapshot.hasData && snapshot.data!.exists) {
                  final data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  memberCount = data['memberCount'] ?? 0;
                } else {
                  memberCount = 0;
                }

                return Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 24,
                      color: memberCount < 1
                          ? Colors.red
                          : Colors.green,
                      shadows: const [
                        Shadow(
                            color: Colors.black,
                            blurRadius: 5),
                      ],
                    ),
                    const SizedBox(width: 5),
                    Text(
                      memberCount.toString(),
                      style: textDesign.copyWith(fontSize: 18),
                    ),
                    const SizedBox(width: 10),
                  ],
                );
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context)
                      .copyWith(overscroll: false),
              child: Scrollbar(
                thumbVisibility: true,
                thickness: 5,
                radius: const Radius.circular(30),
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      /// 🔹 Topic
                      _roomInfoSection(
                        title: "Topic",
                        value: room.topic,
                        icon: Icons.label_outlined,
                        useGradient: true,
                      ),

                      /// 🔹 Goal
                      _roomInfoSection(
                        title: "Goal",
                        value: room.goal,
                        icon: Icons.flag_outlined,
                      ),

                      /// 🔹 Description
                      _roomInfoSection(
                        title: "Description",
                        value: room.description,
                        icon: Icons.description_outlined,
                      ),

                      const SizedBox(height: 50),

                      const Text(
                        'Session Ends In:',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      SlideCountdownSeparated(
                        separatorStyle: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        ),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        duration: remaining,
                        onDone: () async {
                          await DatabaseService()
                              .deleteRoom(room.id);

                          if (mounted) {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) =>
                                  AlertDialog(
                                title: const Text(
                                  'Session Ended!',
                                  style: TextStyle(
                                    fontWeight:
                                        FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Ok',
                                      style: TextStyle(
                                        fontWeight:
                                            FontWeight.w700,
                                        fontSize: 18,
                                        color:
                                            Colors.blue[900],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),

                      const SizedBox(height: 60),

                      /// 🔹 Join / Leave Button
                      InnerShadow(
                        shadows: const [
                          Shadow(
                              color: Colors.black,
                              blurRadius: 8),
                        ],
                        child: Container(
                          margin:
                              const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(15),
                            color: joined
                                ? Colors.red
                                : Colors.green,
                          ),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 30,
                                      vertical: 15),
                            ),
                            onPressed: () async {
                              setState(() {
                                _isLoading = true;
                              });

                              await Future.delayed(
                                  const Duration(
                                      seconds: 1));

                              if (joined) {
                                await DatabaseService()
                                    .leaveRoom(room.id);
                              } else {
                                await DatabaseService()
                                    .joinRoom(room.id);
                              }

                              await Future.delayed(
                                  const Duration(
                                      seconds: 1));

                              setState(() {
                                joined = !joined;
                                _isLoading = false;
                              });
                            },
                            child: Text(
                              joined ? 'LEAVE' : 'JOIN',
                              style: const TextStyle(
                                fontSize: 26,
                                color: Colors.white,
                                fontWeight:
                                    FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// 🔹 Loading Overlay
            if (_isLoading)
              Container(
                color: Colors.black.withAlpha(150),
                child: Center(
                  child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(
                            color: Colors.white,
                             ),
                             const SizedBox(height: 10,),
                             Text(
                              joined ? 'Leaving Session...' : 'Joining Session...',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight:
                                    FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                             
                        ],
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  //  room information combined
  Widget _roomInfoSection({
    required String title,
    required String value,
    required IconData icon,
    bool useGradient = true,
  }) {
    return Container(
      margin:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(

        gradient: useGradient
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue[900]!,
                  Colors.blue[600]!,
                ],
              )
            : null,
        color: useGradient ? null : Colors.blue[900],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 10),
              Icon(
                icon,
                color: Colors.white,
                shadows: const [
                  Shadow(
                      color: Colors.black,
                      blurRadius: 10),
                ],
              ),
              const SizedBox(width: 5),
              Text(
                title.toUpperCase(),
                style:
                    textDesign.copyWith(fontSize: 18),
              ),
            ],
          ),
          Container(
            constraints:
                const BoxConstraints(minHeight: 50),
            margin: const EdgeInsets.all(5),
            alignment: Alignment.centerLeft,
            padding:
                const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius:
                  BorderRadius.circular(10),
            ),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}