import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:eservation/reservation/reservation.controller.dart';
import 'package:eservation/reservation/models/reserve.model.dart';

class AddReservation extends StatefulWidget {
  AddReservation({Key key}) : super(key: key);

  @override
  _AddReservationState createState() => _AddReservationState();
}

class _AddReservationState extends State<AddReservation> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneNoController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  
  Reservation reservation;

  @override
  void initState() {
    //String rTime;
    print(Get.parameters);
    if (Get.parameters != null) {
      var id = Get.parameters["id"];
      if (id != null) {
        ReservationController.to.loadDetails(id).then((value) => setState(() {
              reservation = value;
              nameController.text = value.name;
              phoneNoController.text = value.phoneNo;
              emailController.text = value.emailId;
              //val.text =  value.time;
            }));
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String  val;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add reservation"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Add Name",
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: phoneNoController,
              decoration: InputDecoration(
                hintText: "Add Phone No",
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Add Email",
                border: OutlineInputBorder(),
              ),
            ),
            DateTimePicker(
              //controller: timeController,
              type: DateTimePickerType.dateTimeSeparate,
              dateMask: 'd MMM, yyyy',
              initialValue: DateTime.now().toString(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              icon: Icon(Icons.event),
              dateLabelText: 'Date',
              timeLabelText: "Time",

              onChanged: (rTime) =>  val=rTime,
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
                  if (nameController.text == "" ||
                      phoneNoController.text == "" ||
                      emailController.text == "" ||
                      val == "") {
                    Get.snackbar("Please Fill All the Fields",
                        "Error Adding Reservation",
                        snackPosition: SnackPosition.BOTTOM);
                  }
                  if (nameController.text != "" &&
                      phoneNoController.text != "" &&
                      emailController.text != "" &&
                      val != "") {
                    if (reservation != null) {
                      reservation.name = nameController.text;
                      reservation.emailId = emailController.text;
                      reservation.phoneNo = phoneNoController.text;
                      reservation.time = val.toString();
                      ReservationController.to.updateReservation(reservation);
                      nameController.clear();
                      emailController.clear();
                      phoneNoController.clear();
                      //rTime.clear();
                    } else {
                      ReservationController.to.AddReservation(
                          nameController.text,
                          phoneNoController.text,
                          emailController.text,
                          val.toString());
                      print(val.toString());
                      nameController.clear();
                      emailController.clear();
                      phoneNoController.clear();
                    }
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .6,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Save",
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
        ),
      ),
    );
  }
}
