// ignore_for_file: file_names

import 'package:flutter/material.dart';

class BottomBarProvider extends ChangeNotifier {
  int indexButton = 0;

  void setIndex(int newIndex) {
    indexButton = newIndex;
    notifyListeners();
  }
}
