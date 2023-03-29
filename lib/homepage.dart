import 'dart:async';
import 'package:attendance_record/attendance_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required String title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _allResult = [];
  List _resultList = [];
  final TextEditingController _searchController = TextEditingController();

  String name = "";
  String phone = "";

  Timer? _timer;

  bool isLoading = false;

  //Firebasefirestore
  getUser() async {
    var data = await FirebaseFirestore.instance
        .collection('Attendance')
        .orderBy('checkin', descending: true)
        .get();

    setState(() {
      _allResult = data.docs;
    });

    searchResultList();
  }

  //scrollcontroller
  ScrollController _scrollController = new ScrollController();
  bool backtoTop = false;
  bool isLastIndex = false;

  @override
  void initState() {
    _searchController.addListener(_onSearchChanged);
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        backtoTop = _scrollController.offset > 400 ? true : false;
        isLastIndex = _scrollController.offset >
                _scrollController.position.maxScrollExtent
            ? true
            : false;
      });
    });

    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
  }

  //search function
  _onSearchChanged() {
    print(_searchController.text);
    searchResultList();
  }

  searchResultList() {
    var showResult = [];
    if (_searchController.text != "") {
      for (var clientSnapShot in _allResult) {
        var name = clientSnapShot['user'].toString().toLowerCase();
        if (name.contains(_searchController.text.toLowerCase())) {
          showResult.add(clientSnapShot);
        }
      }
    } else {
      showResult = List.from(_allResult);
    }

    setState(() {
      _resultList = showResult;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _scrollController.dispose();
  }

  @override
  void didChangeDependencies() {
    getUser();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Attendance Record'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  title: const Text("Add New Attendance Record"),
                  content: Container(
                    width: 400,
                    height: 100,
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter a name',
                          ),
                          onChanged: (String value) {
                            name = value;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter phone number',
                          ),
                          onChanged: (String value) {
                            phone = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.all(20.0)),
                        onPressed: () async {
                          setState(() {
                            //todos.add(title);
                            createattendance();
                          });
                        },
                        child: const Text("Check In"))
                  ],
                );
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Container(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                CupertinoSearchTextField(
                  controller: _searchController,
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: Stack(
                  children: [
                    buildListView(_scrollController),
                    buildText(isLastIndex),
                  ],
                ))
              ],
            )),
      ),
    );
  }

  Widget buildListView(ScrollController _scrollController) => StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Attendance')
          .orderBy('checkin', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.builder(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: _resultList.length,
              itemBuilder: (BuildContext context, int index) {
                final DocumentSnapshot documentSnapshot =
                    snapshot.data!.docs[index];
                return Dismissible(
                    key: Key(index.toString()),
                    child: Card(
                      child: ListTile(
                        title: Text((documentSnapshot != null)
                            ? (_resultList[index]['user'])
                            : ""),
                        subtitle: Text(formatedDate((documentSnapshot != null)
                            ? ((_resultList[index]['checkin'] != null)
                                ? _resultList[index]['checkin']
                                : "")
                            : "")),
                        leading: Icon(Icons.person),
                        trailing: Icon(Icons.arrow_forward),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AttendanceDetails(
                                      documentSnapshot: documentSnapshot)));
                        },
                      ),
                    ));
              });
        }
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.blue,
            ),
          ),
        );
      });

  Widget buildText(bool isLastIndex) => isLastIndex
      ? Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton.extended(
              onPressed: () {},
              label: Text("You have reached the end of the list"),
            ),
          ),
        )
      : SizedBox();

  String formatedDate(Timestamp) {
    var dateFromTimeStamp =
        DateTime.fromMillisecondsSinceEpoch(Timestamp.seconds * 1000);
    return DateFormat('dd-MM-yyyy hh:mm:ss a').format(dateFromTimeStamp);
  }

  createattendance() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Attendance").doc(name);

    Map<String, dynamic> attendanceList = {
      "user": name,
      "phone": phone,
      "checkin": Timestamp.now(),
    };
    documentReference
        .set(attendanceList)
        .whenComplete(() => EasyLoading.showSuccess('Sucess!'));

    EasyLoading.dismiss();
  }
}
