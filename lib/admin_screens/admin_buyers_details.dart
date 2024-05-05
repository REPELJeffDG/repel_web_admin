import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:repel/components/admin_drawer_appbar.dart';
import 'package:repel/admin_screens/admin_proof.dart';
import 'package:repel/services/firestore.dart';

// ignore: must_be_immutable
class AdminBuyerDetails extends StatefulWidget {
  Map<String, dynamic> data;
  AdminBuyerDetails({super.key, required this.data});

  @override
  State<AdminBuyerDetails> createState() => _AdminBuyerDetailsState(data: data);
}

class _AdminBuyerDetailsState extends State<AdminBuyerDetails> {
  FirestoreService firestoreService = FirestoreService();
  NumberFormat numFormat = NumberFormat('###,###,###,###', 'en_US');

  Map<String, dynamic> data;
  _AdminBuyerDetailsState({required this.data});
  late String name;
  late String location;
  late String paymentMethod;
  late int amount;
  late String status;
  late List fileLinkList = [];
  late Timestamp date;
  late String id;
  late String installment;

  List paidList = [];
  FirebaseFirestore? db;

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
    db = FirebaseFirestore.instance;

    name = data['name'];
    location = data['location'];
    paymentMethod = data['payment_method'];
    amount = data['amount'];
    paidList.add(false);
    paidList.add(false);
    paidList.add(false);
    paidList.add(false);
    paidList.add(false);
    fileLinkList.add("data['fileLink']");
    fileLinkList.add("data['fileLink2']");
    fileLinkList.add("data['fileLink3']");
    fileLinkList.add("data['fileLink4']");
    fileLinkList.add("data['fileLink5']");
    installment = data['installment'];
    status = data['status'];
    date = data['date'];
    id = data['id'];
    print('ALL DATA IS OK NA');
    print(paidList);
    print(fileLinkList);
  }

  formatTime(Timestamp timeStamp) {
    DateTime dateTime = timeStamp.toDate();
    return DateFormat('MM/dd/yy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return paidList.isEmpty || fileLinkList.isEmpty
        ? CircularProgressIndicator()
        : Scaffold(
            appBar: AppBar(
              flexibleSpace: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fappbar.png?alt=media&token=29e0f034-d748-472b-9f40-ea525b654f5b',
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              title: Text('${widget.data['name']}'),
            ),
            drawer: RDrawer(context, orderDatas),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Center(
                child: Container(
                  width: 500,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 25),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Name:',
                                        style: GoogleFonts.firaSansCondensed(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 12, 69, 70),
                                        ),
                                      ),
                                      Text(name),
                                    ],
                                  ),
                                  Container(height: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Date:',
                                        style: GoogleFonts.firaSansCondensed(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 12, 69, 70),
                                        ),
                                      ),
                                      Text(formatTime(date)),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Address:',
                                    style: GoogleFonts.firaSansCondensed(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 12, 69, 70),
                                    ),
                                  ),
                                  Text(location),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(25),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(width: 50),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Amount:',
                                                style: GoogleFonts
                                                    .firaSansCondensed(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 12, 69, 70),
                                                ),
                                              ),
                                              Text(numFormat.format(amount))
                                            ],
                                          ),
                                          Container(height: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Payment Method:',
                                                style: GoogleFonts
                                                    .firaSansCondensed(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 12, 69, 70),
                                                ),
                                              ),
                                              Text(paymentMethod)
                                            ],
                                          ),
                                          Container(height: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Status:',
                                                style: GoogleFonts
                                                    .firaSansCondensed(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 12, 69, 70),
                                                ),
                                              ),
                                              Text(status)
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Installment:',
                                    style: GoogleFonts.firaSansCondensed(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 12, 69, 70),
                                    ),
                                  ),
                                  Text(installment),
                                  Text(
                                    'Paid:',
                                    style: GoogleFonts.firaSansCondensed(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 12, 69, 70),
                                    ),
                                  ),
                                  installment == '5 Months'
                                      ? switchList()
                                      : paidList.isEmpty
                                          ? CircularProgressIndicator()
                                          : Switch(
                                              value: paidList[0],
                                              onChanged: (value) {
                                                setState(() {
                                                  paidList[0] = value;
                                                });
                                              }),
                                  Container(height: 10),
                                  Column(
                                    children: [
                                      Text(
                                        'Payment Proof:',
                                        style: GoogleFonts.firaSansCondensed(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 12, 69, 70),
                                        ),
                                      ),
                                      installment == '5 Months'
                                          ? proofList()
                                          : fileLinkList.isEmpty
                                              ? CircularProgressIndicator()
                                              : fileLinkList[0] == 'null'
                                                  ? Text('N/A')
                                                  : TextButton(
                                                      onPressed: () {
                                                        ProofDialog.show(
                                                            context,
                                                            fileLinkList[0]);
                                                      },
                                                      child: Text(
                                                        'View',
                                                      ))
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(200, 45),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                backgroundColor: Color(0xFFDCB03B),
                              ),
                              onPressed: () async {
                                installment == '5 Months'
                                    ? await firestoreService.updatePaid(
                                        id,
                                        paidList[0],
                                        paidList[1],
                                        paidList[2],
                                        paidList[3],
                                        paidList[4],
                                      )
                                    : await firestoreService.updateData(
                                        id, paidList[0]);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Successfully saved all changes')));
                                setState(() {});
                              },
                              child: Text(
                                'Save Changes',
                                style: GoogleFonts.firaSansCondensed(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 12, 69, 70),
                                ),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Widget switchList() {
    return paidList.isEmpty
        ? CircularProgressIndicator()
        : Row(
            children: [
              Switch(
                  value: paidList[0],
                  onChanged: (value) {
                    setState(() {
                      paidList[0] = value;
                    });
                  }),
              Switch(
                  value: paidList[1],
                  onChanged: (value) {
                    setState(() {
                      paidList[1] = value;
                    });
                  }),
              Switch(
                  value: paidList[2],
                  onChanged: (value) {
                    setState(() {
                      paidList[2] = value;
                    });
                  }),
              Switch(
                  value: paidList[3],
                  onChanged: (value) {
                    setState(() {
                      paidList[3] = value;
                    });
                  }),
              Switch(
                  value: paidList[4],
                  onChanged: (value) {
                    setState(() {
                      paidList[4] = value;
                    });
                  }),
            ],
          );
  }

  Widget proofList() {
    return fileLinkList.isEmpty
        ? CircularProgressIndicator()
        : Row(
            children: [
              fileLinkList[0] == 'null'
                  ? Text('N/A')
                  : TextButton(
                      onPressed: () {
                        ProofDialog.show(context, fileLinkList[0]);
                      },
                      child: Text(
                        'View',
                      )),
              fileLinkList[2] == 'null'
                  ? Text('N/A')
                  : TextButton(
                      onPressed: () {
                        ProofDialog.show(context, fileLinkList[2]);
                      },
                      child: Text(
                        'View',
                      )),
              fileLinkList[3] == 'null'
                  ? Text('N/A')
                  : TextButton(
                      onPressed: () {
                        ProofDialog.show(context, fileLinkList[3]);
                      },
                      child: Text(
                        'View',
                      )),
              fileLinkList[4] == 'null'
                  ? Text('N/A')
                  : TextButton(
                      onPressed: () {
                        ProofDialog.show(context, fileLinkList[4]);
                      },
                      child: Text(
                        'View',
                      )),
              fileLinkList[5] == 'null'
                  ? Text('N/A')
                  : TextButton(
                      onPressed: () {
                        ProofDialog.show(context, fileLinkList[5]);
                      },
                      child: Text(
                        'View',
                      ))
            ],
          );
  }
}
