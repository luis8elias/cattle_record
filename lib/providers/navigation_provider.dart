import 'package:flutter/cupertino.dart';

class NavigationProvider with ChangeNotifier{


  // controla la pagina de la barra de navegacion
  int _currentIndex = 1;


  // sirve para obtener el valor actual del index
  int get currentIndex => _currentIndex;


 // sirve para poner un nuevo  valor y ademas notificar 
  set currentIndex(int value){
    _currentIndex = value;
    notifyListeners();
  }
}