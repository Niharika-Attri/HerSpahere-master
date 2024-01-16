import 'package:flutter/material.dart';
import 'package:untitled1/Utils/utils.dart';

import 'like animation.dart';

class ComunityCard extends StatefulWidget {
  const ComunityCard({Key? key}) : super(key: key);

  @override
  State<ComunityCard> createState() => _ComunityCardState();
}

class _ComunityCardState extends State<ComunityCard> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                  .copyWith(right: 0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(''),
                  ),
                  Expanded(
                    child: Padding(
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
                          Container(
                            height: 5,
                          ),
                          Text(
                            "Date",
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
                          builder: (context) => Dialog(
                            child: ListView(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shrinkWrap: true,
                              children: ['Delete']
                                  .map(
                                    (e) => InkWell(
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
                      color: Color(0xFFD4BEC1),
                    ),
                  ),
            Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 60,
                        top: 4,
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            const Icon(
                              Icons.favorite,
                              size: 12,
                              color: Colors.red,
                            ),
                            Text(
                              'Username',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w200,
                                  fontSize: 12,
                                  color: Colors.black),
                            )
                          ],
                        ),
                      ),
                    ),
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
                                color: Colors.red,
                              ),),),
                            Text('1',style: TextStyle(color: Colors.black),),
                           SizedBox(
                            width: 10,
                          ),

                        ],
                      ),
                    ),

                  ],
                ),
                Container(
                  height: 100,
                  color: Colors.red,
                )
              ],
            ),
          ],
        ),
      )])),
    );
  }
}