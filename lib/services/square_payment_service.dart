import 'dart:async';
import 'dart:io';

import 'package:sally_smart/models/secrets.dart';
import 'package:sally_smart/services/models/auth_response.dart';
import 'package:sally_smart/services/payment_service.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/models.dart';

class SquarePaymentService extends PaymentService {
  SquarePaymentService() {
    _initSquarePayment();
  }

  Future<void> _initSquarePayment() async {
    final Secret secret = await SecretLoader(secretPath: 'secrets.json').load();
    assert(
        secret.appId != null,
        'You must save the app id with the key "SALLY_SMART_SANDBOX_APP_ID"'
        ' in your system environment in order to accept payments');
    await InAppPayments.setSquareApplicationId(secret.appId);
    var canUseGooglePay = false;
    if (Platform.isAndroid) {
      // initialize the google pay with square location id
      // use test environment first to quick start
      await InAppPayments.initializeGooglePay('BRN4035BAWSA0', 1);
      canUseGooglePay = await InAppPayments.canUseGooglePay;
    }
    return;
  }

  @override
  Future<CardDetails> addCard() async {
    final completer = Completer<CardDetails>();
    final result = await InAppPayments.startCardEntryFlow(
        onCardNonceRequestSuccess: (result) {
          completer.complete(result);
          _onCardEntryCardNonceRequestSuccess(result);
        },
        onCardEntryCancel: _onCancelCardEntryFlow);
    return completer.future;
  }

  @override
  Future createPayment() async {
    final canUseGooglePay = await InAppPayments.canUseGooglePay;
    return;
  }

  @override
  Future openPaymentRequestWithCardForm() {
    // TODO: implement openPaymentRequestWithCardForm
    throw UnimplementedError();
  }

  /// Callback when card entry is cancelled and UI is closed
  void _onCancelCardEntryFlow() {
    // Handle the cancel callback
  }

  /// Callback when successfully get the card nonce details for processig
  /// card entry is still open and waiting for processing card nonce details
  void _onCardEntryCardNonceRequestSuccess(CardDetails result) async {
    try {
      // take payment with the card nonce details
      // you can take a charge
      // await chargeCard(result);

      // payment finished successfully
      // you must call this method to close card entry
      InAppPayments.completeCardEntry(
          onCardEntryComplete: _onCardEntryComplete);
    } on Exception catch (ex) {
      // payment failed to complete due to error
      // notify card entry to show processing error
      InAppPayments.showCardNonceProcessingError(ex.toString());
    }
  }

  /// Callback when the card entry is closed after call 'completeCardEntry'
  void _onCardEntryComplete() {
    // Update UI to notify user that the payment flow is finished successfully
  }

  @override
  Future<AuthResponse> getAuthCode() {
    const authEndpoint = 'https://connect.squareup.com/oauth2/token';
    throw UnimplementedError();
  }
}
