// TODO Implement this library.
import 'package:cloud_firestore/cloud_firestore.dart';

class Reservation {
  String id;
  String name;
  bool done;
  String time;
  String phoneNo;
  String emailId;

  String userId;
  Reservation({this.id, this.userId, this.name, this.phoneNo, this.emailId,this.time, this.done = false});
  copyWith({name, done, phoneNo, emailId, time}) {
    return Reservation(
      id: id,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      done: done ?? this.done,
      phoneNo: phoneNo ?? this.phoneNo,
      emailId: emailId ?? this.emailId,
      time: time ?? this.time

    );
  }

  factory Reservation.fromSnapshot(DocumentSnapshot snap) {
    return Reservation(
        id: snap.documentID,
        done: snap.data["done"],
        emailId: snap.data["email"],
        phoneNo: snap.data["phone"],
        time: snap.data["datetime"],
        name: snap.data['name']);
  }

  toJson() {
    return {"name": name, "done": done,"email":emailId,"phone":phoneNo,"datetime":time};
  }
}
