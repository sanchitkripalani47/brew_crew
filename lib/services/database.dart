import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {

  final String uid;

  DatabaseService({required this.uid});

  // Collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String name, String sugars, int strength) async {
    return await brewCollection.doc(uid).set({
      'name' : name,
      'sugars' : sugars,
      'strength' : strength
    });
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((doc) {
      return Brew(
          name: doc.get('name') ?? '',
          strength: doc.get('strength') ?? 0,
          sugars: doc.get('sugars') ?? '0'
      );
    }).toList();
  }

  // Get brew streams
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  // User Preferences from Snapshot
  UserPreferences _userPreferencesFromSnapshot (DocumentSnapshot documentSnapshot){
    return UserPreferences(
        uid: uid,
        name: documentSnapshot["name"],
        sugars: documentSnapshot["sugars"],
        strength: documentSnapshot["strength"]
    );
  }

  // Get User Document Stream
  Stream<UserPreferences> get userPreferences {
    return brewCollection.doc(uid).snapshots()
    .map(_userPreferencesFromSnapshot);
  }

}