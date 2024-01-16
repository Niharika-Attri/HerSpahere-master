import 'package:flutter/material.dart';

import '../Utils/utils.dart';

class Consultance extends StatefulWidget {
  Consultance({Key? key}) : super(key: key);

  @override
  State<Consultance> createState() => _ConsultanceState();
}

class _ConsultanceState extends State<Consultance> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.arrow_back)),
        title: Text("Consultance(Gynicologist)"),
        backgroundColor: login_bg,
      ),
      body: Center(
          child: GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),

            primary: false,
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                child: Column(

                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(
                          "https://www.shutterstock.com/image-vector/woman-doctor-icon-female-physician-260nw-415771153.jpg"),
                    ),
                    const Text('Dr.Shilpi Ghare\nPhone: 099586 79039',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.call))
                  ],
                ),
                decoration: BoxDecoration(
                    color: login_bg,
                    borderRadius: BorderRadius.circular(10)),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(
                          "https://www.shutterstock.com/image-vector/woman-doctor-icon-female-physician-260nw-415771153.jpg"),
                    ),
                    const Text('Dr Shakuntla Kumar\nPhone:  011 4700 5555',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.call))
                  ],
                ),
                decoration: BoxDecoration(
                    color: login_bg,
                    borderRadius: BorderRadius.circular(10)),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(
                          "https://www.shutterstock.com/image-vector/woman-doctor-icon-female-physician-260nw-415771153.jpg"),
                    ),
                    const Text('Dr. Ritu Gupta\nPhone: 098107 38167',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 19)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.call))
                  ],
                ),
                decoration: BoxDecoration(
                    color: login_bg,
                    borderRadius: BorderRadius.circular(10)),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(
                          "https://www.shutterstock.com/image-vector/woman-doctor-icon-female-physician-260nw-415771153.jpg"),
                    ),
                    const Text('Dr Pujas Clinic\nPhone:  098994 16040',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 19)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.call))
                  ],
                ),
                decoration: BoxDecoration(
                    color: login_bg,
                    borderRadius: BorderRadius.circular(10)),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(
                          "https://www.shutterstock.com/image-vector/woman-doctor-icon-female-physician-260nw-415771153.jpg"),
                    ),
                    const Text('Dr Priya Agarwal\nPhone: 099909 53485',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 19)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.call))
                  ],
                ),
                decoration: BoxDecoration(
                    color: login_bg,
                    borderRadius: BorderRadius.circular(10)),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(
                          "https://www.shutterstock.com/image-vector/woman-doctor-icon-female-physician-260nw-415771153.jpg"),
                    ),
                    const Text('Dr Pooja Choudhary\nPhone: 093138 78998',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 19)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.call))
                  ],
                ),
                decoration: BoxDecoration(
                    color: login_bg,
                    borderRadius: BorderRadius.circular(10)),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(
                          "https://www.shutterstock.com/image-vector/woman-doctor-icon-female-physician-260nw-415771153.jpg"),
                    ),
                    const Text('Dr Mayur Dass\nPhone: 099728 99728',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 19)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.call))
                  ],
                ),
                decoration: BoxDecoration(
                    color: login_bg,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ],
          )),
    );
  }
}