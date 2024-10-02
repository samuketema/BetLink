// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:betlink/models/user.dart';

final UserProvider = StateNotifierProvider<UserNotifier, LocalUser>((ref) {
  return UserNotifier();
});

class LocalUser {
  FirebaseUser user;
  String id;
  LocalUser({
    required this.user,
    required this.id,
  });
}

class UserNotifier extends StateNotifier<LocalUser> {
  FirebaseFirestore _storage = FirebaseFirestore.instance;

  UserNotifier()
      : super(
          LocalUser(
              user: FirebaseUser(
                  name: 'Your Name',
                  email: 'error',
                  profilePic:
                      'http://commondatastorage.googleapis.com/codeskulptor-assets/lathrop/nebula_brown.png'),
              id: 'error'),
        );

  Future<void> signup(String email) async {
    DocumentReference responce = await _storage.collection('users').add(FirebaseUser(
            name: 'Name',
            email: 'Email',
            profilePic:
                'http://commondatastorage.googleapis.com/codeskulptor-assets/lathrop/nebula_brown.png')
        .toMap());
        DocumentSnapshot snapshot = await responce.get();
        state = LocalUser(user: FirebaseUser.fromMap(snapshot.data() as Map<String,dynamic>), id: responce.id);
  }
  Future<void> login( String email) async{
   QuerySnapshot responce =  await _storage.collection('users').where('email' , isEqualTo:email ).get();
   if (responce.docs.isEmpty) {
      print('No firestore user associated to the authenticated email $email');
      return;
    }
    if (responce.docs.length != 1) {
      print(
          'More than one firestore user is associated to the authenticated email $email');
      return;
    }
    state = LocalUser(user: FirebaseUser.fromMap(responce.docs[0].data() as Map<String,dynamic>), id: responce.docs[0].id);
  }
}
