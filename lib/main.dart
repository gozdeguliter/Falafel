import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falafel/views/login_view.dart';
import 'package:falafel/views/register_view.dart';
import 'package:falafel/views/verify_email_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as devtools show log;
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RecipeView(),
      routes: {
        '/recipe/': (context) => const RecipeView(),
        '/login/': ((context) => const LoginView()),
        '/register/': ((context) => const RegisterView()),
        '/verify/': ((context) => const VerifyEmailView()),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                return const RecipeView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

enum MenuAction { logout }

class RecipeView extends StatefulWidget {
  const RecipeView({super.key});

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/beyazisim.png',
          fit: BoxFit.cover,
          height: 40,
        ),
        backgroundColor: Color.fromARGB(255, 135, 176, 129),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, right: 10),
            child: PopupMenuButton<MenuAction>(
              child: Text("Menü"),
              onSelected: (value) async {
                switch (value) {
                  case MenuAction.logout:
                    final shouldLogOut = await showLogOutDialog(context);
                    if (shouldLogOut) {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/login/',
                        (_) => false,
                      );
                    } else {}
                    break;
                }
              },
              itemBuilder: (context) {
                return const [
                  PopupMenuItem<MenuAction>(
                    value: MenuAction.logout,
                    child: Text('Çıkış Yap'),
                  )
                ];
              },
            ),
          )
        ],
      ),
      body: Form(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0,bottom:10),
              child: Container(
                color: const Color.fromARGB(255, 255, 212, 84),
                height: 50.0,
                width: 200.0,
                child: const Center(
                    child: Text("Bugünün Tarifi",
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top:10, bottom:10),
              child: Container(
                height: 100.0,
                width: 300.0,
                  child: Image.asset(
                "assets/images/1.png",
              )),
            ),
            // CircleAvatar(radius:90.0,
            //backgroundImage: AssetImage("images/falafel.PNG"),),
           
            Padding(
              padding: const EdgeInsets.only(top:20, bottom:10),
              child: Container(
                color: Color.fromARGB(255, 255, 212, 84),
                height: 50.0,
                width: 200.0,
                child: const  Align(
                    alignment: Alignment.centerLeft,
                    child: Center(
                        child: Text("En Sevilenler",
                            style: TextStyle(fontWeight: FontWeight.bold)))),
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(top:10, bottom:10),
              child: Container(
                height: 100.0,
                width: 300.0,
                  child: Image.asset(
                "assets/images/2.png",
              )),
            ),
            // CircleAvatar(radius:90.0,
            //backgroundImage: AssetImage("images/falafel.PNG"),),
           
             Padding(
              padding: const EdgeInsets.only(top:10, bottom:10),
              child: Container(
                height: 100.0,
                width: 300.0,
                  child: Image.asset(
                "assets/images/3.png",
              )),
            ),
            // CircleAvatar(radius:90.0,
            //backgroundImage: AssetImage("images/falafel.PNG"),),
           
            // CircleAvatar(radius:90.0,
            //backgroundImage: AssetImage("images/falafel.PNG"),),
             Padding(
              padding: const EdgeInsets.only(top:10, bottom:10),
              child: Container(
                height: 100.0,
                width: 300.0,
                  child: Image.asset(
                "assets/images/4.png",
              )),
            ),
            // CircleAvatar(radius:90.0,
            //backgroundImage: AssetImage("images/falafel.PNG"),),
           
            SizedBox(height: 120.0),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          child: MaterialButton(
                              child: Text("Anasayfa"), onPressed: () {}))),
                  MaterialButton(child: Text("Arama"), onPressed: () {}),
                  MaterialButton(child: Text("Likes"), onPressed: () {}),
                  MaterialButton(child: Text("Profil"), onPressed: () {}),
                ])
          ],
        ),
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Çıkış Yap'),
        content: const Text(
            'Üyeliğinizden çıkış yapmak istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Hayır'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Evet'),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
