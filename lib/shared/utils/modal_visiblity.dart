import 'package:flutter/material.dart';

class ModalVisibleProvider extends ChangeNotifier {
  bool _isVisible = false;

  bool get isVisible => _isVisible;

  void setVisibility(bool isVisible) {
    _isVisible = isVisible;
    notifyListeners();
  }
}
