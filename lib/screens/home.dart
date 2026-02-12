import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus_room/services/auth.dart';
import 'package:focus_room/styles/text_design.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('FocusRoom'),
        titleTextStyle: textDesign.copyWith(
          fontSize: 26,          
        ),   
        actions: [
          TextButton.icon(
            onPressed: ()async{
              showDialogBox();
            }, 
            label: Text('Logout',style: textDesign.copyWith(fontSize: 20),),
            icon: Icon(Icons.person,
            size: 30,
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
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          backgroundColor: Colors.blue[900],
          onPressed: (){
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
     body: ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
      overscroll: false),
       child: ListView.builder(
        itemCount: 10,
        itemBuilder:(context, index) {
          return Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 10,vertical: 10),
            child: ListTile(
              leading: CircleAvatar(),
              title: Text('Title'),
              subtitle: Text('subtitle'),
              tileColor: Colors.blue,
            ),
          );
        },
        ),
     ),
      //bottom navigation bar
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(              
        color: Colors.blue[900],
        shape: CircularNotchedRectangle(),
        notchMargin:3,
        height: 60,
      ),
      

    );
  }
  
  void showDialogBox() {
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
}