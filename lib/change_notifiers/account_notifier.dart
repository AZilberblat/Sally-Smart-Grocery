import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sally_smart/models/order.dart';
import 'package:sally_smart/models/user.dart';

/// Orders get stored in the account.

class AccountNotifier extends ChangeNotifier {
  User user;
  OrderManager orderManager;
  DocumentReference _userDocument;

  List<Order> get orders => orderManager.orders;

  Future<void> initialize(String uid) async {
    final completer = Completer();
    _userDocument = Firestore.instance.document('/users/$uid');
    _userDocument.snapshots().listen((document) {
      user = User.fromDocument(document);
      if (!completer.isCompleted) {
        completer.complete();
      }
      notifyListeners();
    });

    orderManager = OrderManager(_userDocument);
    return completer.future;
  }

  void updateUser(User user) async {
    _userDocument.updateData(user.toMap());
  }
}

class OrderManager extends Stream<Order> {
  final CollectionReference orderCollection;
  final BehaviorSubject _orders = BehaviorSubject<List<Order>>();

  List<Order> get orders => _orders.value;

  OrderManager(DocumentReference userDocument)
      : orderCollection = userDocument.collection('orders') {
    _init();
  }

  void _init() {
    orderCollection.snapshots().map((snapshot) => snapshot.documents).listen(
        (documents) => _orders.add(documents
            .map((document) => Order.fromDocument(document))
            .toList()));
  }

  @override
  StreamSubscription<Order> listen(
    void Function(Order event) onData, {
    Function onError,
    void Function() onDone,
    bool cancelOnError,
  }) =>
      _orders.listen(
        onData,
        onDone: onDone,
        onError: onError,
        cancelOnError: cancelOnError,
      );

  Future<Order> createOrder(Order order) async {
    final reference = await orderCollection.add(order.toMap());
    return order.copyWith(documentReference: reference);
  }
}
