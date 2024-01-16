import 'package:flutter/material.dart';
import 'package:untitled1/Utils/utils.dart';

import '../Models/Comunity Tab.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var _size=MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          children: [
            CircleAvatar(backgroundColor:Colors.white,
              backgroundImage: AssetImage('assets/img/attachment_98127672 1.png',),
            ),
            SizedBox(width: 10,),
            Text('HerSphere')
          ],
        ),
        backgroundColor: login_bg,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: Colors.black,
              )),
        ],),
      body:Padding(
        padding: const EdgeInsets.all(15),
        child: SizedBox(
          width: _size.width,
          height: _size.height,
          child: Column(
            children: [
              Container(
                height: _size.height*.3,
                decoration: const BoxDecoration(
                    color: signup_bg,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: const Center(child: Text('Community Post Of The Day',style: TextStyle(color: Colors.white),)),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: login_bg,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child:Column(
                    children: [
                      Container(
                        width: _size.width,
                        height: _size.height*0.1,
                        child: const Center(
                          child: Text(
                            'Community Post '
                            ,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 34),
                          ),
                        ),
                      ),
                      Container(
                        height: _size.height*0.40,
                        child: ListView(
                          children: [
                            ComunityCard()


                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ) ,
    );
  }
}