import 'package:flutter/material.dart';
import 'package:focus_room/models/user_model.dart';
import 'package:focus_room/screens/home.dart';
import 'package:focus_room/screens/welcome.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<UserModel?>(context); 
    // return CreateRoom();
    if(user==null){
      return Welcome();
    }
    else{
      return Home();
    }
  }
}