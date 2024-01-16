import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/Utils/utils.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(40)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 13),
          color: login_bg,
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    ''
                ),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'Name',
                                style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black)
                            ),
                            TextSpan(
                                text: '     Message',
                                style: const TextStyle(color: Colors.black45)
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text('Date'
                          ,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400,color: Colors.cyan),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.favorite,
                  size: 16,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}