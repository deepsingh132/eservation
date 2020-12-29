import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eservation/reservation/models/reserve.model.dart';

class ReservationService {
  CollectionReference reservation = Firestore.instance.collection("reservations");
  Stream<Iterable<Reservation>> findAll(userId) {
    return reservation
        .where("user_id", isEqualTo: userId)
        .getDocuments()
        .then((value) {
      return value.documents.map((e) => Reservation.fromSnapshot(e)).toList();
    }).asStream();
    //Here we are converting the firebase snapshot to a stream of user todo list.
  }

  Future<Reservation> findOne(String id) async {
    var result = await reservation.document(id).get();
    return Reservation.fromSnapshot(result);
  }

  Future<Reservation> addOne(String userId, String title,String phoneNo, String emailId,String time, {bool done = false}) async {
    var result =
        await reservation.add({"user_id": userId, "name": title, "done": done,"phone":phoneNo, "email":emailId,"datetime":time});
    return Reservation(id: result.documentID, name: title, phoneNo: phoneNo,emailId: emailId, time: time ,done: done);
  }

  Future<void> updateOne(Reservation ref) async {
    reservation.document(ref.id).updateData(ref.toJson());
  }

  deleteOne(String id) {
    reservation.document(id).delete();
  }
}