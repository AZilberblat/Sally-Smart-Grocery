import 'package:sally_smart/screens/welcome_screen.dart';

// Gets the product name according to the barcode in the sallyDatabase
getProductName(String barcode) async {
  return await sallyDatabase
      .collection('grocery')
      .document(barcode)
      .get()
      .then((snapshot) {
    try {
      return snapshot.data['name'];
    } catch (e) {
      return 'מוצר לא קיים';
    }
  });
}

// Gets the product price according to the barcode in the sallyDatabase
Future<double> getProductPrice(String barcode) async {
  return await sallyDatabase
      .collection('grocery')
      .document(barcode)
      .get()
      .then((snapshot) {
    try {
      return snapshot.data['price'] as double;
    } catch (e) {
      return 0;
    }
  });
}

addProductToFireStore(String barcode, String name, double price) async {
  return await sallyDatabase
      .collection('grocery')
      .document(barcode)
      .setData({"name": name, "price": price});
}
