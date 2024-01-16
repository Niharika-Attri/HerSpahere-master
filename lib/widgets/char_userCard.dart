import 'package:flutter/material.dart';
import 'package:untitled1/Resource/auth_method.dart';
import 'package:untitled1/Screen/chat_details.dart';

import '../Models/User_models.dart';
import '../Models/message_model.dart';
class ChatUserCard extends StatefulWidget {
  final ChatUser user;

  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  //last message info (if null --> no message)
  Message? _message;

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: 4),
      // color: Colors.blue.shade100,
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
          onTap: () {
            //for navigating to chat screen
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ChatScreenDetail(user: widget.user)));
          },
          child: StreamBuilder(
            stream: FirestoreMethods().getLastMessage(widget.user),
            builder: (context, snapshot) {
              final data = snapshot.data?.docs;
              final list =
                  data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
              if (list.isNotEmpty) _message = list[0];

              return ListTile(
                //user profile picture
                leading: InkWell(
                  onTap: () {
                    // showDialog(
                    //     context: context,
                    //     builder: (_) => ProfileDialog(user: widget.user));
                  },
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.user.image),
                    radius: 30,
                  )
                ),

                //user name
                title: Text(widget.user.name),

                //last message
                subtitle: Text(
                    _message != null
                        ? _message!.type == Type.image
                        ? 'image'
                        : _message!.msg
                        : widget.user.about,
                    maxLines: 1),

              );
            },
          )),
    );
  }
}