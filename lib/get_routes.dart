import 'package:get/get.dart';
import 'package:eservation/auth/views/login.dart';
import 'package:eservation/auth/views/register.dart';
import 'package:eservation/splashscreen.dart';
import 'package:eservation/reservation/views/views.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/splashscreen',
      page: () => SplashScreen(),
    ),
    GetPage(
      name: '/ReservationList',
      page: () => ReservationList(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginPage(),
    ),
    GetPage(
      name: '/register',
      page: () => RegisterPage(),
    ),
    GetPage(
      name: '/todos/:id/edit',
      page: () => EditReservation(),
    ),
    GetPage(
      name: '/add-todo',
      page: () => AddReservation(),
    ),
  ];
}