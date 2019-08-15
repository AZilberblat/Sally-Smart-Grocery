import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sally_smart/screens/welcome_screen.dart';
import 'package:sally_smart/utilities/constants.dart';
import 'package:sally_smart/utilities/scan_button_const.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool passwordNotMatch = true;
  String email;
  String password;
  IconData passwordIcon = Icons.loop;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.black54,
        leading: Icon(
          Icons.shopping_basket,
          size: 30,
        ),
        title: Text(
          'Sally - הרשמה',
          textAlign: TextAlign.right,
          style: kHeaderTextStyle,
        ),
      ),
      backgroundColor: Color(0xFF21bacf),
      body: Container(
        decoration: kBackgroundGradientRegister,
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Hero(
                    tag: 'Sally',
                    child: CircleAvatar(
                      maxRadius: 70,
                      backgroundImage:
                          AssetImage('images/missing_avatar_F.png'),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 18.0,
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          prefixIcon: Icon(Icons.email),
                          hintText: 'הכנס כתובת דואר אלקטרוני'),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      obscureText: true,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          prefixIcon: Icon(Icons.lock_open),
                          hintText: 'הכנס סיסמא'),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      obscureText: true,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        setState(() {
                          if (password != value) {
                            passwordNotMatch = true;
                            passwordIcon = Icons.clear;
                          } else {
                            passwordNotMatch = false;
                            passwordIcon = Icons.check;
                          }
                        });
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          prefixIcon: Icon(passwordIcon),
                          hintText: ' וודא סיסמא'),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    ScanMainButton(
                      buttonText: 'הרשמה מהירה',
                      iconData: Icons.border_color,
                      color: Color(0xFF21bacf),
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          if (newUser != null) {
                            Navigator.pushNamed(context, WelcomeScreen.id);
                          }

                          setState(() {
                            showSpinner = false;
                          });
                        } catch (e) {
                          print(e);
                          print('An Error has occured');
                          setState(() {
                            showSpinner = false;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
