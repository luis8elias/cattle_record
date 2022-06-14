import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CustomCircleAvatar extends StatelessWidget {

  final String imgPath;
  final bool   isPressed;
  final String text;

  const CustomCircleAvatar({
    Key? key,
    required this.imgPath,
    required this.isPressed,
    required this.text
  }) : super(key: key);

    @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: size.height  * 0.10,
          height: size.height  * 0.10,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFBDBDBD) ,
                offset: Offset(5, 5),
                blurRadius: 7
              )
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(100.0),
            border: Border.all(
              width: isPressed ?  5.0 : 0.0,
              color: Theme.of(context).highlightColor
            )
          ),
          child: Center(
            child: SizedBox(
              width: size.height  * 0.05,
              height: size.height  * 0.05,
              child:  SvgPicture.asset(imgPath),
            ),
          ),
          
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Center(
            child: Text(text),
          ),
        )
      ],
    );
  }
}