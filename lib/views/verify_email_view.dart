import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falafel/views/login_view.dart';
import 'package:falafel/views/register_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as devtools show log;

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Image.asset(
          'assets/images/beyazisim.png',
          fit: BoxFit.cover,
          height: 40,
        ),
        backgroundColor: Color.fromRGBO(59, 98, 48, 1),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 200, left: 30, right: 30,bottom: 350),
            color: Colors.white,
            child: Center(
              child: Column(
                children: [
                  const Padding(
                    
                    padding:  EdgeInsets.only(top:50),
                    
                    child:  Text('Lütfen e-mail\'inizi doğrulayınız'),
                    
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(59 ,98 , 48, 1),
                  textStyle: const TextStyle(
                    fontSize: 14,
                  )),
                        onPressed: () async {
                          final user = FirebaseAuth.instance.currentUser;
                          await user!.sendEmailVerification();
                          showAlertDialog(context);
                        },
                        child: const Text('E-mail doğrulama kodunu gönder')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login/',
                            (route) => false,
                          );
                        },
                        child:  DefaultTextStyle.merge(
                    style: const TextStyle(color: Color.fromRGBO(59, 98, 48, 1)),
                      child: const Text(
                          'Çıkış Yap'),),
                  ),
              )],
              ),
            ),
          ),
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
        title: const Text('E-mail\'inize Doğrulama Linki Gönderildi.'),
        content: const Text('Linke tıkladıktan sonra tekrar giriş yapın.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Tamam.'),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}

showAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("Anladım"),
    onPressed: () { Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login/',
                            (route) => false,
                          );
                          },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Email onaylama linki gönderilmiştir."),
    content: Text("Linke tıklayıp e-mailinizi onayladıktan sonra lütfen tekrar giriş yapınız"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
