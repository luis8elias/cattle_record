// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'edge_alert.dart';


class CustomAlert{


  static void showSucces({required BuildContext context,required String desc}){
    EdgeAlert.show(
      context,
      title: 'Operacion Exitosa',
      description: desc,
      gravity: EdgeAlert.BOTTOM,
      icon: Icons.check,
      backgroundColor: Theme.of(context).highlightColor,
      duration: 2
    );

  }

  static void showError({required BuildContext context}){
    EdgeAlert.show(
      context,
      title: 'Operacion Fallida', 
      description: 'Algo salió mal',
      gravity: EdgeAlert.BOTTOM,
      icon: Icons.error,
      backgroundColor: Theme.of(context).errorColor,
      duration: 2
    );

  }

   static void showErrorCustomText({required BuildContext context,required String desc}){
    EdgeAlert.show(
      context,
      title: 'Operacion Fallida', 
      description: desc,
      gravity: EdgeAlert.BOTTOM,
      icon: Icons.error,
      backgroundColor: Theme.of(context).errorColor,
      duration: 2
    );

  }




}