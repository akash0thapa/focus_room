import 'package:flutter/material.dart';
import 'package:focus_room/screens/loading.dart';
import 'package:focus_room/services/auth.dart';
import 'package:focus_room/styles/text_design.dart';


class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final AuthService _auth=AuthService();
  bool isloading=false;
  @override
  Widget build(BuildContext context) {
    return isloading ? Loading() : Scaffold(
      backgroundColor: Colors.blue[200],
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10,130,0,0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome',
            style: textDesign,
            ),
            Text('To',
            style: textDesign,
            ),
            Row(
              children: [
                Text('Focus',
                style: textDesign.copyWith(
                  color: Colors.yellow
                )
                ),
                Text('Room',
                style: textDesign.copyWith(
                  color: Colors.orangeAccent)
                ),
              ],
            ),
            Text('Stay Focused and Productive',
            style: textDesign.copyWith(fontSize: 22)
            ),
            SizedBox(height: 140,),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 20,
                      spreadRadius: -5,                    
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFB8D4A6),
                      Color(0xFF3C810D),
                    ],
                    ),
                  borderRadius: BorderRadius.circular(50),
                  color:Colors.white
                ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(30, 5, 5, 5)
                  ),
                  onPressed: ()async{
                    dynamic result=await _auth.signInAnon();
                    if(result==null){
                      setState(() {
                        isloading=false;
                      });                 
                    }
                    else{
                      setState(() {
                        isloading=true;
                      });
                    }
                  }, 
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Continue as Guest',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: Colors.white              
                      ),),
                      Icon(Icons.keyboard_arrow_right,
                      size: 50,
                      color: Colors.white,)
                    ],
                  )
                  ),                
              ),
            )
          ],
        ),
      ),
    );
  }
}