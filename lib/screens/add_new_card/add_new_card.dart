import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sally_smart/models/billing_address.dart';
import 'package:sally_smart/screens/widgets/edit_address_dialog.dart';
import 'package:sally_smart/services/payment_service.dart';
import 'package:sally_smart/utilities/extensions.dart';
import 'package:sally_smart/utilities/scan_button_const.dart';

class AddNewCard extends StatefulWidget {
  static const String id = 'add_new_card';

  AddNewCard({Key key}) : super(key: key);

  @override
  _AddNewCardState createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {
  final BehaviorSubject<CreditCardModel> stateController =
      BehaviorSubject<CreditCardModel>();

  BillingAddress billingAddress = kDebugMode
      ? BillingAddress(
          name: 'Jane Doe',
          line1: '1234 Anywhere Rd',
          city: 'Nowhere',
          country: 'Israel',
          postalCode: '12345')
      : null;

  bool showBackView = false;
  static const backgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<CreditCardModel>(
                stream: stateController.stream,
                initialData: CreditCardModel('', '', '', '', false),
                builder: (context, snapshot) {
                  final CreditCardModel state = snapshot.data;
                  return CreditCardWidget(
                    expiryDate: state.expiryDate,
                    cardHolderName: state.cardHolderName,
                    cardNumber: state.cardNumber,
                    cvvCode: state.cvvCode,
                    showBackView: state.isCvvFocused,
                  );
                }),
            CreditCardForm(
              onCreditCardModelChange: (CreditCardModel creditCardModel) =>
                  stateController.add(creditCardModel),
            ),
            Container(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Address:',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  EditAddressForm(
                    existingAddress: billingAddress,
                    themeMode: ThemeMode.light,
                    onChanged: (BillingAddress billingAddress) {
                      this.billingAddress = billingAddress;
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ScanMainButton(
                buttonText: 'Save',
                onPressed: () async {
                  CreditCardModel creditCardModel = stateController.value;
                  Navigator.pop(context, creditCardModel);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    stateController.close();
    super.dispose();
  }
}
