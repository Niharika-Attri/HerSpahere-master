import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leadingWidth: 30,
          title: Row(children: [
            ClipRRect(child: Icon(Icons.person)),SizedBox(width: 25,),Text('Name'),
          ],),
            backgroundColor: Colors.deepOrangeAccent,
          ),
    );
  }
}
