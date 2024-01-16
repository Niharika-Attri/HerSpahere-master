import 'package:flutter/material.dart';
import 'package:untitled1/Utils/utils.dart';
class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   var _size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),

      body: Column(
        children: [
          Text('Good morning',style: textTheme.headlineSmall,),
          const Text('UserName'),
          Container(
            height: _size.height*.25,
            decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: const Center(child: Text('Community Post Of The Day',style: TextStyle(color: Colors.white),)),
          ),
          Text('Recent Post',style: textTheme.titleSmall,),
          Container(
            height: _size.height*.25,
            decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: const Center(child: Text('Community Post Of The Day',style: TextStyle(color: Colors.white),)),
          ),
          Text('Nearby Doctors',style: textTheme.headlineMedium,),
          ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Card(
                child: Column(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 24,
                    ),
                    Text('Dr Ajay Kumar'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(Icons.star),

                      ],
                    )
                  ],
                ),
              )
            ],
          )

        ],
      ),
    );
  }
}
