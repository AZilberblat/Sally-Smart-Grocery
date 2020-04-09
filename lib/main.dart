import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sally_smart/change_notifiers/cart_change_notifier.dart';
import 'screens/checkout_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/welcome_screen.dart';

//void main() => runApp(Sally());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(new Sally());
}

class Sally extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => CartNotifier(),
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          backgroundColor: Colors.teal,
          cardColor: Color(0xFF068194),
        ),
        initialRoute: LoginScreen.id,
        onGenerateRoute: (RouteSettings routeSettings) {
          var routes = {
            WelcomeScreen.id: (context) =>
                WelcomeScreen(uid: routeSettings.arguments),
            RegistrationScreen.id: (context) => RegistrationScreen(),
            LoginScreen.id: (context) => LoginScreen(),
            CheckoutScreen.id: (context) => CheckoutScreen()
          };

          return MaterialPageRoute(
              builder: (context) => routes[routeSettings.name](context));
        },
      ),
    );
  }
}
