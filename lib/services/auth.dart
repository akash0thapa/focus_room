import 'package:firebase_auth/firebase_auth.dart';
import 'package:focus_room/models/user_model.dart';
class AuthService {
  final FirebaseAuth _auth=FirebaseAuth.instance;


  //get user from firebaseUser
  UserModel? _userfromFirebaseUser (User? user){
    return user!=null? UserModel(uid: user.uid):null;
  }


  //stream
  Stream<UserModel?>get userStream{
    return _auth.authStateChanges().map(_userfromFirebaseUser);
  }
  //signin anonymously
  Future signInAnon() async {
    try{
     UserCredential result= await _auth.signInAnonymously();
     User? user=result.user;
     return user;
    }catch(e){
      print(e.toString());
      return null;
      
    }
  }

  //signout
  Future signOut()async{
    try{
      await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}