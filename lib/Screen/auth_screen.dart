import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled1/Screen/home_screen.dart';
import 'package:untitled1/Utils/utils.dart';


import '../Resource/auth_method.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin{
   bool _isShowSignUp=false,isLoading=false;
  late AnimationController _animationController;
  late Animation<double> _animation;
   final TextEditingController _emailControler=TextEditingController();
   final TextEditingController _passControler=TextEditingController();
   final TextEditingController _emailControlerSign=TextEditingController();
   final TextEditingController _passControlerSing=TextEditingController();
   final TextEditingController _passControlerCon=TextEditingController();
   final TextEditingController _userNameControler=TextEditingController();
   final TextEditingController _bioControler=TextEditingController();
   Uint8List? _image;


   @override
   void initState() {
     // TODO: implement initState
     super.initState();
     animationSetUp();
   }


   @override
   void dispose() {
     // TODO: implement dispose
     super.dispose();
     _animationController.dispose();
     _emailControler.dispose();
     _passControler.dispose();
     _emailControlerSign.dispose();
     _passControlerSing.dispose();
     _passControlerCon.dispose();
   }


   void signupUser () async {
     setState(() {
       isLoading=true;
     });
     String res = await FirestoreMethods().signUpUser(
       email: _emailControlerSign.text,
       password: _passControlerSing.text,
       username: _userNameControler.text,
       file: _image!,
     );

     print(res.toString());
     if(res=='success'){
       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const HomeScreen()));
     }
     debugPrintThrottled(res);
     setState(() {
       isLoading=false;
     });
   }

   void selectImage() async {
     Uint8List im = await pickImage(ImageSource.gallery);
     setState(() {
       _image = im ;
     });
   }


   void loginUser() async {
     setState(() {
       isLoading=true;
     });
     String res = await FirestoreMethods().loginUser(
       email: _emailControler.text,
       password: _passControler.text,
     );

     if(res=='Success'){
       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const HomeScreen()));
     }

     debugPrintThrottled(res);
     setState(() {
       isLoading=false;
     });
   }

   void animationSetUp(){
    _animationController=AnimationController(vsync: this,duration: defaultDuration);
    _animation=Tween<double>(begin: 0,end: 90).animate(_animationController);
  }

  void update(){
     setState(() {
       _isShowSignUp=!_isShowSignUp;
     });
     _isShowSignUp?_animationController.forward():_animationController.reverse();
  }



  @override
  Widget build(BuildContext context) {
    final _size= MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context,_) {

          return isLoading? Center(child: CircularProgressIndicator(),): Stack(
            children: [
              AnimatedPositioned(
                left:_isShowSignUp? -_size.width*0.76:0,
                width: _size.width*0.88,
                height: _size.height,
                 duration: defaultDuration,
                 child: Container(
                   color: login_bg,
                   child: Padding(
                     padding: EdgeInsets.symmetric(
                         horizontal: MediaQuery.of(context).size.width * 0.13),
                     child: Form(
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Spacer(),
                           TextFormField(
                             controller: _emailControler,
                             decoration: InputDecoration(
                               hintText: "Email",
                             ),
                           ),
                           Padding(
                             padding:  const EdgeInsets.symmetric(vertical: defpaultPadding),
                             child: TextFormField(
                               controller: _passControler,
                               obscureText: true,
                               decoration: InputDecoration(
                                 hintText: "Password",
                               ),
                             ),
                           ),
                           TextButton(
                             onPressed: () {},
                             child: Text(
                               "Forgot Password?",
                               style: TextStyle(color: Colors.white),
                             ),
                           ),
                           Spacer(flex: 2),
                         ],
                       ),
                     ),
                   ),
              ),
              ),

              AnimatedPositioned(
                left: _isShowSignUp?_size.width*0.12:_size.width*0.88,
                width: _size.width*0.88,
                height: _size.height,
                duration: defaultDuration,
                child: Container(
                  color: CupertinoColors.systemIndigo,
                  child:  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.13),
                    child: Form(
                      child: Column(
                        children: [
                          const SizedBox(height: 24,),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: defpaultPadding),
                            child: TextFormField(
                              controller: _userNameControler,
                              decoration: InputDecoration(
                                hintText: "Name",
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _emailControlerSign,
                            decoration: InputDecoration(
                              hintText: "Email",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: defpaultPadding),
                            child: TextFormField(
                              controller: _passControlerSing,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Password",
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _passControlerCon,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Confirm Password",
                            ),
                          ),
                          Spacer(flex: 2)
                        ],
                      ),
                    ),
                  ),
                ),
              ),



              // AnimatedPositioned(
              //   top: _size.height*0.1,
              //   left: 0,
              //   right: _isShowSignUp?-_size.width*0.06:_size.width*0.06,
              //   duration: defaultDuration,
              //   child: CircleAvatar(backgroundColor: Colors.white,
              //     radius: 35,
              //     child: Stack(
              //       children: [
              //         AnimatedSwitcher(
              //           duration: defaultDuration,
              //           child: _image!=null?InkWell(
              //             onTap: selectImage,
              //             child: CircleAvatar(
              //               radius: 35,
              //               backgroundImage: MemoryImage(_image!),
              //             ),
              //           )
              //               : Image.asset('assets/img/attachment_98127672 1.png',color: Colors.red,),
              //
              //         ),


              AnimatedPositioned(
                  top: _size.height*0.1,
                  left: 0,
                  right: _isShowSignUp?-_size.width*0.06:_size.width*0.06,
                  duration: defaultDuration,
                  child:_image==null? InkWell(
                    onTap: selectImage,
                    child: CircleAvatar(backgroundColor: Colors.white,
                      radius: 35,
                      child: Image.asset('assets/img/attachment_98127672 1.png',color: Colors.red,),
                    ),
                  ):CircleAvatar(radius: 35,
                    backgroundImage: MemoryImage(_image!),)),


                      // Positioned(
                      //   bottom: _size.height*0.1,
                      //   left: 0,
                      //   child: IconButton(onPressed: selectImage, icon: Icon(Icons.add_a_photo,color: Colors.black,),),),


              // Positioned(
              //   bottom: _size.height*0.1,
              //   width: _size.width,
              //   right: _size.width*0.06,
              //   child: ,),

              //login Animation
              AnimatedPositioned(
                left:_isShowSignUp?0: _size.width*0.44-80,
                  bottom:_isShowSignUp? _size.height/2-80:_size.height*0.3 ,
                  duration: defaultDuration,
                  child: DefaultTextStyle(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color:_isShowSignUp?Colors.white: Colors.pink,
                      fontSize: _isShowSignUp?20: 32,
                      fontWeight: FontWeight.bold
                  ),
                    child: Transform.rotate(
                      angle:-_animation.value* pi/180,
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap:(){
                          if(_isShowSignUp){
                            update();
                          }else{
                            loginUser;
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: _size.width*0.03),
                          width: 160,
                          child: InkWell(
                            onTap: loginUser,
                            child: const Text("LOG IN",style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ),
                    ),
                  )),

              //signUp Animation
              AnimatedPositioned(
                  right:_isShowSignUp?_size.width*0.44-80:0,
                  bottom:!_isShowSignUp? _size.height/2-80:_size.height*0.1 ,
                  duration: defaultDuration,
                  child: DefaultTextStyle(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color:_isShowSignUp?Colors.white: Colors.white70,
                        fontSize:! _isShowSignUp?20: 32,
                        fontWeight: FontWeight.bold
                    ),
                    child: Transform.rotate(
                      angle:(90-_animation.value)* pi/180,
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: (){
                          if(_isShowSignUp){
                            if(_passControlerSing.text==_passControlerCon.text){
                            signupUser();
                            }else{
                          }
                          }else{
                            update();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: _size.width*0.03),
                          width: 160,
                          child: const Text("SIGN UP",),
                        ),
                      ),
                    ),
                  ))

            ],
          );
        }
      ),
    );
  }
}