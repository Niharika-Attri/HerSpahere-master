import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/Utils/utils.dart';

import '../widgets/Comment Card.dart';


class CommentsScreen extends StatefulWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController commentEditingController =
  TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: login_bg,
        title: const Text('Comments' ,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Color(0xFF836F71)),),
        titleSpacing: 30,
        shadowColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.chat_rounded,color: Color(0xFF8F8785),)),

        ],
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (ctx, index) => CommentCard(),
      ),
      // text input
      bottomNavigationBar:SafeArea(
          child: Container(
            height: kToolbarHeight,
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            padding: const EdgeInsets.only(left: 16,right: 8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(''),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          controller: commentEditingController,
                          decoration: InputDecoration(
                            fillColor: Color(0xFFC9C9C9),
                            hintText: 'Comments',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                  color: Color(0xFFC9C9C9),
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                  color: Color(0xFFC9C9C9),
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                  color: Color(0xFFC9C9C9),
                                )),
                            filled: true,
                            contentPadding:
                            const EdgeInsets.all(8).copyWith(left: 20),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: IconButton(
                            onPressed: (){},
                            icon: const Icon(Icons.send,color: Colors.white,size: 30,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )

        // SafeArea(
        //   child: Container(
        //     height: kToolbarHeight,
        //     margin:
        //     EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        //     padding: const EdgeInsets.only(left: 16, right: 8),
        //     child: Row(
        //       children: [
        //         CircleAvatar(
        //           backgroundImage: NetworkImage(user.photoUrl),
        //           radius: 18,
        //         ),
        //         Expanded(
        //           child: Padding(
        //             padding: const EdgeInsets.only(left: 16, right: 8),
        //             child: TextField(
        //               controller: commentEditingController,
        //               decoration: InputDecoration(
        //                 hintText: 'Comment as ${user.username}',
        //                 border: InputBorder.none,
        //               ),
        //             ),
        //           ),
        //         ),
        //         InkWell(
        //           onTap: () => postComment(
        //             user.uid,
        //             user.username,
        //             user.photoUrl,
        //           ),
        //           child: Container(
        //             padding:
        //             const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        //             child: const Text(
        //               'Post',
        //               style: TextStyle(color: Colors.blue),
        //             ),
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
      ),
    );
  }
}