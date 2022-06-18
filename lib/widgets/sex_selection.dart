import 'package:cattle_record/providers/sex_selection_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'custom_circle_avatar.dart';


class SexSelection extends StatelessWidget {
  const SexSelection({Key? key}) : super(key: key);




   @override
   Widget build(BuildContext context) {
     return Consumer<SexSelectionProvider>(
       builder: (context, sexSelection , _) =>
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: (){
                 sexSelection.isFemaleSelected = true;
              },
                child: CustomCircleAvatar(
                imgPath: 'assets/cow.svg',
                isPressed: sexSelection.isFemaleSelected ,
                text: 'Hembra',
              ),
            ),
              GestureDetector(
                onTap: (){
                  sexSelection.isFemaleSelected = false;
                },
                child: CustomCircleAvatar(
                imgPath: 'assets/bull.svg',
                isPressed:  ! sexSelection.isFemaleSelected,
                text: 'Macho',
            ),
              ),
          ],
        ),
     );
   }
}