import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:repel/main.dart';

class MyProfile extends StatefulWidget {
  MyProfile({Key? key, required this.docID}) : super(key: key);
  String docID;

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String date = 'N/A';
  String name = 'N/A';
  String birthdate = 'N/A';
  String address = 'N/A';
  String amount = 'N/A';
  String paymentMethod = 'N/A';
  String status = 'N/A';
  String installment = '5 Months';
  List fileLinkList = [];
  List paidList = [];

  NumberFormat numFormat = NumberFormat('###,###,###,###', 'en_US');

  Future<bool> checkExist(String docID) async {
    bool exist = false;
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      await db.collection('orders').doc(docID).get().then((doc) {
        exist = doc.exists;
      });
      return exist;
    } catch (e) {
      print("WHYYYY $e");
      // If any error
      return false;
    }
  }

  Future<void> loadData() async {
    bool exist = await checkExist(widget.docID);
    if (exist) {
      FirebaseFirestore db = FirebaseFirestore.instance;
      final docRef = db.collection("orders").doc(widget.docID);
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          fileLinkList.add(data['fileLink']);
          fileLinkList.add(data['fileLink2']);
          fileLinkList.add(data['fileLink3']);
          fileLinkList.add(data['fileLink4']);
          fileLinkList.add(data['fileLink5']);
          paidList.add(data['paid']);
          paidList.add(data['paid2']);
          paidList.add(data['paid3']);
          paidList.add(data['paid4']);
          paidList.add(data['paid5']);
          amount = "Php ${numFormat.format(data['amount'])}";
          paymentMethod = data['payment_method'];
          status = data['status'];
          installment = data['installment'];
          date = formatTime(data['date']).toString();
          setState(() {});
          print(fileLinkList);
        },
        onError: (e) => print("Error getting document: $e"),
      );
    }
  }

  Future<bool> checkExist2(String docID) async {
    bool exist = false;
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      await db.collection('users').doc(docID).get().then((doc) {
        exist = doc.exists;
      });
      return exist;
    } catch (e) {
      // If any error
      print("WHYYYY2 $e");
      return false;
    }
  }

  Future<void> loadData2() async {
    bool exist = await checkExist2(widget.docID);
    if (exist) {
      FirebaseFirestore db = FirebaseFirestore.instance;
      final docRef = db.collection("users").doc(widget.docID);
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          name = data['name'];
          birthdate = data['birthdate'];
          address = data['address'];
          setState(() {});
        },
        onError: (e) => print("Error getting document: $e"),
      );
    }
  }

  formatTime(Timestamp timeStamp) {
    DateTime dateTime = timeStamp.toDate();
    return DateFormat('MM/dd/yy').format(dateTime);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    loadData2();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return width > 780
        ? MyProfileWeb(
            width: width,
            height: height,
            date: date,
            name: name,
            birthdate: birthdate,
            address: address,
            amount: amount,
            paymentMethod: paymentMethod,
            status: status,
            paidList: paidList,
            fileLinkList: fileLinkList,
            installment: installment,
          )
        : MyProfileMobile(
            width: width,
            height: height,
            date: date,
            name: name,
            birthdate: birthdate,
            address: address,
            amount: amount,
            paymentMethod: paymentMethod,
            status: status,
            paidList: paidList,
            fileLinkList: fileLinkList,
            installment: installment,
          );
  }
}

class MyProfileWeb extends StatefulWidget {
  MyProfileWeb(
      {super.key,
      required this.width,
      required this.height,
      required this.date,
      required this.name,
      required this.birthdate,
      required this.address,
      required this.amount,
      required this.paymentMethod,
      required this.status,
      required this.paidList,
      required this.fileLinkList,
      required this.installment});

  final double width;
  final double height;
  String date;
  String name;
  String birthdate;
  String address;
  String amount;
  String paymentMethod;
  String status;
  List paidList;
  List fileLinkList;
  String installment;

  @override
  State<MyProfileWeb> createState() => _MyProfileWebState();
}

