import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_crew/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object on UserCredential.
  // This is used to only store the necessary data of the user.
  UserData ? _userFilteredInfo(User? user) {
    return user != null ? UserData(uid: user.uid) : null;
  }

  // Stream returned everytime their is a change in auth
  Stream<UserData?> get user {
    return _auth.authStateChanges().map((User? user) => _userFilteredInfo(user!));
  }


  // sign in ann
  Future signInAnn() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFilteredInfo(user!);

    } catch (e){
      print('Unable to Authenticate. Error: ${e.toString()}');
      return null;
    }
  }

  // Sign Out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e){
      print('The Error is: $e');
      return null;
    }
  }

  // Register with email
  Future registerWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // create a new Document for the user with uid
      await DatabaseService(uid: user!.uid).updateUserData('New Member', '0', 100);

      return _userFilteredInfo(user);
    } catch(e){
      print('The Error is: $e');
      return null;
    }
  }

  // Sign In with email
  Future signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFilteredInfo(user);
    } catch(e){
      print('The Error is: $e');
      return null;
    }
  }



}