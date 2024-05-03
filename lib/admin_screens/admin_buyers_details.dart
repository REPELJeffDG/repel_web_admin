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
  late String fileLink;
  late Timestamp date;
  late String id;

  bool paid = false;
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
    paid = data['status'] == "Pending" ? false : true;
    name = data['name'];
    location = data['location'];
    paymentMethod = data['payment_method'];
    amount = data['amount'];
    fileLink = data['fileLink'];
    status = data['status'];
    date = data['date'];
    id = data['id'];
  }

  formatTime(Timestamp timeStamp) {
    DateTime dateTime = timeStamp.toDate();
    return DateFormat('MM/dd/yy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name:',
                                  style: GoogleFonts.firaSansCondensed(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 12, 69, 70),
                                  ),
                                ),
                                Text(name),
                              ],
                            ),
                            Container(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Date:',
                                  style: GoogleFonts.firaSansCondensed(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 12, 69, 70),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(width: 50),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Amount:',
                                          style: GoogleFonts.firaSansCondensed(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 12, 69, 70),
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
                                          style: GoogleFonts.firaSansCondensed(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 12, 69, 70),
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
                                          style: GoogleFonts.firaSansCondensed(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 12, 69, 70),
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
                              'Paid:',
                              style: GoogleFonts.firaSansCondensed(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 12, 69, 70),
                              ),
                            ),
                            Switch(
                                value: paid,
                                onChanged: (value) {
                                  setState(() {
                                    paid = value;
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
                                    color: Color.fromARGB(255, 12, 69, 70),
                                  ),
                                ),
                                fileLink == 'null'
                                    ? Text('N/A')
                                    : TextButton(
                                        onPressed: () {
                                          ProofDialog.show(context, fileLink);
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
                          await firestoreService.updateData(id, paid);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Successfully saved all changes')));
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
}
