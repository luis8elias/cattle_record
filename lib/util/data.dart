import 'package:cattle_record/pages/add_page.dart';
import 'package:cattle_record/pages/list_page.dart';
import 'package:flutter/material.dart';



class Data{
  
  static final List<Widget> bottomPages = [
    const ListPage(),
    const AddPage(),
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