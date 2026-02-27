import 'package:flutter/material.dart';
import 'package:focus_room/models/room_model.dart';
import 'package:focus_room/screens/create_room.dart';
import 'package:focus_room/services/database.dart';
import 'package:focus_room/widgets/room_list.dart';
import 'package:focus_room/services/auth.dart';
import 'package:focus_room/styles/text_design.dart';
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
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Color(0xFF003E8F),
          titleSpacing: 5,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text('FocusRoom',
                style: textDesign.copyWith(
                  fontSize: 22
                ),
                ),
              ),
               IconButton(
                onPressed: ()async{
                showLogOutDialogBox();
                    }, 
                    icon: Icon(Icons.logout,
                    size: 26,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 10
                      )
                    ]),
                 ),
            ],           
          ),  
        ),
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
      
      
        //body
        body: Column(       
          children: [
            Container(
              width: double.infinity,
              color: Colors.white, 
              child: Center(
                child: Text('Room List',
                style: TextStyle(
                  color: Colors.blue[900],
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )
                ),
              ),
            ),   
            SizedBox(height: 20,),      
            Expanded(            
              child: RoomList()),
          ],
        ),
        //bottom navigation bar
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(              
          color: Color(0xFF003E8F),
          shape: CircularNotchedRectangle(),
          notchMargin:3,
          height: 60,
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