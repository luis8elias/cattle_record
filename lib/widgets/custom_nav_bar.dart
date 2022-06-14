import 'package:cattle_record/providers/navigation_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../util/data.dart';


class CustomNavBar extends StatelessWidget {
  const CustomNavBar({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {

    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Consumer<NavigationProvider>(
      builder: (context,navProvider,_) => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Visibility(
          visible: !keyboardIsOpen,
          child: FloatingActionButton(
            onPressed: (){
              navProvider.currentIndex = 1;
            },
            backgroundColor: Theme.of(context).highlightColor,
            child: const Icon(Icons.add ,color: Colors.white),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).highlightColor,
          currentIndex:  navProvider.currentIndex ,
          onTap: (index) => navProvider.currentIndex = index,
          items: Data.bottomElements
        ),
        backgroundColor:  const Color(0xfff0f0f0),
        body: Data.bottomPages[navProvider.currentIndex]
      ),
    );
  }
}