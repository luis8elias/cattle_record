import 'package:flutter/cupertino.dart';

class SexSelectionProvider with ChangeNotifier{

  bool _isFemaleSelected = true;

  bool get isFemaleSelected => _isFemaleSelected;

  set isFemaleSelected(bool value){
    _isFemaleSelected = value;
    notifyListeners();
  }

}