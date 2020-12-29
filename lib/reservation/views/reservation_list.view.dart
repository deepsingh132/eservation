import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eservation/auth/auth.controller.dart';

import 'package:eservation/reservation/reservation.controller.dart';
import 'package:eservation/reservation/widgets/reservation_item.dart';
import 'package:eservation/widgets/app_drawer.dart';

class ReservationList extends StatelessWidget {
  ReservationList({Key key}) : super(key: key);

  final AuthController authController = AuthController.to;
  //String name = "authController?.user?.value?.displayName}";

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    ReservationController c =
        Get.put<ReservationController>(ReservationController());
    if (authController.user == null) {
      Get.toNamed("/login");
    }
    return Scaffold(
      key: scaffoldKey,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Obx(() => authController.user != null
            ? Text(" ${authController?.user?.value?.displayName}")
            : Container()),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              scaffoldKey.currentState.openDrawer();
            },
            icon: Icon(Icons.menu)),
      ),
      body: 
      Obx(() {
        if (c.isLoadingreservations.value) {
          return Container(child: Center(child: CircularProgressIndicator()));
        }

        if (c.reservations.length == 0) {
          return Center(child: Text('No Reservations'));
        }
        return ListView.builder(
            shrinkWrap: true,
            itemCount: c.reservations.length,
            itemBuilder: (context, index) {
              return TodoItem(c.reservations.elementAt(index));
            });
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed("/add-todo"),
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
