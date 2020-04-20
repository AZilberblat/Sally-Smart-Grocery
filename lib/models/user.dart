import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sally_smart/models/billing_address.dart';

class User {
  final DocumentReference documentReference;
  final String name;

  final List<BillingAddress> billingAddresses;
  final BillingAddress primaryBillingAddress;
  final String phoneNumber;
  final String emailAddress;

  String get id => documentReference.documentID;

  factory User.fromDocument(DocumentSnapshot document) =>
      User.fromMap(document.data)
          .copyWith(documentReference: document.reference);

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const User({
    this.documentReference,
    @required this.name,
    @required this.billingAddresses,
    @required this.primaryBillingAddress,
    @required this.phoneNumber,
    @required this.emailAddress,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          documentReference == other.documentReference &&
          name == other.name &&
          billingAddresses == other.billingAddresses &&
          primaryBillingAddress == other.primaryBillingAddress &&
          phoneNumber == other.phoneNumber &&
          emailAddress == other.emailAddress);

  @override
  int get hashCode =>
      documentReference.hashCode ^
      name.hashCode ^
      billingAddresses.hashCode ^
      primaryBillingAddress.hashCode ^
      phoneNumber.hashCode ^
      emailAddress.hashCode;

  @override
  String toString() {
    return 'User{' +
        ' name: $name,' +
        ' billingAddresses: $billingAddresses,' +
        ' primaryBillingAddress: $primaryBillingAddress,' +
        ' phoneNumber: $phoneNumber,' +
        ' emailAddress: $emailAddress,' +
        '}';
  }

  User copyWith({
    DocumentReference documentReference,
    String name,
    List<BillingAddress> billingAddresses,
    BillingAddress primaryBillingAddress,
    String phoneNumber,
    String emailAddress,
  }) {
    return new User(
      documentReference: documentReference ?? this.documentReference,
      name: name ?? this.name,
      billingAddresses: billingAddresses ?? this.billingAddresses,
      primaryBillingAddress:
          primaryBillingAddress ?? this.primaryBillingAddress,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      emailAddress: emailAddress ?? this.emailAddress,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'billingAddresses':
          this.billingAddresses?.map((e) => e.toJson())?.toList(),
      'primaryBillingAddress': this.primaryBillingAddress?.toJson(),
      'phoneNumber': this.phoneNumber,
      'emailAddress': this.emailAddress,
    };
  }

  factory User.fromMap(Map map) {
    if (map == null) {
      return null;
    }
    return User(
      name: map['name'] as String,
      billingAddresses: (map['billingAddresses'] as List)
          ?.map((e) => BillingAddress.fromJson(e)),
      primaryBillingAddress:
          BillingAddress.fromJson(map['primaryBillingAddress']),
      phoneNumber: map['phoneNumber'] as String,
      emailAddress: map['emailAddress'] as String,
    );
  }

//</editor-fold>
}
