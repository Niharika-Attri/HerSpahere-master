import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/Screen/home_screen.dart';
import 'Screen/intro_screen.dart';
import 'Utils/utils.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Fem Care',
          // You can use the library anywhere in the app even in theme
          theme:ThemeData(
                  primarySwatch: Colors.blue,
                  inputDecorationTheme: InputDecorationTheme(
                    filled: true,
                    fillColor: Colors.white38,
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: defpaultPadding * 1.2, horizontal: defpaultPadding),
                  ),
                ),
          // ThemeData(
          //   primarySwatch: Colors.blue,
          //   textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          //   inputDecorationTheme: InputDecorationTheme(
          //     filled: true,
          //     fillColor: Colors.white38,
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(8),
          //       borderSide: const BorderSide(color: Color.fromRGBO(255, 255, 51, 90))
          //     ),
          //     focusedBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(8),
          //         borderSide: const BorderSide(color: Color.fromRGBO(255, 255, 51, 90))
          //     ) ,
          //     enabledBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(8),
          //         borderSide: const BorderSide(color: Color.fromRGBO(255, 255, 51, 90))
          //     ) ,
          //     hintStyle: TextStyle(color: Colors.white),
          //     contentPadding: EdgeInsets.symmetric(
          //         vertical: defpaultPadding * 1.2, horizontal: defpaultPadding),
          //   ),
          // ),
          home:StreamBuilder(
            stream:FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot){
              if(snapshot.connectionState==ConnectionState.active){
                if(snapshot.hasData){
                  return const HomeScreen();
                }else if(snapshot.hasError){
                  return Center(child: Text('${snapshot.error}'),);

                }
              }else if(snapshot.connectionState==ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator(color: primaryColor,),);
              }
              return const IntroScreen();

            },
          ),
          // const IntroScreen(),
        );
      },

    );
  }
}


