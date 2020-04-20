import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sally_smart/change_notifiers/account_notifier.dart';
import 'package:sally_smart/change_notifiers/cart_change_notifier.dart';
import 'package:sally_smart/screens/add_new_card/add_new_card.dart';
import 'package:sally_smart/services/payment_service.dart';
import 'package:sally_smart/services/square_payment_service.dart';
import 'screens/checkout_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  GetIt.I.registerSingleton<PaymentService>(SquarePaymentService());
  runApp(new Sally());
}

class Sally extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => CartNotifier()),
        ChangeNotifierProvider(
          create: (BuildContext context) => AccountNotifier(),
        )
      ],
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
            CheckoutScreen.id: (context) => CheckoutScreen(),
            AddNewCard.id: (context) => AddNewCard(),
          };

          return MaterialPageRoute(
              builder: (context) => routes[routeSettings.name](context));
        },
      ),
    );
  }
}
