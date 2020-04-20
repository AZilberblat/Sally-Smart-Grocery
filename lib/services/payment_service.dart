import 'package:sally_smart/services/models/auth_response.dart';

abstract class PaymentService {
  String get _applicationID;

  PaymentService();

  Future openPaymentRequestWithCardForm();

  Future<void> addCard();

  Future createPayment();

  Future<AuthResponse> getAuthCode();
}
