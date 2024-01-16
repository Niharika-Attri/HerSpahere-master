import 'package:flutter/material.dart';
class YogaEx extends StatefulWidget {
  const YogaEx({Key? key}) : super(key: key);

  @override
  State<YogaEx> createState() => _YogaExState();
}

class _YogaExState extends State<YogaEx> {
  final List<String> _listItem = [
    'assets/img/two.jpg',
    'assets/img/three.jpg',
    'assets/img/four.jpg',
    'assets/img/five.jpg',
    'assets/img/six.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        elevation: 0,
        leading: Icon(Icons.accessibility),
        title: Text("Exercises"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              width: 36,
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10)),
              child: Center(child: IconButton(onPressed: (){Navigator.pop(context);},
                icon: Icon(Icons.arrow_back),)),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage('assets/img/one.jpg'),
                        fit: BoxFit.fitWidth)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient:
                      LinearGradient(begin: Alignment.bottomRight, colors: [
                        Colors.black.withOpacity(.4),
                        Colors.black.withOpacity(.2),
                      ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "YOGA",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 40,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.transparent),
                        child: Center(
                            child: Text(
                              "Yoga maintains mental and physical wellbeing.",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: _listItem
                        .map((item) => Card(
                      color: Colors.transparent,
                      elevation: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: AssetImage(item),
                                fit: BoxFit.cover)),
                        child: Transform.translate(
                          offset: Offset(50, -50),
                        ),
                      ),
                    ))
                        .toList(),
                  ))
            ],
          ),
        ),
      ),
    );;
  }
}
