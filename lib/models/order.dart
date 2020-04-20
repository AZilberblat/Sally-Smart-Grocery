import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sally_smart/models/billing_address.dart';
import 'package:sally_smart/models/product.dart';

class Order {
  final DocumentReference documentReference;
  final List<Product> products;
  final Timestamp time;
  final BillingAddress billingAddress;

  String get id => documentReference?.documentID;

  double get total => products.fold(
      0, (previousValue, product) => previousValue + product.price);

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Order({
    this.documentReference,
    @required this.products,
    @required this.time,
    @required this.billingAddress,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Order &&
          runtimeType == other.runtimeType &&
          documentReference == other.documentReference &&
          products == other.products &&
          time == other.time &&
          billingAddress == other.billingAddress);

  @override
  int get hashCode =>
      documentReference.hashCode ^
      products.hashCode ^
      time.hashCode ^
      billingAddress.hashCode;

  @override
  String toString() {
    return 'Order{' +
        ' id: $id,' +
        ' products: $products,' +
        ' time: $time,' +
        ' billingAddress: $billingAddress,' +
        '}';
  }

  Order copyWith({
    DocumentReference documentReference,
    List<Product> products,
    Timestamp time,
    BillingAddress billingAddress,
  }) {
    return new Order(
      documentReference: documentReference ?? this.documentReference,
      products: products ?? this.products,
      time: time ?? this.time,
      billingAddress: billingAddress ?? this.billingAddress,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'products': this.products.map((e) => e.toJson()).toList(),
      'time': this.time,
      'billingAddress': this.billingAddress.toJson(),
    };
  }

  factory Order.fromMap(Map map) {
    return Order(
      products:
          (map['products'] as List).map((e) => Product.fromJson(e)).toList(),
      time: map['time'] as Timestamp,
      billingAddress: BillingAddress.fromJson(map['billingAddress']),
    );
  }

  factory Order.fromDocument(DocumentSnapshot document) =>
      Order.fromMap(document.data)
          .copyWith(documentReference: document.reference);

//</editor-fold>
}
