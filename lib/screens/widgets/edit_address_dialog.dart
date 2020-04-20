import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sally_smart/models/billing_address.dart';

Future<BillingAddress> showEditAddressDialog(
  BuildContext context, {
  BillingAddress existingAddress,
}) {
  return showDialog<BillingAddress>(
    context: context,
    builder: (context) {
      StreamController<BillingAddress> addressController = StreamController();
      return AlertDialog(
        title: Text('Edit Billing Address'),
        content: EditAddressForm(
          existingAddress: existingAddress,
          onChanged: (BillingAddress billingAddress) =>
              addressController.add(billingAddress),
        ),
        actions: [
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          StreamBuilder<BillingAddress>(
            stream: addressController.stream,
            builder: (context, snapshot) {
              return FlatButton(
                child: Text('Save'),
                onPressed: () {
                  addressController.close();

                  Navigator.of(context).pop(
                    snapshot.data,
                  );
                },
              );
            },
          )
        ],
      );
    },
  );
}

class EditAddressForm extends StatefulWidget {
  final BillingAddress existingAddress;
  final ValueChanged<BillingAddress> onChanged;
  final ThemeMode themeMode;

  const EditAddressForm({
    Key key,
    this.existingAddress,
    @required this.onChanged,
    this.themeMode = ThemeMode.system,
  }) : super(key: key);

  @override
  _EditAddressFormState createState() => _EditAddressFormState();
}

class _EditAddressFormState extends State<EditAddressForm> {
  TextEditingController nameController;
  TextEditingController line1Controller;
  TextEditingController line2Controller;
  TextEditingController postalCodeController;
  TextEditingController cityController;
  TextEditingController countryController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.existingAddress?.name);
    line1Controller =
        TextEditingController(text: widget.existingAddress?.line1);
    line2Controller =
        TextEditingController(text: widget.existingAddress?.line2);
    postalCodeController =
        TextEditingController(text: widget.existingAddress?.postalCode);
    cityController = TextEditingController(text: widget.existingAddress?.city);
    countryController =
        TextEditingController(text: widget.existingAddress?.country);
    super.initState();
  }

  ThemeData get _getTheme {
    if (widget.themeMode == ThemeMode.light) {
      return ThemeData.light();
    } else {
      return Theme.of(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _getTheme,
      child: Builder(
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        isDense: true),
                  ),
                  TextFormField(
                    controller: line1Controller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Address',
                        isDense: true),
                  ),
                  TextFormField(
                    controller: line2Controller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Address 2',
                        isDense: true),
                  ),
                  TextFormField(
                    controller: postalCodeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Zip Code',
                      isDense: true,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: cityController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'City',
                        isDense: true),
                  ),
                  TextFormField(
                    controller: countryController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Country',
                        isDense: true),
                  ),
                ]
                    .map(
                      (e) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: e,
                      ),
                    )
                    .toList(),
              ),
              onChanged: () {
                widget?.onChanged(
                  BillingAddress(
                    name: nameController.text,
                    line1: line1Controller.text,
                    line2: line2Controller.text,
                    city: cityController.text,
                    country: countryController.text,
                    postalCode: postalCodeController.text,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
