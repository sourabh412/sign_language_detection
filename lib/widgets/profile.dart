import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 75,
            backgroundImage: NetworkImage(user.photoURL!),
          ),
          const SizedBox(height: 50,),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                user.displayName!.split(" ")[0],
                style: const TextStyle(
                  fontSize: 48,
                  fontFamily: 'cursive',
                ),
              ),
              const SizedBox(width: 10,),
              // CircleAvatar(
              //   backgroundImage: AssetImage("assets/icon_64.png"),
              //   radius: 10,
              // )
              const Icon(Icons.verified, color: Colors.blueAccent,)
            ],
          ),
          const SizedBox(height: 15,),
          Text(
            user.email!,
            style: const TextStyle(
              fontSize: 16,

            ),
          ),
          const SizedBox(height: 50,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(250, 50),
            ),
            onPressed: () => Fluttertoast.showToast(
              msg: "Work in Progress",
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(FontAwesomeIcons.instagram, color: Colors.pinkAccent,),
                  SizedBox(width: 30,),
                  Text("Instagram")
                ],
              ),
            ),
          ),
          const SizedBox(height: 25,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(250, 50),
            ),
            onPressed: () => Fluttertoast.showToast(
              msg: "Work in Progress",
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(FontAwesomeIcons.mugHot, color: Colors.pinkAccent,),
                  SizedBox(width: 30,),
                  Text("Support")
                ],
              ),
            ),
          ),
          const SizedBox(height: 25,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(250, 50),
            ),
            onPressed: () => Fluttertoast.showToast(
              msg: "Work in Progress",
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(FontAwesomeIcons.message, color: Colors.pinkAccent,),
                  SizedBox(width: 30,),
                  Text("Feedback")
                ],
              ),
            ),
          ),
        ]
      ),
    );
  }
}
