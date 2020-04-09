import 'package:audioplayers/audio_cache.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:sally_smart/change_notifiers/cart_change_notifier.dart';
import 'package:sally_smart/screens/login_screen.dart';
import 'package:sally_smart/screens/registration_screen.dart';
import 'package:sally_smart/utilities/constants.dart';
import 'package:sally_smart/utilities/product.dart';
import 'package:sally_smart/utilities/product_card.dart';
import 'package:sally_smart/utilities/scan_button_const.dart';
import 'package:sally_smart/utilities/scan_methods.dart';


//working version

//List<ProductCard> shoppingList = [];
final sallyDatabase = Firestore.instance;

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  final String uid;
  WelcomeScreen({@required this.uid});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _auth = FirebaseAuth.instance;

  final textEditorController = TextEditingController();
  String _scanBarcode = 'Unknown';
  String productName = 'Product Test';
  double productPrice;
  String productBarCode;
  IconData productIcon = Icons.add_shopping_cart;
  int productId = 0;
  static AudioCache barcodeSound = AudioCache();

  // saves barcodes data
  List<String> data = [];

  Future<void> initPlatformState() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes =
          await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancel", true);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }
  @override
    void initState() {
      super.initState();
      Provider.of<CartNotifier>(context, listen: false).setUserDocument(uid: widget.uid);
    }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartNotifier>(
      builder: (BuildContext context, CartNotifier shoppingList, Widget child) {
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
                'Sally',
                textAlign: TextAlign.end,
                style: kHeaderTextStyle,
              ),
              actions: <Widget>[
                IconButton(icon: Icon(Icons.settings), onPressed: () {}),
                VerticalDivider(
                  color: Color(0x8CFFFFFF),
                  width: 3,
                ),
                IconButton(
                    icon: Icon(Icons.power_settings_new),
                    onPressed: () {
                      _auth.signOut();
                      Navigator.pushNamed(context, LoginScreen.id);
                    }),
                VerticalDivider(
                  color: Color(0x8CFFFFFF),
                  width: 3,
                ),
                IconButton(icon: Icon(Icons.share), onPressed: () {}),
                VerticalDivider(
                  color: Color(0x8CFFFFFF),
                  width: 3,
                ),
//            PopupMenuButton(itemBuilder: ),
              ],
            ),
            body: Container(
              decoration: kBackgroundGradientScan,
              child: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'ברוכה הבאה, סאלי',
                            textAlign: TextAlign.right,
                            style: kHeaderTextStyle,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5, right: 15),
                            child: Hero(
                              tag: 'Sally',
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('images/missing_avatar_F.png'),
                                maxRadius: 25,
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                        child: TextField(
                          textAlign: TextAlign.center,
                          onChanged: (value) async {
                            //TODO: You may be interested in debouncing this.
//                        TODO: How many times does this run? if it's on the onChanged method, each time a new letter is entered, this will call firestore
                            //TODO: This has the potential to cause a LOT of writes if the users starts entering things manually
                            _scanBarcode = value;
                            productPrice = await getProductPrice(_scanBarcode);
                            productName = await getProductName(_scanBarcode);
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              prefixIcon: IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () {
                                  _scanBarcode = '';
                                  textEditorController.clear();

                                  try {
                                    setState(() {
                                      textEditorController.clear();
                                      //checking if a product was already scanned

                                      //adding a ProductCard to the shopping list with the ProductCard const. Works on scan

                                      shoppingList.add(
                                        Product(
                                          barCode: productBarCode,
                                          id: shoppingList.length,
                                          name: productName,
                                          price: productPrice,
                                          documentReference: null
                                        ),
                                      );
                                    });
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                              ),
//                          prefix: IconButton(
//                              icon: Icon(Icons.search),
//                              onPressed: () {
//
//                              }),
                              hintText: '...הכנס ברקוד או שם מוצר ידנית'),
                        ),
                      ),
                      DividerSally(),
                      shoppingListBuilder(shoppingList),
                      DividerSally(),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 15.0),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              children: <Widget>[
                                ScanMainButton(
                                  iconData: Icons.flip,
                                  buttonText: 'סרוק מוצר',
                                  onPressed: () async {
                                    //Navigator.pushNamed(context, ScanScreen.id);

                                    await initPlatformState();
                                    barcodeSound.play('barcode_sound.mp3');

                                    //Changes the product name by referencing to the database
                                    productBarCode = _scanBarcode;
                                    productPrice =
                                        await getProductPrice(_scanBarcode);
                                    productName =
                                        await getProductName(_scanBarcode);

                                    //checking if a product was already scanned

                                    //adding a ProductCard to the shopping list with the ProductCard const. Works on scan

                                    shoppingList.add(
                                      Product(
                                        barCode: productBarCode,
                                        id: shoppingList.length,
                                        name: productName,
                                        price: productPrice,
                                       documentReference: null
                                      ),
                                    );
                                  },
                                  color: Colors.teal,
                                ),
                                ScanMainButton(
                                    iconData: Icons.check,
                                    buttonText: 'מעבר לתשלום',
                                    color: Colors.green,
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, RegistrationScreen.id);
                                    }),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }

  Expanded shoppingListBuilder(CartNotifier cart) {
    return Expanded(
        child: Container(
      color: Colors.black38,
      child: ListView.builder(
        reverse: true,
        itemCount: cart.length,
        itemBuilder: (context, index) {
          Product item = cart.shoppingList[index];
          return Dismissible(
              key: Key(item.id.toString()),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) { //fix swipe to delete
                cart.delete(item);
              },
              background: Container(
                child: Icon(
                  Icons.restore_from_trash,
                  size: 40,
                ),
                margin: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(0x8C650223),
                      Color(0x8CB9013E),
                    ],
                    stops: [0.1, 0.9],
                  ),
                ),
              ),
              child: ProductCard(
                product: item,
              ) //ListTile(title: Text('${item.productName}.')),
              );
        },
      ),
    ));
  }
}
