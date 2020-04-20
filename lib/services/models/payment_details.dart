import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:sally_smart/models/billing_address.dart';

class PaymentRequest {
  final AmountMoney amountMoney;
  final String idempotencyKey;
  final String sourceId;
  final bool acceptPartialAuthorization;
  final bool autocomplete;
  final BillingAddress billingAddress;
  final String statementDescriptionIdentifier;
  final String buyerEmailAddress;
  final String customerId;

  PaymentRequest({
    @required int amount,
    @required String currency,
    @required this.idempotencyKey,
    @required this.sourceId,
    @required this.acceptPartialAuthorization,
    @required this.autocomplete,
    @required this.billingAddress,
    @required this.statementDescriptionIdentifier,
    @required this.buyerEmailAddress,
    @required this.customerId,
  }) : amountMoney = AmountMoney(amount: amount, currency: currency);

  factory PaymentRequest.fromRawJson(String str) =>
      PaymentRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentRequest.fromJson(Map<String, dynamic> json) => PaymentRequest(
        amount: json["amount"],
        currency: json["currency"],
        idempotencyKey: json["idempotency_key"],
        sourceId: json["source_id"],
        acceptPartialAuthorization: json["accept_partial_authorization"],
        autocomplete: json["autocomplete"],
        billingAddress: BillingAddress.fromJson(json["billing_address"]),
        statementDescriptionIdentifier:
            json["statement_description_identifier"],
        buyerEmailAddress: json["buyer_email_address"],
        customerId: json["customer_id"],
      );

  Map<String, dynamic> toJson() => {
        "amount_money": amountMoney.toJson(),
        "idempotency_key": idempotencyKey,
        "source_id": sourceId,
        "accept_partial_authorization": acceptPartialAuthorization,
        "autocomplete": autocomplete,
        "billing_address": billingAddress.toJson(),
        "statement_description_identifier": statementDescriptionIdentifier,
        "buyer_email_address": buyerEmailAddress,
        "customer_id": customerId,
      };
}

class AmountMoney {
  final int amount;
  final String currency;

  AmountMoney({
    @required this.amount,
    @required this.currency,
  });

  factory AmountMoney.fromRawJson(String str) =>
      AmountMoney.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AmountMoney.fromJson(Map<String, dynamic> json) => AmountMoney(
        amount: json["amount"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "currency": currency,
      };
}
