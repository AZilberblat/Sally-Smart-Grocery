import 'package:audioplayers/audio_cache.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:sally_smart/screens/registration_screen.dart';
import 'package:sally_smart/utilities/constants.dart';
import 'package:sally_smart/utilities/product_card.dart';
import 'package:sally_smart/utilities/scan_button_const.dart';
import 'package:sally_smart/utilities/scan_methods.dart';
//import 'package:sally_smart/utilities/scan_pageML.dart';
//import 'package:flutter_camera_ml_vision/flutter_camera_ml_vision.dart';
//import 'package:firebase_ml_vision/firebase_ml_vision.dart';

//List<ProductCard> shoppingList = [];
final sallyDatabase = Firestore.instance;

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final textEditorController = TextEditingController();
  String _scanBarcode = 'Unknown';
  String productName = 'Product Test';
  double productPrice;
  String productBarCode;
  IconData productIcon = Icons.add_shopping_cart;
  final List<ProductCard> shoppingList = [];
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
            'Sally',
            style: kHeaderTextStyle,
          ),
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
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                    child: TextField(
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        _scanBarcode = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          prefixIcon: Icon(Icons.search),
                          hintText: '...הכנס ברקוד או שם מוצר ידנית'),
                    ),
                  ),
                  DividerSally(),
                  shoppingListBuilder(),
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
                                //Changes the product name by referencing to the database
                                productBarCode = _scanBarcode;
                                productPrice =
                                    await getProductPrice(_scanBarcode);
                                productName =
                                    await getProductName(_scanBarcode);

                                setState(() {
                                  //checking if a product was already scanned

                                  //adding a ProductCard to the shopping list with the ProductCard const. Works on scan

                                  shoppingList.add(ProductCard(
                                    barCode: productBarCode,
                                    id: shoppingList.length.toString(),
                                    productName: productName,
                                    productPrice: productPrice,
                                    productIcon: productIcon,
                                  ));
                                });
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
  }

  Expanded shoppingListBuilder() {
    return Expanded(
        child: Container(
      color: Colors.black38,
      child: ListView.builder(
        reverse: true,
        itemCount: shoppingList.length,
        itemBuilder: (context, index) {
          ProductCard item = shoppingList[index];
          return Dismissible(
              key: Key(item.id),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {
                setState(() {
                  shoppingList.removeAt(index);
                });
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
              child: item //ListTile(title: Text('${item.productName}.')),
              );
        },
      ),
    ));
  }
}
