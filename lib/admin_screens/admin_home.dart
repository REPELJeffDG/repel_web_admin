// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:repel/admin_screens/admin_buyers.dart';
import 'package:repel/admin_screens/admin_buyers_datatable.dart';
import 'package:repel/admin_screens/admin_interested.dart';
import 'package:repel/admin_screens/admin_sales.dart';
import 'package:repel/components/admin_drawer_appbar.dart';
import 'package:repel/admin_screens/admin_login.dart';
import 'package:repel/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Admin',
        home: SplashScreenAdmin());
  }
}

class SplashScreenAdmin extends StatelessWidget {
  const SplashScreenAdmin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminLogin()),
      );
    });

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fconcrete.png?alt=media&token=d563705a-f551-47c0-b4d1-382f92558df5',
            fit: BoxFit.cover,
          ),
          Center(
            child: Container(
              height: 200,
              width: 200,
              child: Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Frepellogo.png?alt=media&token=f7a0ffa1-eb7b-425e-85f6-830ef76b32e4'),
            ),
          ),
        ],
      ),
    );
  }
}

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width > 780 ? AdminHomeWeb() : AdminSales();
  }
}

class AdminHomeWeb extends StatefulWidget {
  const AdminHomeWeb({super.key});

  @override
  State<AdminHomeWeb> createState() => _AdminHomeWebState();
}

class _AdminHomeWebState extends State<AdminHomeWeb> {
  NumberFormat numFormat = NumberFormat('###,###,###,###.00', 'en_US');
  NumberFormat numFormattwo = NumberFormat('###,###,###,###', 'en_US');
  final List<Map<String, dynamic>> _data = [];
  final List<Map<String, dynamic>> _data2 = [];
  double totalSales = 0;
  int totalBuyers = 0;
  int totalInterested = 0;
  int currentIndex = 0;
  List orderDatas = [];

  final bottomTitles = {
    0: 'Mon',
    1: 'Tue',
    2: 'Wed',
    3: 'Thu',
    4: 'Fri',
    5: 'Sat',
    6: 'Sun'
  };

  final leftTitles = {
    0: '0',
    2: '20k',
    4: '40k',
    6: '60k',
  };

