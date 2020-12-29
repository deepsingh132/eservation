import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eservation/reservation/reservation.controller.dart';
import 'package:eservation/reservation/models/reserve.model.dart';

class EditReservation extends StatelessWidget {
  EditReservation({Key key}) : super(key: key);
  TextEditingController titleController;
  TextEditingController phoneNoController;
  TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    String val;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Reservation"),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: GetX(
            initState: (state) =>
                ReservationController.to.loadDetails(Get.parameters["id"]),
            builder: (disposable) {
              if (ReservationController.to.isLoadingDetails.value) {
                return Container(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (titleController == null &&
                  emailController == null &&
                  phoneNoController == null) {
                titleController = TextEditingController(
                    text: ReservationController.to.activeReservation.name);

                phoneNoController = TextEditingController(
                    text: ReservationController.to.activeReservation.phoneNo);

                emailController = TextEditingController(
                    text: ReservationController.to.activeReservation.emailId);
              }

              return Column(
                children: <Widget>[
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: "Edit Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextFormField(
                    controller: phoneNoController,
                    decoration: InputDecoration(
                      hintText: "Edit Phone",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Edit Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  DateTimePicker(
                    //controller: timeController,
                    type: DateTimePickerType.dateTimeSeparate,
                    dateMask: 'd MMM, yyyy',
                    initialValue: ReservationController.to.activeReservation.time.toString(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    icon: Icon(Icons.event),
                    dateLabelText: 'Date',
                    timeLabelText: "Time",

                    onChanged: (rTime) => val = rTime,

                    validator: (rTime) {
                      val = rTime;
                      print(rTime);
                      return val;
                    },
                    onSaved: (rTime) => val = rTime,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        if (titleController.text != "" &&
                            phoneNoController.text != "" &&
                            emailController.text != "" &&
                            val != "") {
                          Reservation reservation =
                              ReservationController.to.activeReservation;
                          reservation.name = titleController.text;
                          reservation.emailId = emailController.text;
                          reservation.phoneNo = phoneNoController.text;
                          reservation.time = val.toString();
                          ReservationController.to
                              .updateReservation(reservation);
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * .6,
                        height: 50,
                        child: Center(
                          child: Text(
                            "Update",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Obx(
                    () => ReservationController.to.isAddingReservation.value
                        ? Container(
                            child: Center(
                                child: CircularProgressIndicator(
                              backgroundColor: Colors.green,
                            )),
                          )
                        : Container(),
                  )
                ],
              );
            },
          )),
    );
  }
}
