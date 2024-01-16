import 'package:flutter/material.dart';
import 'package:untitled1/Utils/utils.dart';

import '../widgets/Like.dart';



class ComunityCard extends StatefulWidget {
  const ComunityCard({Key? key}) : super(key: key);

  @override
  State<ComunityCard> createState() => _ComunityCardState();
}

class _ComunityCardState extends State<ComunityCard> {
  bool isLikeAnimating=false;


  @override
  Widget build(BuildContext context) {
    var _size=MediaQuery.of(context).size;

    return Column(
        children: [for(int i=0;i<10;i++)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            child: Column(
              children: [
                Container(height: _size.height*0.1,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Card( shape: CircleBorder(side: BorderSide(width: 4)),
                        child: CircleAvatar(
                          radius: 22,
                          backgroundImage: NetworkImage(''),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Username',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Date',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11,
                                  color: Color(0xFFB0A8A6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => Dialog(backgroundColor: login_bg,
                                child: ListView(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shrinkWrap: true,
                                  children: ['Delete',]
                                      .map(
                                        (e) => InkWell(overlayColor: MaterialStatePropertyAll(Color(0xFF836F71)),
                                      onTap: () {},
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16),
                                        child: Text(e),
                                      ),
                                    ),
                                  )
                                      .toList(),
                                ),
                              ));
                        },
                        icon: const Icon(
                          Icons.more_horiz_outlined,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: GestureDetector(
                            onDoubleTap: (){},
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(height: _size.height*0.1,width: _size.width*0.7,
                                    child: Center(child: Text('Writen Content' , style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),))
                                ),
                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 200),
                                  opacity: isLikeAnimating? 1:0 ,

                                  child: LikeAnimation(
                                    isAnimating: isLikeAnimating,
                                    duration: const Duration(milliseconds: 500),
                                    onEnd: (){
                                      setState(() {
                                        isLikeAnimating=false;
                                      });
                                    },
                                    child: const Icon(Icons.favorite,color: Color.fromRGBO(204, 25, 40, 1.0),size: 120,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(
                            left: 40,
                          ),
                          child: Row(
                            children: [
                              LikeAnimation(
                                isAnimating: true,
                                smallLike: true,
                                child: IconButton(
                                    onPressed: () {},
                                    icon:
                                    const Icon(
                                      Icons.favorite,
                                      color: Color.fromRGBO(204, 25, 40, 1.0),
                                    )
                                ),
                              ),
                              Text('1',style: const TextStyle(color: Colors.black),),
                              Container(
                                width: 30,
                              ),

                            ],
                          ),
                        ),


                        // Container(
                        //   padding: const EdgeInsets.symmetric(vertical:12 ,horizontal:16 ),
                        // child: Column(
                        //   mainAxisSize: MainAxisSize.min,
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     DefaultTextStyle(style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.w800), child: const Text('1024 likes'),),
                        //     Container(
                        //       width: double.infinity,
                        //       padding: const EdgeInsets.only(top: 4),
                        //       child: RichText(
                        //         text: const TextSpan(
                        //           style: TextStyle(color: primaryColor),
                        //           children: [
                        //             TextSpan(
                        //               style: TextStyle(fontWeight: FontWeight.bold,),
                        //               text: 'username'
                        //             ),
                        //             TextSpan(
                        //                 text: 'Hey some description to be replaced'
                        //             ),
                        //           ]
                        //         ),
                        //       ),
                        //     )
                        //   ],
                        // ),

                        // ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),]
    );
  }
}