  loadAllDatas() {
    FirebaseFirestore? db;
    print('america ya :D');
    db = FirebaseFirestore.instance;

    db
        .collection('users')
        .orderBy('timestamp', descending: true)
        .get()
        .then((value) {
      _data2.clear();
      for (var docSnapshot in value.docs) {
        print('${docSnapshot.id} => ${docSnapshot.data()['name']}');
        _data2.add(docSnapshot.data());
      }
      print(_data2);
      print("lenght of data2 ${_data2.length}");
      setState(() {
        totalInterested = _data2.length;
      });
    });

    db
        .collection('orders')
        .orderBy('orderID', descending: true)
        .get()
        .then((value) {
      _data.clear();
      for (var docSnapshot in value.docs) {
        print('${docSnapshot.id} => ${docSnapshot.data()['name']}');
        _data.add(docSnapshot.data());
      }
      print(_data);
      print("lenght of data ${_data.length}");
      print("totes $totalSales");
      setState(() {
        totalBuyers = _data.length;
        for (int i = 0; i < totalBuyers; i++) {
          print("AMOUNT => ${_data[i]['amount']}");
          totalSales += _data[i]['amount'];
        }
      });
    });
  }

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
    loadAllDatas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RAppBar(context, orderDatas),
      drawer: RDrawer(context, orderDatas),
      body: Stack(
        children: [
          Container(
            color: Color(0xFFCECECE),
            width: double.infinity,
            height: double.infinity,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 900,
              height: 505,
              child: Image.network(
                  fit: BoxFit.cover,
                  'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fmockappweb2.png?alt=media&token=fd4b9130-c4ef-4615-a021-1d91a7242970'),
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text('E X E C U T I V E   D A S H B O A R D',
                        style: GoogleFonts.firaSansCondensed(
                            color: Color(0xFF0C4546),
                            fontWeight: FontWeight.bold,
                            fontSize: 25)),
                  ),
                  Column(children: [
                    Container(height: 15),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        AdminBuyerDataTable()));
                              },
                              child: Card(
                                elevation: 9,
                                clipBehavior: Clip.antiAlias,
                                child: Container(
                                  color: Color(0xFFFDDC82),
                                  width: 130,
                                  height: 120,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Total Sales',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.sarabun(
                                            color: Color(0xFF0C4546),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        'PhP ${numFormat.format(totalSales)}',
                                        style: GoogleFonts.sarabun(
                                            color: Color(0xFF0C4546),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Container(height: 10)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(width: 15),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AdminPurchase()));
                              },
                              child: Card(
                                elevation: 9,
                                clipBehavior: Clip.antiAlias,
                                child: Container(
                                  color: Color(0xFFFDDC82),
                                  width: 130,
                                  height: 120,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Total Buyers',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.sarabun(
                                            color: Color(0xFF0C4546),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        numFormattwo.format(totalBuyers),
                                        style: GoogleFonts.sarabun(
                                            color: Color(0xFF0C4546),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Container(height: 10)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(width: 15),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AdminBuyers()));
                              },
                              child: Card(
                                elevation: 9,
                                clipBehavior: Clip.antiAlias,
                                child: Container(
                                  color: Color(0xFFFDDC82),
                                  width: 130,
                                  height: 120,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Total Interested Customers',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.sarabun(
                                            color: Color(0xFF0C4546),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        numFormattwo.format(totalInterested),
                                        style: GoogleFonts.sarabun(
                                            color: Color(0xFF0C4546),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Container(height: 10)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 10,
                    ),
                    // Card(
                    //   child: Container(
                    //     height: 400,
                    //     width: 480,
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(
                    //           horizontal: 25, vertical: 10),
                    //       child: Column(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         children: [
                    //           Align(
                    //             alignment: Alignment.centerLeft,
                    //             child: Column(children: [
                    //               Text('Reports',
                    //                   style: GoogleFonts.sarabun(
                    //                       fontWeight: FontWeight.bold,
                    //                       fontSize: 18)),
                    //               Text('Last 7 Days',
                    //                   style: GoogleFonts.sarabun(
                    //                       color: Colors.grey,
                    //                       fontWeight: FontWeight.w400,
                    //                       fontSize: 12))
                    //             ]),
                    //           ),
                    //           Container(height: 10),
                    //           Row(
                    //             children: [
                    //               Padding(
                    //                 padding: const EdgeInsets.only(
                    //                     bottom: 8.0, top: 8.0, right: 8.0),
                    //                 child: Column(
                    //                     crossAxisAlignment:
                    //                         CrossAxisAlignment.start,
                    //                     children: [
                    //                       Text('24k',
                    //                           style: GoogleFonts.sarabun(
                    //                               fontWeight: FontWeight.bold,
                    //                               fontSize: 18)),
                    //                       Text('Customers',
                    //                           style: GoogleFonts.sarabun(
                    //                               color: Colors.grey,
                    //                               fontWeight: FontWeight.w400,
                    //                               fontSize: 12))
                    //                     ]),
                    //               ),
                    //               Padding(
                    //                 padding: const EdgeInsets.all(8.0),
                    //                 child: Column(
                    //                     crossAxisAlignment:
                    //                         CrossAxisAlignment.start,
                    //                     children: [
                    //                       Text('3.5k',
                    //                           style: GoogleFonts.sarabun(
                    //                               fontWeight: FontWeight.bold,
                    //                               fontSize: 18)),
                    //                       Text('Total Products',
                    //                           style: GoogleFonts.sarabun(
                    //                               color: Colors.grey,
                    //                               fontWeight: FontWeight.w400,
                    //                               fontSize: 12))
                    //                     ]),
                    //               ),
                    //               Padding(
                    //                 padding: const EdgeInsets.all(8.0),
                    //                 child: Column(
                    //                     crossAxisAlignment:
                    //                         CrossAxisAlignment.start,
                    //                     children: [
                    //                       Text('2.5k',
                    //                           style: GoogleFonts.sarabun(
                    //                               fontWeight: FontWeight.bold,
                    //                               fontSize: 18)),
                    //                       Text('Stock Products',
                    //                           style: GoogleFonts.sarabun(
                    //                               color: Colors.grey,
                    //                               fontWeight: FontWeight.w400,
                    //                               fontSize: 12))
                    //                     ]),
                    //               )
                    //             ],
                    //           ),
                    //           Container(height: 25),
                    //           //ling chart
                    //           AspectRatio(
                    //             aspectRatio: 12 / 6,
                    //             child: LineChart(LineChartData(
                    //                 borderData: FlBorderData(show: false),
                    //                 minX: 0,
                    //                 maxX: 6,
                    //                 minY: 0,
                    //                 maxY: 6,
                    //                 lineBarsData: [
                    //                   LineChartBarData(
                    //                       dotData: FlDotData(show: false),
                    //                       spots: [
                    //                         //idunno how to database this lmao
                    //                         FlSpot(0, 0.5),
                    //                         FlSpot(1, 2),
                    //                         FlSpot(1.5, 2),
                    //                         FlSpot(1.7, 2.5),
                    //                         FlSpot(2, 3.4),
                    //                         FlSpot(2.2, 2.5),
                    //                         FlSpot(3.1, 2.7),
                    //                         FlSpot(3.2, 3.5),
                    //                         FlSpot(4, 4),
                    //                         FlSpot(4.2, 3),
                    //                         FlSpot(4.9, 2.5),
                    //                         FlSpot(5, 3.2),
                    //                         FlSpot(5.5, 4),
                    //                         FlSpot(5.8, 3),
                    //                         FlSpot(6, 3),
                    //                       ])
                    //                 ],
                    //                 gridData: FlGridData(show: false),
                    //                 titlesData: FlTitlesData(
                    //                     rightTitles: AxisTitles(
                    //                         sideTitles:
                    //                             SideTitles(showTitles: false)),
                    //                     topTitles: AxisTitles(
                    //                         sideTitles:
                    //                             SideTitles(showTitles: false)),
                    //                     bottomTitles: AxisTitles(
                    //                         sideTitles: SideTitles(
                    //                       showTitles: true,
                    //                       getTitlesWidget: (value, meta) {
                    //                         return bottomTitles[value] != null
                    //                             ? SideTitleWidget(
                    //                                 child: Text(
                    //                                   bottomTitles[value]
                    //                                       .toString(),
                    //                                   style: TextStyle(
                    //                                       fontSize: 12,
                    //                                       color: Colors.grey),
                    //                                 ),
                    //                                 axisSide: meta.axisSide)
                    //                             : Container();
                    //                       },
                    //                     )),
                    //                     leftTitles: AxisTitles(
                    //                         sideTitles: SideTitles(
                    //                       reservedSize: 30,
                    //                       showTitles: true,
                    //                       getTitlesWidget: (value, meta) {
                    //                         return leftTitles[value.toInt()] !=
                    //                                 null
                    //                             ? SideTitleWidget(
                    //                                 child: Text(
                    //                                   leftTitles[value.toInt()]
                    //                                       .toString(),
                    //                                   style: TextStyle(
                    //                                       fontSize: 12,
                    //                                       color: Colors.grey),
                    //                                 ),
                    //                                 axisSide: meta.axisSide)
                    //                             : Container();
                    //                       },
                    //                     ))))),
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ]),
                ],
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(top: 50, right: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                      child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Faquardent.png?alt=media&token=6f178d20-8cee-4437-8035-3304a7e697db',
                        scale: 1,
                      ),
                    ),
                    Container(height: 25),
                    Row(
                      children: [
                        Spacer(),
                        Container(
                          width: 50,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Container(
                            height: 240,
                            width: 120,
                            child: Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fsixicons.png?alt=media&token=b4e2c872-9ebc-479a-a05c-2bdcf6a530d9')),
                        Container(
                          width: 50,
                        ),
                      ],
                    )
                  ],
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}