class _MyProfileWebState extends State<MyProfileWeb> {
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
          title: Text('${widget.name}'),
        ),
        body: Center(
          child: Stack(
            children: [
              Opacity(
                opacity: .6,
                child: Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2FmockappWeb.jpg?alt=media&token=04021a85-edce-41ba-baef-0d466d892ef4',
                  fit: BoxFit.cover,
                  width: widget.width,
                  height: widget.height,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fholisticbanner.png?alt=media&token=1d9e788c-db43-4b04-9e60-38d6eb4290bd',
                          fit: BoxFit.contain,
                          height: 200,
                          width: 400,
                        ),
                      ),
                    ],
                  )),
                  Expanded(child: Column()),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 20, right: 20),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 40),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Date: ${widget.date}',
                                      style: GoogleFonts.firaSansCondensed(
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic,
                                        color: Color.fromARGB(255, 12, 69, 70),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'Status',
                                              style:
                                                  GoogleFonts.firaSansCondensed(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 12, 69, 70),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                widget.status,
                                                style: GoogleFonts
                                                    .firaSansCondensed(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 12, 69, 70),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'Paid',
                                              style:
                                                  GoogleFonts.firaSansCondensed(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 12, 69, 70),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child:
                                                widget.installment == '5 Months'
                                                    ? paidChecks(
                                                        widget.paidList,
                                                        widget.width)
                                                    : Icon(
                                                        widget.paidList[0]
                                                            ? Icons
                                                                .check_circle_outline_sharp
                                                            : Icons
                                                                .remove_circle_outline_sharp,
                                                        size: 35,
                                                        color: Color.fromARGB(
                                                            255, 12, 69, 70),
                                                      ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'Payment Proof',
                                              style:
                                                  GoogleFonts.firaSansCondensed(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 12, 69, 70),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 30,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Name',
                                      style: GoogleFonts.firaSansCondensed(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 12, 69, 70),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.grey[200],
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          widget.name,
                                          style: GoogleFonts.firaSansCondensed(
                                            fontSize: 18,
                                            color:
                                                Color.fromARGB(255, 12, 69, 70),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 10,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Birth Date',
                                      style: GoogleFonts.firaSansCondensed(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 12, 69, 70),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.grey[200],
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          widget.birthdate,
                                          style: GoogleFonts.firaSansCondensed(
                                            fontSize: 18,
                                            color:
                                                Color.fromARGB(255, 12, 69, 70),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 10,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Address',
                                      style: GoogleFonts.firaSansCondensed(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 12, 69, 70),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.grey[200],
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          widget.address,
                                          style: GoogleFonts.firaSansCondensed(
                                            fontSize: 18,
                                            color:
                                                Color.fromARGB(255, 12, 69, 70),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 10,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Amount',
                                      style: GoogleFonts.firaSansCondensed(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 12, 69, 70),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.grey[200],
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          widget.amount,
                                          style: GoogleFonts.firaSansCondensed(
                                            fontSize: 18,
                                            color:
                                                Color.fromARGB(255, 12, 69, 70),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 10,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Payment Method',
                                      style: GoogleFonts.firaSansCondensed(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 12, 69, 70),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.grey[200],
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          widget.paymentMethod,
                                          style: GoogleFonts.firaSansCondensed(
                                            fontSize: 18,
                                            color:
                                                Color.fromARGB(255, 12, 69, 70),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(height: 40),
                                ],
                              ),
                            ),
                          )))
                ],
              )
            ],
          ),
        ));
  }
}

class MyProfileMobile extends StatefulWidget {
  MyProfileMobile(
      {super.key,
      required this.width,
      required this.height,
      required this.date,
      required this.name,
      required this.birthdate,
      required this.address,
      required this.amount,
      required this.paymentMethod,
      required this.status,
      required this.paidList,
      required this.fileLinkList,
      required this.installment});

  final double width;
  final double height;
  String date;
  String name;
  String birthdate;
  String address;
  String amount;
  String paymentMethod;
  String status;
  List paidList;
  List fileLinkList;
  String installment;

  @override
  State<MyProfileMobile> createState() => _MyProfileMobileState();
}

