import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falafel/views/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:falafel/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as devtools show log;

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _birthDate;
  late final TextEditingController _password;
  late final TextEditingController _city;
  late final TextEditingController _pnumber;
  late final TextEditingController _name;
  late final TextEditingController _sname;

  @override
  void initState() {
    _email = TextEditingController();
    _birthDate = TextEditingController();
    _password = TextEditingController();
    _city = TextEditingController();
    _pnumber = TextEditingController();
    _name = TextEditingController();
    _sname = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _birthDate.dispose();
    _password.dispose();
    _city.dispose();
    _pnumber.dispose();
    _name.dispose();
    _sname.dispose();
    super.dispose();
  }

  Future<void> userSetup(String uid, String email, String password, String name,
      String city, String sname, String pnumber, String birthDate) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('userSignInfo');
    users.add({
      'uid': uid,
      'email': email,
      'password': password,
      'city': city,
      'phone number': pnumber,
      'birthDate': birthDate,
      'name': name,
      'surname': sname
    }).then((value) => null);

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color.fromRGBO(59, 98, 48, 1) , title: Image.asset(
          'assets/images/beyazisim.png',
          fit: BoxFit.cover,
          height: 40,
        ),),
      body: Container(
        
        color: Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8),
                child: TextField(
                  decoration: const  InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: "İsim",
                        labelStyle: TextStyle(color: Color.fromRGBO(59, 98, 48, 1)),
                        border: OutlineInputBorder()),
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: _name,
                  
                ),
              ),
            ),
           
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8),
                child: TextField(
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: _sname,
                  decoration: const  InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: "Soyisim",
                        labelStyle: TextStyle(color: Color.fromRGBO(59, 98, 48, 1)),
                        border: OutlineInputBorder()),
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8),
                child: TextField(
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const  InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: "E-mail",
                        labelStyle: TextStyle(color: Color.fromRGBO(59, 98, 48, 1)),
                        border: OutlineInputBorder()),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8),
                child: TextField(
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: _password,
                  decoration: const  InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: "Şifre",
                        labelStyle: TextStyle(color: Color.fromRGBO(59, 98, 48, 1)),
                        border: OutlineInputBorder()),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8),
                child: TextField(
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  controller: _pnumber,
                  decoration: const  InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: "Telefon Numarası",
                        labelStyle: TextStyle(color: Color.fromRGBO(59, 98, 48, 1)),
                        border: OutlineInputBorder()),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8),
                child: TextField(
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),

                  keyboardType: TextInputType.datetime,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: _birthDate,
                  decoration: const  InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: "Doğum Günü (GG.AA.YYYY)",
                        labelStyle: TextStyle(color: Color.fromRGBO(59, 98, 48, 1)),
                        border: OutlineInputBorder()),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8),
                child: TextField(
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: _city,
                  decoration: const  InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: "Şehir",
                        
                        labelStyle: TextStyle(color: Color.fromRGBO(59, 98, 48, 1)),
                        border: OutlineInputBorder()),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(59 ,98 , 48, 1),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                
                try {
                  final userCredential =
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  showAlertDialogSuccesfulRegister(context);
                  final String uid = FirebaseAuth.instance.currentUser!.uid;
                  
                  userSetup(uid, _email.text, _password.text, _name.text,
                      _city.text, _sname.text, _pnumber.text, _birthDate.text);
                  devtools.log(userCredential.toString());
                  
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'email-already-in-use') {
                    showAlertDialogEmailExists(context);
                  } else if (e.code == 'weak-password') {
                    showAlertDialogWeakPassword(context);
                  } else if (e.code == 'invalid-email') {
                    showAlertDialogInvalidEmail(context);
                  }
                  
                }
              },
              child: const Text('Kayıt Ol'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login/',
                    (route) => false,
                  );
                },
                child: DefaultTextStyle.merge(
                    style: const TextStyle(color: Color.fromRGBO(59, 98, 48, 1)),
                      child: const Text(
                          'Hesabınız var mı? Buradan giriş yapın!')),
        )],
        ),
      ),
    );
  }
}

showAlertDialogEmailExists(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("Tamam"),
    onPressed: () { Navigator.of(context).pop(false);
                          },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Girdiğiniz e-mail zaten kullanılmaktadır."),
    content: Text("Lütfen başka bir e-mail giriniz."),
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

showAlertDialogWeakPassword(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("Tamam"),
    onPressed: () { Navigator.of(context).pop(false);
                          },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Şifre Kullanıma Uygun Değil"),
    content: Text("Lütfen en az 6 haneli bir şifre seçiniz."),
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
    title: Text("Geçersiz E-mail girdiniz."),
    content: Text("Lütfen E-mail'inizi düzeltip tekrar girin."),
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

showAlertDialogSuccesfulRegister(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("Devam Et"),
    onPressed: () { Navigator.of(context).pushNamedAndRemoveUntil(
                    '/verify/',
                    (route) => false,
                  );
                          },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Başarılı"),
    content: Text("Başarıyla kayıt oldunuz, e-mail doğrulama sayfasına yönlendiriliyorsunuz."),
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


showAlertDialogAllParts(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("Tamam"),
    onPressed: () { Navigator.of(context).pop(false);
                          },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Eksik Giriş Yaptınız. "),
    content: Text("Kayıt olmak için bütün alanların doldurulması zorunludur"),
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
