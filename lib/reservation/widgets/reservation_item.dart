import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eservation/reservation/reservation.controller.dart';
import 'package:eservation/reservation/models/reserve.model.dart';

class TodoItem extends StatelessWidget {
  final Reservation todo;
  const TodoItem(this.todo, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),

      child: GestureDetector(
        onTap: () {
          Get.toNamed("/todos/${todo.id}/edit");
        },
      child: Center(
        child: Container(
        
          height: 200,
        
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.green[100],
            borderRadius: BorderRadius.circular(15),
          ),

          child: 
          Align(
            alignment: Alignment.center,
            child: Center(
              child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align( child: Row(children: [
                  Text("${todo.name}",
                  textAlign: TextAlign.center),
                  
                ]),
              ),
              ),

              Row( children: [
                Padding(padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Text("${todo.emailId}",
                  textAlign: TextAlign.center)
                ],) ,)
              ],),

              Row(children: [
                Padding(padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Text("${todo.phoneNo}",
                  textAlign: TextAlign.right,
                  )
                ],),)
              ],),

              Row(children: [
                Padding(padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Text("${todo.time}")
                ],) ,)
              ],),

              Row(
                children: <Widget>[
                  /*Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: GestureDetector(
                        onTap: () {
                          ReservationController.to
                              .updateReservation(todo.copyWith(done: !todo.done));
                        },
                        child: !todo.done
                            ? Icon(Icons.check_box_outline_blank)
                            : Icon(Icons.check_box),
                      ),
                    ),
                  ),*/
                  Align(
                    alignment: Alignment.center,
                  child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.center,
                      child: GestureDetector(
                          onTap: () {
                            ReservationController.to.deleteReservation(todo.id);
                          },
                          child: Icon(Icons.cancel)),
                    ),
                  ),
                  ),
                  ),
                ],
                
              )
            ],
          ),
            ),
        ),
        ),
      ),
      ),
    );
  }
}