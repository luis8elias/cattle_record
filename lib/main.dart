import 'package:cattle_record/providers/navigation_provider.dart';
import 'package:cattle_record/widgets/custom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


void main() {

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xff4BC4A9),
      statusBarBrightness: Brightness.dark
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xff067d68),
          highlightColor: const Color(0xff4BC4A9),
          errorColor:const Color(0xffE1483C)
        ),
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context)=> NavigationProvider())
          ],
          child: const CustomNavBar() 
        )
    );
  }

  
}
