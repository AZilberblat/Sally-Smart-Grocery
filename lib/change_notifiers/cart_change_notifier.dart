import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sally_smart/models/product.dart';

class CartNotifier extends ChangeNotifier {
  List<Product> shoppingList;
  CollectionReference cartCollection;

  CartNotifier() {
    shoppingList = [];
  }

  void setUserDocument({@required String uid}) {
    DocumentReference firestoreUserDocument =
        Firestore.instance.document('users/$uid');
    cartCollection = firestoreUserDocument.collection('cart');
    _startListening();
  }

  /// Collection of cart items. If the item isn't in the collection, then call collection.add().
  /// if it is, then find the document, and then update the count on the document.
  /// Because you're listening to the collection, the app will automatically update with the changes.
  void add(Product product) {
    assert(cartCollection != null);
    if (shoppingList.contains(product)) {
      final Product existingProduct =
          shoppingList.firstWhere((cartItem) => cartItem == product);
      increment(existingProduct);
    } else {
      cartCollection.add(product.toJson());
    }
  }

  int get length => shoppingList.length;

  void delete(Product item) => item.documentReference.delete();

  void increment(Product product) {
    assert(cartCollection != null);
    assert(product.documentReference != null);
    product.documentReference.updateData({'quantity': product.quantity + 1});
  }

  int decrement(Product product) {
    assert(cartCollection != null);
    final int newQuantity = product.quantity - 1;

    if (newQuantity < 1) {
      delete(product);
    } else {
      product.documentReference.updateData({'quantity': newQuantity});
    }

    return newQuantity;
  }

  void _startListening() async {
    Stream<List<DocumentSnapshot>> snapshots = cartCollection
        .snapshots()
        .map((querySnapshot) => querySnapshot.documents);
    await for (final List<DocumentSnapshot> cart in snapshots) {
      // listen to the cart document for changes
      shoppingList =
          cart.map((document) => Product.fromDocument(document)).toList();
      notifyListeners(); // this is how we make the screen show the new data.
      stateChangeStream.add(null);
    }
  }

  StreamController stateChangeStream = StreamController.broadcast();
}
