import 'package:flutter/material.dart';

class PaymentProvider with ChangeNotifier {
  String _selectedPayment = 'click';

  String get selectedPayment => _selectedPayment;

  void selectPayment(String payment) {
    _selectedPayment = payment;
    notifyListeners();
  }
}
