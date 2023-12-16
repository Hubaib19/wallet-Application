import 'package:flutter/material.dart';

class BottomBarProvider extends ChangeNotifier {
  int indexButton = 0;

  // int get currentIndex => indexButton;

  void setIndex(int newIndex) {
    indexButton = newIndex;
    notifyListeners();
  }
}
