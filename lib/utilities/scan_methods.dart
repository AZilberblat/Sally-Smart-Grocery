import 'package:sally_smart/screens/welcome_screen.dart';

// Gets the product name according to the barcode in the sallyDatabase
getProductName(String barcode) async {
  return await sallyDatabase
      .collection('grocery')
      .document(barcode)
      .get()
      .then((snapshot) {
    if (snapshot.data != null) {
      return snapshot.data['name'];
    } else {
      print('Error');
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
    if (snapshot.data != null) {
      return snapshot.data['price'];
    } else {
      print('Error');
    }
  });
}
