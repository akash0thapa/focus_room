import 'package:flutter/material.dart';

Color bgColor=Colors.blue[900]!;



// ///////
//  SliverAppBar(
//                 // toolbarHeight: 35,
//                 expandedHeight: 100,
//                 elevation: 5,
//                 shadowColor: Colors.black,
//                 backgroundColor:bgColor,
                
//                 pinned: true,
//                 flexibleSpace: FlexibleSpaceBar(
//                   background: Stack(
//                     children:[ Container(
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [
//                            Colors.blue[700]!,
//                              Colors.blue[900]!, 
//                         ])
//                       ),
//                       child: Padding(
//                         padding: EdgeInsetsGeometry.fromLTRB(10, 10, 10, 0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text('Rooms', style: textDesign.copyWith(fontSize: 24)),
//                             IconButton(
//                               onPressed: () async {
//                                 showLogOutDialogBox();
//                               },
//                               icon: Icon(
//                                 Icons.logout_outlined,
//                                 color: Colors.white,
//                                 size: 28,
//                                 shadows: [
//                                   Shadow(color: Colors.black, blurRadius: 10),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                      Positioned(
//                       top: 50,
//                       right: width/4,
//                       child: blurredCircle(55,2)
//                       ),
//                        Positioned(
//                       top: 50,
//                       left: width/4,
//                       child: blurredCircle(25,4)
//                       ),
//                     ]
//                   ),
//                 ),
//               ),

//               // 