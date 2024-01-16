import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';


TextTheme textTheme = TextTheme(
  headline1: GoogleFonts.roboto(
      fontSize: 48.sp, fontWeight: FontWeight.w700, color: Colors.white),
  headline2: GoogleFonts.poppins(
      fontSize: 58, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3: GoogleFonts.poppins(fontSize: 46, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.poppins(
      fontSize: 33, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.poppins(
      fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.poppins(
      fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.white),
  subtitle2: GoogleFonts.poppins(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.poppins(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.poppins(
      fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: const Color.fromARGB(255, 19, 143, 120),
    backgroundColor: const Color.fromARGB(255, 19, 143, 120),
  ),
  caption: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.poppins(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
const Color login_bg = Color(0xFFFFB6C1);
const Color signup_bg = Color(0xFF2F82FF);
const mobileBackgroundColor = Color.fromRGBO(248, 241, 241, 1.0);
const webBackgroundColor = Color.fromRGBO(18, 18, 18, 1);
const mobileSearchColor = Color.fromRGBO(38, 38, 38, 1);
const blueColor = Color.fromRGBO(0, 149, 246, 1);
const primaryColor = Color.fromRGBO(182, 133, 136, 1.0);
const secondaryColor = Colors.grey;
const textColor = Color.fromRGBO(217, 217, 217, 1.0);
const headerColor = Color.fromRGBO(99, 77, 77, 1.0);

const double defpaultPadding = 16.0;
const Duration defaultDuration = Duration(milliseconds: 500);

ButtonStyle btnStyle(Color txtColor, Color bgColor ) {
  return ButtonStyle(
      foregroundColor:MaterialStateProperty.all(txtColor) ,
      backgroundColor:MaterialStateProperty.all(bgColor)
  );
}

pickImage(ImageSource source) async{
  final ImagePicker imagePicker =ImagePicker();
  XFile? _file = await imagePicker.pickImage(source: source);
  if(_file!=null){
    return await _file.readAsBytes();
  }
  print("Image Not Selected");
}
