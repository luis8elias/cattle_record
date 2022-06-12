import 'package:flutter/material.dart';



class Data{
  
  static final List<Widget> bottomPages = [
    Container(),
    Container(),
    Container(),
    
  ];
 
  static final List<BottomNavigationBarItem> bottomElements = [

    const BottomNavigationBarItem(
      icon:Icon(Icons.list),
      label: 'Animales'
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.add, color: Colors.transparent),
      label: 'Añadir',
    ),         
    const BottomNavigationBarItem(
      icon:Icon(Icons.save),
      label:'Exportar'
    ),

  ];

}