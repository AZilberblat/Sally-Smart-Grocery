import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sally_smart/change_notifiers/account_notifier.dart';
import 'package:sally_smart/change_notifiers/cart_change_notifier.dart';
import 'package:sally_smart/models/order.dart';
import 'package:sally_smart/screens/widgets/edit_address_dialog.dart';
import 'package:sally_smart/screens/widgets/section.dart';
import 'package:sally_smart/services/payment_service.dart';
import 'package:sally_smart/utilities/constants.dart';
import 'package:sally_smart/utilities/extensions.dart';
import 'package:sally_smart/utilities/no_scroll_behavior.dart';

class CheckoutScreen extends StatefulWidget {
  static const String id = 'checkout_screen';

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  static const double _appBarHeight = 150;
  static const orderCardPadding = _appBarHeight - 70;

  bool submittingOrder = false;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoScrollBehavior(),
      child: Consumer2<AccountNotifier, CartNotifier>(
        builder: (BuildContext context, AccountNotifier accountNotifier,
            CartNotifier cart, Widget child) {
          final Order order = Order(
            products: cart.shoppingList,
            time: Timestamp.now(),
            billingAddress: accountNotifier.user.primaryBillingAddress,
          );
          return Stack(
            children: <Widget>[
              Scaffold(
                backgroundColor: Color(0xFF21bacf),
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(_appBarHeight),
                  child: Container(
                    height: _appBarHeight,
                    alignment: Alignment.center,
                    child: AppBar(
                      elevation: 3,
                      centerTitle: true,
                      backgroundColor: Colors.black54,
                      flexibleSpace: Container(
                        alignment: Alignment.center,
                        height: _appBarHeight - 30,
                        child: Text(
                          'Checkout',
                          style: kHeaderTextStyle,
                        ),
                      ),
                    ),
                  ),
                ),
                body: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xFF21bacf),
                      Color(0xFF027a8b),
                      Color(0xFF046D7D)
                    ], stops: [
                      0.1,
                      0.3,
                      0.7,
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  ),
                  child: Center(
                    child: Hero(
                      tag: 'Sally',
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage('images/missing_avatar_F.png'),
                        maxRadius: 140,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: orderCardPadding),
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: OrderCard(
                        order: order,
                        isLoading: submittingOrder,
                        onContinue: submittingOrder
                            ? null
                            : (Order order) async {
                                setState(() {
                                  submittingOrder = true;
                                });

                                //TODO: Re-enable
//                                await accountNotifier.orderManager
//                                    .createOrder(order);
//                                await cart.stateChangeStream.stream.first;
                                setState(() {
                                  submittingOrder = false;
                                });
                                Navigator.of(context).pop();
                              },
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final AsyncValueSetter<Order> onContinue;
  final bool isLoading;

  OrderCard({
    Key key,
    @required this.order,
    @required this.onContinue,
    @required this.isLoading,
  }) : super(key: key);

  final Order order;

  static const double orderIdLabelFontSize = 18;
  static const orderIdFontSize = orderIdLabelFontSize - 3;
  static const TextStyle productsTextStyle =
      const TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
  static const TextStyle productNameTextStyle =
      const TextStyle(color: Colors.black);

  final Color buttonColor = Colors.green;
  final Color splashColor = Colors.grey[400];
  final String ccNumber = CreditCardNumber.masterCard;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
          color: Colors
              .black), // for some reason, this has no effect on the children.
      child: Builder(
        builder: (BuildContext context) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            elevation: 10,
            color: Colors.white,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 50),
              width: MediaQuery.of(context).size.width / 0.65,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text.rich(
                      TextSpan(
                        text: 'Your Order ID: ',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.black,
                            fontSize: orderIdLabelFontSize),
                        children: [
                          TextSpan(
                            text: order.id ?? 'Pending...',
                            style:
                                Theme.of(context).textTheme.subtitle1.copyWith(
                                      color: Colors.black,
                                      fontSize: orderIdFontSize,
                                      fontWeight: FontWeight.w300,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  DashedDivider(
                    height: 80,
                  ),
                  Section(
                    title: 'Products:',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (final product in order.products)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  product.name,
                                  style: productNameTextStyle,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Qty: ${product.quantity}',
                                  style: productNameTextStyle,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '${product.price}$israeliNewShekelSign',
                                  style: productsTextStyle,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ]),
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Spacer(),
                                    Flexible(child: DashedDivider())
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: Text(
                                    'Total: ${order.total.toStringAsFixed(2)}$israeliNewShekelSign',
                                    style: productsTextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  DashedDivider(),
                  Section(
                    title: 'Billing Address:',
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 40),
                    action: FlatButton(
                      child: Text(
                        'Edit',
                        style: TextStyle(color: buttonColor),
                      ),
                      onPressed: () async {
                        final address = await showEditAddressDialog(
                          context,
                          existingAddress: order.billingAddress,
                        );
                        final accountNotifier = Provider.of<AccountNotifier>(
                            context,
                            listen: false);
                        if (address != null) {
                          accountNotifier.updateUser(accountNotifier.user
                              .copyWith(primaryBillingAddress: address));
                        }
                      },
                      splashColor: splashColor,
                    ),
                    child: order.billingAddress
                            ?.toWidget(style: productNameTextStyle) ??
                        Container(),
                  ),
                  DashedDivider(),
                  Section(
                    title: 'Card Details:',
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 40),
                    action: FlatButton(
                      child: Text(
                        'Edit',
                        style: TextStyle(color: buttonColor),
                      ),
                      onPressed: () async {},
                      splashColor: splashColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Flexible(flex: 1, child: _getCCIcon(ccNumber)),
                              Expanded(
                                flex: 4,
                                child: Text(
                                  obscureCardNumber(cardNumber: ccNumber),
                                  style:
                                      productsTextStyle.copyWith(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Container(
                        height: 30,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            if (isLoading)
                              AspectRatio(
                                  aspectRatio: 1,
                                  child: CircularProgressIndicator()),
                            FlatButton(
                              onPressed: onContinue == null
                                  ? null
                                  : () async {
                                      await onContinue(order);
                                    },
                              child: Text(
                                'Continue',
                                style: TextStyle(color: buttonColor),
                              ),
                              splashColor: splashColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _getCCIcon(String ccNumber) {
    final CreditCardType ccType = detectCCType(ccNumber);
    Widget icon;
    const double ccIconSize = 50.0;
    const Color iconColor = Colors.black;
    switch (ccType) {
      case CreditCardType.visa:
        icon = Icon(
          FontAwesomeIcons.ccVisa,
          size: ccIconSize,
          color: iconColor,
        );
        break;

      case CreditCardType.amex:
        icon = Icon(
          FontAwesomeIcons.ccAmex,
          size: ccIconSize,
          color: iconColor,
        );
        break;
      case CreditCardType.mastercard:
        icon = Icon(
          FontAwesomeIcons.ccMastercard,
          size: ccIconSize,
          color: iconColor,
        );
        break;

      case CreditCardType.discover:
        icon = Icon(
          FontAwesomeIcons.ccDiscover,
          size: ccIconSize,
          color: iconColor,
        );
        break;

      default:
        icon = Container(
          color: Color(0x00000000),
        );
    }
    return icon;
  }
}

class DashedDivider extends StatelessWidget {
  final double height;

  const DashedDivider({
    Key key,
    this.height = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.center,
      child: Text(
        '- - ' * 30,
        overflow: TextOverflow.clip,
        softWrap: false,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.w100),
      ),
    );
  }
}

class CreditCardNumber {
  static const masterCard = '5500 0000 0000 0004';
  static const americanExpress = '3400 0000 0000 009';
  static const dinersClub = '3000 0000 0000 04';
  static const carteBlanche = '3000 0000 0000 04';
  static const discover = '6011 0000 0000 0004';
  static const enRoute = '2014 0000 0000 009';
  static const JCB = '3088 0000 0000 0009';
  static const visa = '4111 1111 1111 1111';
}

String obscureCardNumber({String obscureCharacter = '•', String cardNumber}) {
  assert(obscureCharacter != null);
  List<String> chars = [];
  for (var i = 0; i < cardNumber.length; ++i) {
    final char = cardNumber[i];
    if (i < cardNumber.length - 4) {
      if (char != ' ') {
        chars.add(obscureCharacter);
      } else {
        chars.add(' ');
      }
    } else {
      chars.add(char);
    }
  }
  return chars.join();
}
