
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../Models/User_models.dart';
import '../Models/message_model.dart';

class FirestoreMethods {
  // for authentication
  FirebaseAuth auth = FirebaseAuth.instance;

  // for accessing cloud firestore database
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // for accessing firebase storage
  FirebaseStorage storage = FirebaseStorage.instance;

  // for storing self information
  late ChatUser me;

  // to return current user
  User get user => auth.currentUser!;

  // for accessing firebase messaging (Push Notification)
  FirebaseMessaging fMessaging = FirebaseMessaging.instance;

  // for getting firebase messaging token
  Future<void> getFirebaseMessagingToken() async {
    await fMessaging.requestPermission();

    await fMessaging.getToken().then((t) {
      if (t != null) {
        me.pushToken = t;
        log('Push Token: $t');
      }
    });

    // for handling foreground messages
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   log('Got a message whilst in the foreground!');
    //   log('Message data: ${message.data}');

    //   if (message.notification != null) {
    //     log('Message also contained a notification: ${message.notification}');
    //   }
    // });
  }



  Future<String> signUpUser(
      {
        required String email,
        required String password,
        required String username,
        required Uint8List file,
      }) async{
    String res ="Some error occurred" ;
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      if (email.isNotEmpty || password.isNotEmpty ) {
        UserCredential credential = await auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await StorageMethod().uploadImageToStorage(
            'profilePic', file, false);

       ChatUser users = ChatUser(image: photoUrl??'Ajay', about: '', name: username, createdAt: time, isOnline: false, id: credential.user!.uid, lastActive: '', email: email, pushToken: '');

        await firestore.collection('users').doc(credential.user!.uid).set(users.toJson());
        res = "success";
      }else{
        res='Pls enter email and password';
      }
    }on FirebaseException catch(err){
      if(err.code=='invalid-email'){
        res='The Email is badly formatted';
      }else if(err.code=='weak-password'){
        res='Password should be at least 6 character';
      }else if(err.code=='email-already-in-use'){
        res='The email address is already in use';
      }
    }catch(err){

      return err.toString();

    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password}) async {
    String res ='Some error occurred';

    try{

      if(email.isNotEmpty && password.isNotEmpty ){
        await  auth.signInWithEmailAndPassword(email: email, password: password);
        res='Success';
      }else{
        res='Please enter all the field';
      }
    }on FirebaseException catch(err){
      if(err.code=='invalid-email'){
        res='The Email is badly formatted';
      }else if(err.code=='weak-password'){
        res='Password should be at least 6 character';
      }else if(err.code=='user-not-found'){
        res='No user found';
      }else if(err.code=='wrong-password'){
        res='The password is invalid';
      }
    }catch(err){
      res=err.toString();
      debugPrintThrottled(err.toString());
    }
    return res;
  }


  // for sending push notification
   Future<void> sendPushNotification(
      ChatUser chatUser, String msg) async {
    try {
      final body = {
        "to": chatUser.pushToken,
        "notification": {
          "title": me.name, //our name should be send
          "body": msg,
          "android_channel_id": "chats"
        },
        // "data": {
        //   "some_data": "User ID: ${me.id}",
        // },
      };

      var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
            'key=AAAAT3gUq8s:APA91bG7UFKpNmHAsRBE-gFS1pE999jxsm6S5QfzmziVaYD9HNu-RtdZDSgAdOOem2TfHcOdMXY8lz7AY-JIF9puflA-p4omKDKhl5TMYaihDNJNGyEs2-MyyE4m1KBq8cEnp1xMM72u'
          },
          body: jsonEncode(body));
      log('Response status: ${res.statusCode}');
      log('Response body: ${res.body}');
    } catch (e) {
      log('\nsendPushNotificationE: $e');
    }
  }

  // for checking if user exists or not?
  Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  // for adding an chat user for our conversation
  Future<bool> addChatUser(String email) async {
    final data = await firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    log('data: ${data.docs}');

    if (data.docs.isNotEmpty && data.docs.first.id != user.uid) {
      //user exists

      log('user exists: ${data.docs.first.data()}');

      firestore
          .collection('users')
          .doc(user.uid)
          .collection('my_users')
          .doc(data.docs.first.id)
          .set({});

      return true;
    } else {
      //user doesn't exists

      return false;
    }
  }

  // for getting current user info
  Future<void> getSelfInfo() async {
    await firestore.collection('users').doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
        await getFirebaseMessagingToken();

        log('My Data: ${user.data()}');
      } else {
        await createUser().then((value) => getSelfInfo());
      }
    });
  }

  // for creating a new user
  Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final chatUser = ChatUser(
        id: user.uid,
        name: user.displayName.toString(),
        email: user.email.toString(),
        about: "Hey, I'm using We Chat!",
        image: user.photoURL.toString(),
        createdAt: time,
        isOnline: false,
        lastActive: time,
        pushToken: '');

    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

  // for getting id's of known users from firestore database
  Stream<QuerySnapshot<Map<String, dynamic>>> getMyUsersId() {
    return firestore
        .collection('users')
        .doc(user.uid)
        .collection('my_users')
        .snapshots();
  }

  // for getting all users from firestore database
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(
      List<String> userIds) {
    log('\nUserIds: $userIds');

    return firestore
        .collection('users')
        // .where('id',
        // whereIn: userIds.isEmpty
        //     ? ['']
        //     : userIds) //because empty list throws an error
    .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

  // for adding an user to my user when first message is send
  Future<void> sendFirstMessage(
      ChatUser chatUser, String msg, Type type) async {
    await firestore
        .collection('users')
        .doc(chatUser.id)
        .collection('my_users')
        .doc(user.uid)
        .set({}).then((value) => sendMessage(chatUser, msg, type));
  }

  // for updating user information
  Future<void> updateUserInfo() async {
    await firestore.collection('users').doc(user.uid).update({
      'name': me.name,
      'about': me.about,
    });
  }

  // update profile picture of user
  Future<void> updateProfilePicture(File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;
    log('Extension: $ext');

    //storage file ref with path
    final ref = storage.ref().child('profile_pictures/${user.uid}.$ext');

    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    //updating image in firestore database
    me.image = await ref.getDownloadURL();
    await firestore
        .collection('users')
        .doc(user.uid)
        .update({'image': me.image});
  }

  // for getting specific user info
  Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      ChatUser chatUser) {
    return firestore
        .collection('users')
        .where('id', isEqualTo: chatUser.id)
        .snapshots();
  }

  // update online or last active status of user
  Future<void> updateActiveStatus(bool isOnline) async {
    firestore.collection('users').doc(user.uid).update({
      'is_online': isOnline,
      'last_active': DateTime.now().millisecondsSinceEpoch.toString(),
      'push_token': me.pushToken,
    });
  }

  ///************** Chat Screen Related APIs **************

  // chats (collection) --> conversation_id (doc) --> messages (collection) --> message (doc)

  // useful for getting conversation id
  String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  // for getting all messages of a specific conversation from firestore database
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUser user) {
    return firestore
        .collection('chats/${getConversationID(user.id)}/messages/')
        .orderBy('sent', descending: true)
        .snapshots();
  }

  // for sending message
  Future<void> sendMessage(
      ChatUser chatUser, String msg, Type type) async {
    //message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    //message to send
    final Message message = Message(
        toId: chatUser.id,
        msg: msg,
        read: '',
        type: type,
        fromId: user.uid,
        sent: time);

    final ref = firestore
        .collection('chats/${getConversationID(chatUser.id)}/messages/');
    await ref.doc(time).set(message.toJson()).then((value) =>
        sendPushNotification(chatUser, type == Type.text ? msg : 'image'));
  }

  //update read status of message
  Future<void> updateMessageReadStatus(Message message) async {
    firestore
        .collection('chats/${getConversationID(message.fromId)}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  //get only last message of a specific chat
  Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      ChatUser user) {
    return firestore
        .collection('chats/${getConversationID(user.id)}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  //send chat image
  Future<void> sendChatImage(ChatUser chatUser, File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;

    //storage file ref with path
    final ref = storage.ref().child(
        'images/${getConversationID(chatUser.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext');

    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    //updating image in firestore database
    final imageUrl = await ref.getDownloadURL();
    await sendMessage(chatUser, imageUrl, Type.image);
  }

  //delete message
  Future<void> deleteMessage(Message message) async {
    await firestore
        .collection('chats/${getConversationID(message.toId)}/messages/')
        .doc(message.sent)
        .delete();

    if (message.type == Type.image) {
      await storage.refFromURL(message.msg).delete();
    }
  }

  //update message
  Future<void> updateMessage(Message message, String updatedMsg) async {
    await firestore
        .collection('chats/${getConversationID(message.toId)}/messages/')
        .doc(message.sent)
        .update({'msg': updatedMsg});
  }
}

class StorageMethod {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(String childName, Uint8List file,
      bool isPost) async {
    Reference ref = storage.ref().child(childName).child(auth.currentUser!.uid);

    // if (isPost) {
    //   String id = const Uuid().v1();
    //   ref = ref.child(id);
    // }

    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}