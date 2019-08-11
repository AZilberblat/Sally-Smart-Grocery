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

// Gets the product name according to the barcode in the sallyDatabase
getProductPrice(String barcode) async {
  return await sallyDatabase
      .collection('grocery')
      .document(barcode)
      .get()
      .then((snapshot) {
    try {
      return snapshot.data['price'];
    } catch (e) {
      return 0;
    }
  });
}
