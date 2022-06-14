import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {

  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final bool isExtended;

  const CustomTextField({ 
    Key? key,
    required this.label,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
    required  this.isExtended
  }) :super(key: key) ;
   @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
      child: Material(
          elevation: 2.0,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          child: SizedBox(
            width: size.width * 0.7,
            height: isExtended ? 70 : 50,
            child: TextField(
              focusNode: focusNode,
              onEditingComplete: () => nextFocusNode  == null ?
               FocusScope.of(context).requestFocus(FocusNode()) 
                : FocusScope.of(context).requestFocus(nextFocusNode),
              controller: controller,
              maxLines: isExtended ? 2 : 1 ,
              cursorColor: Theme.of(context).highlightColor,
              decoration: InputDecoration(
                hintText: label,
                border: InputBorder.none,
                 contentPadding:
                   const EdgeInsets.symmetric(horizontal: 25, vertical: 13)
            ),
           ),
        ),
      ),
    );
  }
}