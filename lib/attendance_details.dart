import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class AttendanceDetails extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  const AttendanceDetails({Key? key, required this.documentSnapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(documentSnapshot["user"] + " Record"),
          ),
        ),
        body: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Attendance Record",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Text("Name :  ", style: TextStyle(fontSize: 15)),
                    Text(documentSnapshot['user'],
                        style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Text("Phone No :  ", style: TextStyle(fontSize: 15)),
                    Text(documentSnapshot['phone'],
                        style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Text("Check-In :  ", style: TextStyle(fontSize: 15)),
                    Text(formatedDate(documentSnapshot['checkin']),
                        style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

String formatedDate(Timestamp) {
  var dateFromTimeStamp =
      DateTime.fromMillisecondsSinceEpoch(Timestamp.seconds * 1000);
  return DateFormat('dd-MM-yyyy hh:mm:ss a').format(dateFromTimeStamp);
}
