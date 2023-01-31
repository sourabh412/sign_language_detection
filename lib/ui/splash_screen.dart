import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sign_lang_detect/services/google_sign_in.dart';
import 'package:sign_lang_detect/ui/home_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          Timer(
              const Duration(seconds: 3),
                  ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()))
          );
        }
        return Scaffold(
          backgroundColor: Colors.grey[900],
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black12, Colors.black12, Colors.blueAccent.withOpacity(0.1), ],

              ),
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/icon.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Text(
                    "Sign-Talk",
                    style: TextStyle(
                      fontSize: 60,
                      fontFamily: "cursive",
                      fontWeight: FontWeight.w900,
                      color: Colors.indigo[500],
                      fontStyle: FontStyle.italic,
                      letterSpacing: 5,
                    ),
                  ),
                  const SizedBox(height: 90,),
                  (!snapshot.hasData) ?
                  ElevatedButton.icon(
                    onPressed: (){
                      final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                      provider.googleLogin();
                    },
                    label: const Text(
                      "Sign In with Google",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    icon: const Icon(
                      FontAwesomeIcons.google,
                      color: Colors.red,
                    ),
                  ) :
                  SpinKitThreeBounce(
                    color: Colors.indigo[300],
                    size: 40,
                    duration: const Duration(milliseconds: 1000),
                  ),
                  const SizedBox(height: 60,),

                ],
              )
            ),
          ),
        );
      },
    );
  }
}
