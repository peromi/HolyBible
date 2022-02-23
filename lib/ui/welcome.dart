import 'package:animate_do/animate_do.dart';
import 'package:bible/ui/books.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.purple.shade900,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.purple.shade900,
      systemNavigationBarIconBrightness: Brightness.light
    ));
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom, SystemUiOverlay.top]);
    return
      Material(
      color: Colors.purple.shade900,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/cross.png", width: 80,),
                Text("HOLY BIBLE", style: GoogleFonts.righteous(fontSize: 58,letterSpacing: -3, fontWeight: FontWeight.w900,color: Colors.white),),
                Text("      Study to show yourself approved..",style: TextStyle(color: Colors.white, fontSize: 12),),
                SizedBox(height: 80,),
                 ZoomIn(duration:Duration(seconds: 2),child: SizedBox(
                   height: 44,
                     width: 180,
                     child: MaterialButton(onPressed: (){
                       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Books(),), (route) => false);
                     }, child: Text("Start Here".toUpperCase()), color: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(56)),)))
              ],
            ),
          ),
          Positioned(
            bottom: 20,
              left: 0,

right: 0,              child: Container(
            child: Center(child: Text("Developed with love by Peromi.", style: TextStyle(color: Colors.white, fontSize: 12),)),
          ))
        ],
      ),
    );
  }
}
