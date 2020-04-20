import 'package:meta/meta.dart';

class AddCreditCardScreenState {
  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final bool showBackView;

  AddCreditCardScreenState({
    @required this.cardNumber,
    @required this.expiryDate,
    @required this.cardHolderName,
    @required this.cvvCode,
    @required this.showBackView,
  });

  AddCreditCardScreenState.initial()
      : cardNumber = '',
        expiryDate = '',
        cardHolderName = '',
        cvvCode = '',
        showBackView = false;

  AddCreditCardScreenState copyWith({
    String cardNumber,
    String expiryDate,
    String cardHolderName,
    String cvvCode,
    bool showBackView,
  }) {
    return AddCreditCardScreenState(
      cardNumber: cardNumber ?? this.cardNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      cvvCode: cvvCode ?? this.cvvCode,
      showBackView: showBackView ?? this.showBackView,
    );
  }
}
