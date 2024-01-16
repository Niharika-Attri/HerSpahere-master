import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/Screen/auth_screen.dart';

import '../Resource/auth_method.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}
class _MyProfileState extends State<MyProfile> {
  bool isLoading =false;
  var userData = {};
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      // get post lENGTH
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      userData = userSnap.data()!;

      setState(() {});
    } catch (e) {
     print(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
   var _size= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 58, 84),
        title: const Text('Profile',style: TextStyle(color: Colors.black),),
        leading:IconButton(onPressed: (){Navigator.of(context).pop();}, icon: const Icon(Icons.arrow_back_ios,color:Colors.black,)),
        actions: [
          IconButton(onPressed: (){FirebaseAuth.instance.signOut();
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const AuthScreen()));}, icon: const Icon(Icons.logout,color:Colors.black,)),
        ],
      ),
      body:  isLoading?const Center(child: CircularProgressIndicator()):Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40,),
              CircleAvatar(
               backgroundImage: NetworkImage(userData['image']),
                radius: 52,
              ),
              Text(userData['name'],style: TextStyle(color: Colors.black,fontSize: 34),),

              SizedBox(height: 15,),
              Divider(thickness: 2,height: 2,)
            ],
          ),

          SizedBox(height: 20,),
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('posts')
                .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8),
                height: 75,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                  (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot snap =
                    (snapshot.data! as dynamic).docs[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8),
                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.circular(15),
                        child: SizedBox(
                          width: 80,
                          child: Text('Post'),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}