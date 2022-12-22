import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falafel/views/verify_email_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:falafel/firebase_options.dart';
import 'dart:developer' as devtools show log;

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //atma Light ekle
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Color.fromRGBO(59, 98, 48, 1),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          
          children: [
            
             Padding(
               padding: const EdgeInsets.only(top:16.0,bottom:16),
               child: Image.asset(
            'assets/images/logo2.png',
            fit: BoxFit.contain,
          ),
             ),
            Container(
              
              color: Colors.white,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  margin: EdgeInsets.only( left: 30, right: 30, bottom: 30),
                  child: Column(
                    children: [
                       Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          enableSuggestions: false,
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            controller: _email,
                          decoration: const  InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              labelText: "E-mail",
                              labelStyle: TextStyle(color: Color.fromRGBO(59, 98, 48, 1)),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child:  Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            enableSuggestions: false,
                            autocorrect: false,
                            obscureText: true,
                            keyboardType: TextInputType.emailAddress,
                            controller: _password,
                            decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                color: Color.fromRGBO(59, 98, 48, 1))),
                                labelText: "Şifre",
                                labelStyle: TextStyle(color: Color.fromRGBO(59, 98, 48, 1)),
                                border: OutlineInputBorder()),
                                
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(59, 98, 48, 1),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        onPressed: () async {
                          final email = _email.text;
                          final password = _password.text;
                          try {
                            await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: email,
                              password: password,
                            );
                            final user = FirebaseAuth.instance.currentUser;
                            if (user!.emailVerified) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                '/recipe/',
                                (route) => false,
                              );
                            } else {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                '/verify/',
                                (route) => false,
                              );
                            }
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              showAlertDialogUserNotFound(context);
                            } else if (e.code == 'wrong-password') {

                            }
                          }
                        },
                        child: const Text('Giriş Yap'),
                      ),
                      TextButton(
                        onPressed: () {
                        },
                        child: DefaultTextStyle.merge(
                          style: const TextStyle(color: Color.fromRGBO(59, 98, 48, 1)),
                            child: const Text(
                                'Şifremi Unuttum')),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/register/',
                            (route) => false,
                          );
                        },
                        child: DefaultTextStyle.merge(
                          style: const TextStyle(color: Color.fromRGBO(59, 98, 48, 1)),
                            child: const Text(
                                'Kayıtlı değil misiniz? Buradan kayıt olun!')),
                      ),
                      
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


showAlertDialogUserNotFound(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("Tamam"),
    onPressed: () { Navigator.of(context).pop(false);
                          },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Kullanıcı Bulunamadı"),
    content: Text("Bu mail ile kayıtlı bir hesap yok. Lütfen başka bir mail deneyiniz."),
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
showAlertDialogInvalidEmail(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("Tamam"),
    onPressed: () { Navigator.of(context).pop(false);
                          },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Şifre Yanlış"),
    content: Text("Lütfen Doğru şifreyi giriniz."),
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

