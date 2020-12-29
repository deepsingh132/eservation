import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:eservation/auth/auth.controller.dart';
import 'package:eservation/get_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  final AuthController authController = Get.put<AuthController>(AuthController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eservation',
      defaultTransition: Transition.rightToLeft,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your applicatieon with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity
       // appBarTheme: AppBarTheme(
         // elevation: 0,
        //),
      ),  
      //navigatorKey: Get.Key,
      initialRoute: "/ReservationList",
      getPages: AppRoutes.routes,
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}