class _MyProfileMobileState extends State<MyProfileMobile> {
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
        title: Text('${widget.name}'),
      ),
      body: Center(
        child: Stack(
          children: [
            Opacity(
              opacity: .6,
              child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fmockappbg.jpg?alt=media&token=b771086e-db2c-40bc-aef7-5a75e308f879',
                fit: BoxFit.cover,
                width: widget.width,
                height: widget.height,
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Date: ${widget.date}',
                        style: GoogleFonts.firaSansCondensed(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Color.fromARGB(255, 12, 69, 70),
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Status',
                                style: GoogleFonts.firaSansCondensed(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 12, 69, 70),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.status,
                                  style: GoogleFonts.firaSansCondensed(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 12, 69, 70),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Paid',
                                style: GoogleFonts.firaSansCondensed(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 12, 69, 70),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: widget.installment == '5 Months'
                                  ? paidChecks(widget.paidList, widget.width)
                                  : Icon(
                                      widget.paidList[0]
                                          ? Icons.check_circle_outline_sharp
                                          : Icons.remove_circle_outline_sharp,
                                      size: 35,
                                      color: Color.fromARGB(255, 12, 69, 70),
                                    ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Payment Proof',
                                style: GoogleFonts.firaSansCondensed(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 12, 69, 70),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 10,
                        ),
                      ],
                    ),
                    Container(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Name',
                        style: GoogleFonts.firaSansCondensed(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 12, 69, 70),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey[200],
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.name,
                            style: GoogleFonts.firaSansCondensed(
                              fontSize: 18,
                              color: Color.fromARGB(255, 12, 69, 70),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Birth Date',
                        style: GoogleFonts.firaSansCondensed(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 12, 69, 70),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey[200],
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.birthdate,
                            style: GoogleFonts.firaSansCondensed(
                              fontSize: 18,
                              color: Color.fromARGB(255, 12, 69, 70),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Address',
                        style: GoogleFonts.firaSansCondensed(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 12, 69, 70),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey[200],
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.address,
                            style: GoogleFonts.firaSansCondensed(
                              fontSize: 18,
                              color: Color.fromARGB(255, 12, 69, 70),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Amount',
                        style: GoogleFonts.firaSansCondensed(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 12, 69, 70),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey[200],
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.amount,
                            style: GoogleFonts.firaSansCondensed(
                              fontSize: 18,
                              color: Color.fromARGB(255, 12, 69, 70),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Payment Method',
                        style: GoogleFonts.firaSansCondensed(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 12, 69, 70),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey[200],
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.paymentMethod,
                            style: GoogleFonts.firaSansCondensed(
                              fontSize: 18,
                              color: Color.fromARGB(255, 12, 69, 70),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _signOut(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  // Restart.restartApp();
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyApp()));
}

Widget paidChecks(List paidList, var width) {
  return paidList.isEmpty
      ? CircularProgressIndicator()
      : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              paidList[0]
                  ? Icons.check_circle_outline_sharp
                  : Icons.remove_circle_outline_sharp,
              size: width > 780 ? 18 : 25,
              color: Color.fromARGB(255, 12, 69, 70),
            ),
            Icon(
              paidList[1]
                  ? Icons.check_circle_outline_sharp
                  : Icons.remove_circle_outline_sharp,
              size: width > 780 ? 18 : 25,
              color: Color.fromARGB(255, 12, 69, 70),
            ),
            Icon(
              paidList[2]
                  ? Icons.check_circle_outline_sharp
                  : Icons.remove_circle_outline_sharp,
              size: width > 780 ? 18 : 25,
              color: Color.fromARGB(255, 12, 69, 70),
            ),
            Icon(
              paidList[3]
                  ? Icons.check_circle_outline_sharp
                  : Icons.remove_circle_outline_sharp,
              size: width > 780 ? 18 : 25,
              color: Color.fromARGB(255, 12, 69, 70),
            ),
            Icon(
              paidList[4]
                  ? Icons.check_circle_outline_sharp
                  : Icons.remove_circle_outline_sharp,
              size: width > 780 ? 18 : 25,
              color: Color.fromARGB(255, 12, 69, 70),
            ),
          ],
        );
}
