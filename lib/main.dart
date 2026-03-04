import 'package:flutter/material.dart';
import 'package:focus_room/models/user_model.dart';
import 'package:focus_room/services/auth.dart';
import 'wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCKVqS53HdPGvVfcabSQ9_kanIA1b3UhPE",
      projectId: "focusroom-81adc",
      messagingSenderId: "232707798168",
      appId: "1:232707798168:web:63124006807a837d250ced",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      value: AuthService().userStream,
      initialData: UserModel(uid: ''),
      child: MaterialApp(
        theme: ThemeData(
          // fontFamily: 'Inter'
        ),
        home: Center(
          child: Scaffold(
            backgroundColor: Colors.black54,
            body: Wrapper(),
          ),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
