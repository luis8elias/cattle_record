import 'package:flutter/cupertino.dart';

class CountElementsProvider with ChangeNotifier{
  
  int _countElements  = 0;

  int get count => _countElements;

  set count(int value){
    _countElements = value;
    notifyListeners();
  }
}