import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/scan_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/login_screen.dart';
import 'screens/checkout_screen.dart';

void main() => runApp(Sally());

class Sally extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        ScanScreen.id: (context) => ScanScreen(),
        CheckoutScreen.id: (context) => CheckoutScreen()
      },
    );
  }
}
