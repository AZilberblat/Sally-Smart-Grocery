import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:sally_smart/models/billing_address.dart';

extension StringX on String {
  toText() => Text(this);
}

extension BillingAddressX on BillingAddress {
  Widget toWidget({TextStyle style}) {
    final fields = [name, line1, line2, "$postalCode $city", country];
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final entry in fields)
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(
              entry ?? '',
              style: style,
            ),
          ),
      ],
    );
  }
}

extension CreditCardModelX on CreditCardModel {
//  toCreditCardWithBillingAddress(BillingAddress billingAddress) {
//    final splitDate = expiryDate.split('/');
//    assert(splitDate.length == 2);
//
//    final int expMonth = int.tryParse(splitDate.first);
//    final int expYear = int.tryParse(splitDate.last);
//    return CreditCard(
//      name: cardHolderName,
//      number: cardNumber,
//      cvc: cvvCode,
//      expMonth: expMonth,
//      expYear: expYear,
//      country: billingAddress?.country,
//      addressCity: billingAddress?.city,
//      addressCountry: billingAddress?.country,
//      addressLine1: billingAddress?.line1,
//      addressLine2: billingAddress?.line2,
//      addressState: billingAddress?.state,
//      addressZip: billingAddress?.postalCode,
//      last4: cardNumber.substring(cardNumber.length - 4),
//    );
//  }
}
