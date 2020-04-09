import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Product {
  final String name;
  final double price;
  final String barCode;
  final int id;
  final int quantity;
  final DocumentReference documentReference;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          price == other.price &&
          barCode == other.barCode;

  @override
  int get hashCode => name.hashCode ^ price.hashCode ^ barCode.hashCode;

  Product({
    @required this.price,
    @required this.name,
    @required this.barCode,
    @required this.id,
    this.quantity = 1,
    this.documentReference,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'price': this.price,
      'barCode': this.barCode,
      'id': this.id,
      'quantity': this.quantity,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] as String,
      price: json['price'] as double,
      barCode: json['barCode'] as String,
      id: json['id'] as int,
      quantity: json['quantity'] as int,
    );
  }

  factory Product.fromDocument(DocumentSnapshot documentSnapshot) {
    final json = documentSnapshot.data;
    return Product(
      name: json['name'] as String,
      price: json['price'] as double,
      barCode: json['barCode'] as String,
      id: json['id'] as int,
      quantity: json['quantity'] as int,
      documentReference: documentSnapshot.reference
    );
  }
  Product copyWith({
    String name,
    double price,
    String barCode,
    int id,
    IconData icon,
    int quantity,
  }) {
    return Product(
      name: name ?? this.name,
      price: price ?? this.price,
      barCode: barCode ?? this.barCode,
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      documentReference: documentReference,
    );
  }
}
