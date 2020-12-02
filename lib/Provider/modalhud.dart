import 'package:flutter/material.dart';

class ModalHud extends ChangeNotifier{
  bool isLoading = false;

  changeboolvalue(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
