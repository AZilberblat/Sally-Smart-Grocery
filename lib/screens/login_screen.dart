import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:sally_smart/change_notifiers/account_notifier.dart';
import 'package:sally_smart/screens/welcome_screen.dart';
import 'package:sally_smart/utilities/constants.dart';
import 'package:sally_smart/utilities/scan_button_const.dart';

import 'registration_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool login = false;
  bool showSpinner = false;
  String email =
      kDebugMode ? 'avizilberblat@gmail.com' : null; //TODO: Remove credentials
  String password = kDebugMode ? '123456' : null;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF21bacf),
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.black54,
        leading: Icon(
          Icons.shopping_basket,
          size: 30,
        ),
        title: Text(
          'Sally - התחברות',
          textAlign: TextAlign.right,
          style: kHeaderTextStyle,
        ),
      ),
      body: Container(
        decoration: kBackgroundGradientScan,
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
                    ScanMainButton(
                      buttonText: !login ? 'התחברות' : 'הרשמה',
                      iconData: !login ? Icons.extension : Icons.create,
                      color: Color(0xFF0F7DC6),
                      onPressed: () {
                        setState(() {
                          login ? login = false : login = true;
                        });
                      },
                    ),
                    Visibility(
                      visible: login,
                      child: Column(
                        children: <Widget>[
                          TextField(
                            controller: kDebugMode
                                ? TextEditingController(text: email)
                                : null,
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
                            controller: kDebugMode
                                ? TextEditingController(text: '123456')
                                : null,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              password = value;
                            },
                            decoration: kTextFieldDecoration.copyWith(
                                prefixIcon: Icon(Icons.lock_open),
                                hintText: 'הכנס סיסמא'),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          ScanMainButton(
                            buttonText: 'התחבר',
                            iconData: Icons.arrow_forward,
                            color: Color(0xFF21bacf),
                            onPressed: () async {
                              setState(() {
                                showSpinner = true;
                              });
                              try {
                                final existingUser =
                                    await _auth.signInWithEmailAndPassword(
                                        email: email, password: password);
                                final uid = existingUser.user.uid;

                                await Provider.of<AccountNotifier>(context,
                                        listen: false)
                                    .initialize(uid);

                                if (existingUser != null) {
                                  Navigator.pushNamed(context, WelcomeScreen.id,
                                      arguments: uid);
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
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: !login,
                  child: ScanMainButton(
                    buttonText: 'עדיין לא רשום? להרשמה',
                    iconData: Icons.border_color,
                    color: Color(0xFF21bacf),
                    onPressed: () {
                      Navigator.pushNamed(context, RegistrationScreen.id);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
