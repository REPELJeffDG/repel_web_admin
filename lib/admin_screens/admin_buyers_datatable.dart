// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:repel/components/admin_drawer_appbar.dart';
import 'package:repel/services/firestore.dart';

class AdminBuyerDataTable extends StatefulWidget {
  const AdminBuyerDataTable({super.key});

  @override
  State<AdminBuyerDataTable> createState() => _AdminBuyerDataTableState();
}

class _AdminBuyerDataTableState extends State<AdminBuyerDataTable> {
  final DataTableSource _data = MyData();
  FirestoreService firestoreService = FirestoreService();
  NumberFormat numFormat = NumberFormat('###,###,###,###.00', 'en_US');
  double ts = 12;
  double totalSales = 45000;
  String dropdownValue = 'Today';
  List orderDatas = [];

  void loadAllORderDatas() {
    orderDatas = [];
    FirebaseFirestore db = FirebaseFirestore.instance;
    db
        .collection('orders')
        .orderBy('date', descending: true)
        .get()
        .then((querySnapshot) {
      return {
        querySnapshot.docs.forEach((doc) {
          print('load all ORDER data ${doc.id} => ${doc.data()}');
          doc.data()['id'] = doc.id;
          if (doc.data()['status'] == "Pending") {
            orderDatas.add(doc.data());
          }
        }),
        setState(() {})
      };
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    loadAllORderDatas();
  }

  dateNow() {
    DateTime now = new DateTime.now();
    String formatter = DateFormat.yMMMMd('en_US').format(now);
    return formatter;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    ts = width > 880 ? 22 : 12;
    return Scaffold(
      appBar: RAppBar(context, orderDatas),
      drawer: RDrawer(context, orderDatas),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 20,
              ),
              Padding(
                padding: width > 1300
                    ? const EdgeInsets.only(left: 100)
                    : const EdgeInsets.only(left: 20),
                child: PaginatedDataTable(
                  rowsPerPage: 9,
                  header: Row(children: [
                    Text('Aquardent Order',
                        style: GoogleFonts.sarabun(
                            color: Color(0xFF0C4546),
                            fontWeight: FontWeight.bold,
                            fontSize: width > 820 ? 28 : 23)),
                  ]),
                  source: _data,
                  columnSpacing: width > 880 ? width / 15 : 9,
                  columns: [
                    DataColumn(
                        label: width > 900
                            ? Text('Order ID',
                                style: GoogleFonts.sarabun(
                                    color: Color(0xFF0C4546),
                                    fontSize: ts,
                                    fontWeight: FontWeight.bold))
                            : Text('ID',
                                style: GoogleFonts.sarabun(
                                    color: Color(0xFF0C4546),
                                    fontSize: ts,
                                    fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Name',
                            style: GoogleFonts.sarabun(
                                color: Color(0xFF0C4546),
                                fontSize: ts,
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Location',
                            style: GoogleFonts.sarabun(
                                color: Color(0xFF0C4546),
                                fontSize: ts,
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Date',
                            style: GoogleFonts.sarabun(
                                color: Color(0xFF0C4546),
                                fontSize: ts,
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Amount',
                            style: GoogleFonts.sarabun(
                                color: Color(0xFF0C4546),
                                fontSize: ts,
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: width > 900
                            ? Text('Payment Method',
                                style: GoogleFonts.sarabun(
                                    color: Color(0xFF0C4546),
                                    fontSize: ts,
                                    fontWeight: FontWeight.bold))
                            : Text('Payment',
                                style: GoogleFonts.sarabun(
                                    color: Color(0xFF0C4546),
                                    fontSize: ts,
                                    fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Status',
                            style: GoogleFonts.sarabun(
                                color: Color(0xFF0C4546),
                                fontSize: ts,
                                fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Color(0xFF0C4546),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 25, left: 15, right: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text('As of ${dateNow()}',
                                style: GoogleFonts.sarabun(
                                  color: Colors.white,
                                  fontSize: 12,
                                )),
                            Text(
                              'Total Sales',
                              style: GoogleFonts.sarabun(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Text("Php ${numFormat.format(totalSales)}",
                            style: GoogleFonts.sarabun(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyData extends DataTableSource {
  FirestoreService firestoreService = FirestoreService();
  FirebaseFirestore? db;
  final List<Map<String, dynamic>> _data = [];
  double totalSales = 0;
  NumberFormat numFormat = NumberFormat('###,###,###,###', 'en_US');
  double ts = 11;

  MyData() {
    loadAllDatas();
  }

  formatTime(Timestamp timeStamp) {
    DateTime dateTime = timeStamp.toDate();
    return DateFormat('MM/dd/yy').format(dateTime);
  }

  loadAllDatas() {
    FirebaseFirestore? db;
    print('america ya :D');
    db = FirebaseFirestore.instance;

    db
        .collection('orders')
        .orderBy('orderID', descending: true)
        .snapshots()
        .listen((value) {
      _data.clear();
      for (var docSnapshot in value.docs) {
        print('${docSnapshot.id} => ${docSnapshot.data()['name']}');
        // docSnapshot.data()['orderID'] = 12;
        print(formatTime(docSnapshot.data()['date']));
        totalSales += docSnapshot.data()['amount'];
        _data.add(docSnapshot.data());
      }
      print(_data);
      print("lenght of data ${_data.length}");
      print("totes $totalSales");
      notifyListeners();
    });
  }

  // getData(int index, String dataName) {
  //   if (dataName == 'orderID') {
  //     return Text(_data[index][dataName] ?? '${index + 1}',
  //         style: TextStyle(fontSize: ts));
  //   } else if (dataName == 'date') {
  //     Text(formatTime(_data[index]['date']) ?? '',
  //         style: TextStyle(fontSize: ts));
  //   } else if (dataName == 'amount') {
  //     return Text(numFormat.format(_data[index]['amount']),
  //         style: TextStyle(fontSize: ts));
  //   } else {
  //     return Text(_data[index][dataName] ?? '', style: TextStyle(fontSize: ts));
  //   }
  // }

  splitName(int index) {
    String fullName = _data[index]['name'];
    var splitName = fullName.split(' ');
    if (splitName.length == 1) {
      return fullName;
    } else {
      String shortName = '${splitName[0]} ${splitName[1][0]}.';
      return shortName;
    }
  }

  splitLoc(index) {
    String full = _data[index]['location'];
    var split = full.split(' ');
    if (split.length == 1) {
      return full;
    } else if (split.length == 2) {
      String shortTwo = '${split[0]} ${split[1][0]}.';
      return shortTwo;
    } else {
      String shortThree = '${split[0]} ${split[1]} ${split[2][0]}.';
      return shortThree;
    }
  }

  @override
  DataRow? getRow(int index) {
    // TODO: implement getRow
    if (index >= _data.length) return null;
    return DataRow(cells: [
      DataCell(Text(_data[index]['oderID'] ?? '${index + 1}',
          style: TextStyle(fontSize: ts))),
      DataCell(Text(splitName(index) ?? '', style: TextStyle(fontSize: ts))),
      DataCell(Text(splitLoc(index) ?? '', style: TextStyle(fontSize: ts))),
      DataCell(Text(formatTime(_data[index]['date']) ?? '',
          style: TextStyle(fontSize: ts))),
      DataCell(Text(numFormat.format(_data[index]['amount']),
          style: TextStyle(fontSize: ts))),
      DataCell(Text(_data[index]['payment_method'] ?? '',
          style: TextStyle(fontSize: ts))),
      DataCell(
          Text(_data[index]['status'] ?? '', style: TextStyle(fontSize: ts))),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => _data.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}

//TODO: name make shorter also location if possible
//dropdown make work
//ui fixes 