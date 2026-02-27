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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [
              0,0.3,1
            ],
            colors: [
              Colors.white,
              Color(0xFF809EC7),
              Color(0xFF003E8F)

            ]
          )
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0,0,0,30),       
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Welcome To',
              style: textDesign,
              ),
             
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
              style: textDesign.copyWith(
                fontSize: 20,)
              ),
              SizedBox(height: 50,),
              Center(
                child: Container(
                  decoration: BoxDecoration(                 
                   borderRadius: BorderRadius.circular(15),
                    color:Color(0xFF003E8F)
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0)
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Continue as Guest',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white              
                        ),),
                        Icon(Icons.keyboard_arrow_right,
                        size: 40,
                        color: Colors.white,)
                      ],
                    )
                    ),                
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}