// TODO Implement this library.
import 'package:get/get.dart';
import 'package:eservation/auth/auth.controller.dart';
import 'package:eservation/reservation/models/reserve.model.dart';
import 'package:eservation/reservation/reservation.service.dart';

class ReservationController extends GetxController {
  static ReservationController to = Get.find();
  RxList<Reservation> reservations = <Reservation>[].obs;
  RxBool isLoadingreservations = false.obs;
  RxBool isAddingReservation = false.obs;
  RxBool isLoadingDetails = false.obs;
  Reservation activeReservation;
  ReservationService _reservationservice;
  ReservationController() {
    _reservationservice = ReservationService();
  }

  onInit() {
    reservations.bindStream(loadreservations());
  }

  Stream<List<Reservation>> loadreservations() {
    AuthController authController = AuthController.to;
    return _reservationservice.findAll(authController.user.value.uid);
  }

  Future<Reservation> loadDetails(String id) async {
    try {
      isLoadingDetails.value = true;
      activeReservation = await _reservationservice.findOne(id);
      print(activeReservation);
      isLoadingDetails.value = false;
      return activeReservation;
    } catch (e) {
      print(e);
    }
  }

  AddReservation(String title,String phoneNo,String emailId,String date) async {
    try {
      AuthController authController = AuthController.to;
      isAddingReservation.value = true;
      var reservation = await _reservationservice.addOne(
          authController.user.value.uid, title, phoneNo, emailId, date);

      reservations.add(reservation);
      Get.snackbar("Success", reservation.name,
          snackPosition: SnackPosition.BOTTOM);
      isAddingReservation.value = false;
    } catch (e) {
      isAddingReservation.value = false;
      print(e);
    }
  }

  updateReservation(Reservation reservation) async {
    try {
      isAddingReservation.value = true;
      await _reservationservice.updateOne(reservation);
      int index = reservations.value
          .indexWhere((element) => element.id == reservation.id);

      reservations[index] = reservation;
      print(reservations);
      Get.snackbar("Success", " updated", snackPosition: SnackPosition.BOTTOM);
      isAddingReservation.value = false;
    } catch (e) {
      isAddingReservation.value = false;
      print(e);
    }
  }

  deleteReservation(String id) async {
    try {
      await _reservationservice.deleteOne(id);
      int index = reservations.value.indexWhere((element) => element.id == id);
      reservations.removeAt(index);
      Get.snackbar("Success", "Deleted", snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      print(e);
    }
  }
}
