import 'package:flutter/material.dart';
import 'package:focus_room/models/user_model.dart';
import 'package:focus_room/services/auth.dart';
import 'wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main()async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
        value: AuthService().userStream,
        initialData:null,
      child: MaterialApp(
          home: Wrapper(),
          debugShowCheckedModeBanner: false,
      ),
    );
  }
}