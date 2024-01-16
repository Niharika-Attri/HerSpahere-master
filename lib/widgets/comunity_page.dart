import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/Resource/auth_method.dart';
import 'package:untitled1/Screen/call_screen%5D.dart';
import 'package:untitled1/Screen/yoga_screen.dart';
import 'package:untitled1/Utils/utils.dart';

import '../Models/User_models.dart';
import 'char_userCard.dart';
import 'home_page.dart';


class CommunePage extends StatefulWidget {
  const CommunePage({super.key});

  @override
  State<CommunePage> createState() => _CommunePageState();
}

class _CommunePageState extends State<CommunePage> {
  final TextEditingController _searchController = TextEditingController();
  List<ChatUser> _list = [];


  // for storing searched items
  final List<ChatUser> _searchList = [];
  // for storing search status
  bool _isSearching = false;
  @override
  Widget build(BuildContext context) {
    var mq=MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: login_bg,
          title: const Text('Commune'),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: FloatingActionButton(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>YogaEx()));},
              child: const Icon(
                Icons.add,
                size: 38,
                color: Colors.white,
              )),
        ),
        body: SafeArea(
          child: Column(children: [
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 35,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.search),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Search'),
                          ],
                        ),
                        Icon(Icons.calendar_view_day),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Message',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Consultance()));
                          },
                          child: Text(
                            'Call',
                            style: TextStyle(fontSize: 20, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black38,
                  ),
                  Container(
                    height: mq.height*0.65,
                    child: StreamBuilder(
                      stream: FirestoreMethods().getMyUsersId(),

                      //get id of only known users
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                        //if data is loading
                          case ConnectionState.waiting:
                          case ConnectionState.none:
                            return const Center(child: CircularProgressIndicator());

                        //if some or all data is loaded then show it
                          case ConnectionState.active:
                          case ConnectionState.done:
                            return StreamBuilder(
                              stream:FirebaseFirestore.instance.collection('users').snapshots(),

                              //get only those user, who's ids are provided
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                //if data is loading
                                  case ConnectionState.waiting:
                                  case ConnectionState.none:
                                  // return const Center(
                                  //     child: CircularProgressIndicator());

                                  //if some or all data is loaded then show it
                                  case ConnectionState.active:
                                  case ConnectionState.done:
                                    final data = snapshot.data?.docs;
                                    _list = data
                                        ?.map((e) => ChatUser.fromJson(e.data()))
                                        .toList() ??
                                        [];

                                    if (_list.isNotEmpty) {
                                      return ListView.builder(
                                          itemCount: _isSearching
                                              ? _searchList.length
                                              : _list.length,
                                          padding: EdgeInsets.only(top: mq.height * .01),
                                          physics: const BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return ChatUserCard(
                                                user: _isSearching
                                                    ? _searchList[index]
                                                    : _list[index]);
                                          });
                                    } else {
                                      return const Center(
                                        child: Text('No Connections Found!',
                                            style: TextStyle(fontSize: 20)),
                                      );
                                    }
                                }
                              },
                            );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}