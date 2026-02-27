import 'package:flutter/material.dart';
import 'package:focus_room/models/room_model.dart';
import 'package:focus_room/screens/create_room.dart';
import 'package:focus_room/services/database.dart';
import 'package:focus_room/services/auth.dart';
import 'package:focus_room/styles/text_design.dart';
import 'package:focus_room/widgets/room_list.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    //scaffold is wrapped inside the roomlist stream created 
    return StreamProvider<List<RoomModel>>.value(
      value: DatabaseService().roomList,
      initialData: [],
      child: Scaffold(
         floatingActionButton: SizedBox(
          height: 70,
          width: 70,
          child: FloatingActionButton(
            backgroundColor:Color(0xFF003E8F),
            onPressed: (){
             _showCreateRoomPanel();
            },
            shape: CircleBorder(),    
            child: Icon(Icons.add,
            size: 50,
            color: Colors.white,
            shadows: [
              Shadow(
                  color: Colors.black,
                  blurRadius: 10
                )
            ],
            ),   
          ),
          
        ),
        //bottom navigation bar
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(              
          color: Color(0xFF003E8F),
          shape: CircularNotchedRectangle(),
          notchMargin:3,
          height: 60,
        ),            
      
        body: ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(overscroll: false),
          child: CustomScrollView(               
            slivers: [
              SliverAppBar(
                toolbarHeight: 100,
                expandedHeight: 100,
                backgroundColor: Color(0xFF003E8F),
                flexibleSpace: FlexibleSpaceBar(           
                background: Padding(
                  padding: EdgeInsetsGeometry.fromLTRB(10, 50, 10, 0),
                  child: Column(
                    children: [
                    Text('Welcome To FocusRoom', 
                    style: textDesign.copyWith(fontSize: 30)
                    ),
                  Text('Stay Focused and Productive',
                    style: textDesign.copyWith(fontSize: 18,
                    color: Colors.grey[400]) )    
                    ],
                  ),
                ),
                ),
              ),
              
              SliverAppBar(
                backgroundColor: Color(0xFF003E8F),
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(               
                  background: Padding(
                    padding: EdgeInsetsGeometry.fromLTRB(10, 30, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Rooms',
                        style: textDesign.copyWith(
                          fontSize: 24
                        ),                  
                        ),
                        IconButton(
                          onPressed: ()async{
                             showLogOutDialogBox();
                             },  
                        icon: Icon(Icons.logout_outlined,
                        size: 28,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            blurRadius: 10
                          )
                        ]
                        ))
                      ],
                    ),
                  ),
                  ),
              ),  
              SliverToBoxAdapter(
                child: SizedBox(height: 20,),
              ),
                 RoomList(),    
                 SliverFillRemaining(
                  child: Center(
                    child: Text('Create Rooms and Stay Focused!',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold
                    ),),
                  )
                 )
              // SliverFillRemaining(
                
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Icon(Icons.lightbulb_outline, 
              //       size: 100, 
              //       color: Colors.grey[700],),
              //        SizedBox(height: 20,),
              //       Text('Create New Rooms!',
              //       style: TextStyle(
              //         fontWeight: FontWeight.bold, 
              //         fontSize: 30,
              //         color: Colors.grey),
              //         ),
              //         Text('Stay Focused and Productive',
              //         style: TextStyle(
              //           fontSize: 16,
              //           color: Colors.grey,
              //           fontWeight: FontWeight.w700
              //         ),),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      
    ),    
    );
  }
  
  void showLogOutDialogBox() {
    showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          backgroundColor: Colors.grey[300],
          title: Text('Logout!',
          style: TextStyle(
                fontWeight: FontWeight.bold,            
              ),),
          content:Text('Are you Sure?',
          style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),),      
          actions: [          
            MaterialButton(
              onPressed: ()async{
                Navigator.pop(context);
                await _auth.signOut();
              },
              child: Text('Yes',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
              ),
            ),
            MaterialButton(
              onPressed: (){
              Navigator.pop(context);
              },
              child: Text('No',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),),
            )
          ],

        );
      }
      );
  }
  
  void _showCreateRoomPanel() {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // important to allow full height
    backgroundColor: Colors.transparent, // important for rounded corners
    barrierColor: Colors.black54.withOpacity(0.8),
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height*0.9,
        decoration: BoxDecoration(
          color: Color(0xFF003E8F),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30)
          )
        ),
        child: Column(
          children: [
            Expanded(child: CreateRoom())
          ],
        )
      );
    }
  );
  }
}