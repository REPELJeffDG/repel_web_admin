// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repel/components/admin_drawer_appbar.dart';
import 'package:repel/services/firestore.dart';

class AdminMessages extends StatefulWidget {
  const AdminMessages({super.key});

  @override
  State<AdminMessages> createState() => _AdminMessagesState();
}

class _AdminMessagesState extends State<AdminMessages> {
  FirestoreService firestoreService = FirestoreService();
  FirebaseFirestore? db;
  List contactUsList = [];
  List orderDatas = [];
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    loadAllDatas();
    loadAllORderDatas();
  }

  loadAllDatas() {
    db = FirebaseFirestore.instance;

    db!
        .collection('contactUs')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((value) {
      contactUsList = [];
      for (var docSnapshot in value.docs) {
        print('${docSnapshot.id} => ${docSnapshot.data()['name']}');
        docSnapshot.data()['id'] = docSnapshot.id;
        contactUsList.add(docSnapshot.data());
      }
      setState(() {});
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
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: RAppBar(context, orderDatas),
      drawer: RDrawer(context, orderDatas),
      body: Stack(children: [
        Image.network(
          'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Ffish.jpg?alt=media&token=5b05d4cd-3ba9-4915-96bc-b371d54caed8',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Opacity(
          opacity: 0.75,
          child: Image.network(
            'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fgreynoise.png?alt=media&token=22c094ff-973f-4ad8-896d-f293a9309a80',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.messenger_rounded,
                        size: 70,
                        color: Color(0xFF0C4546),
                      ),
                      Text('MESSAGES',
                          style: GoogleFonts.firaSansCondensed(
                              color: Color(0xFF0C4546),
                              fontSize: 35,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              StreamBuilder(
                  stream: firestoreService.getContactUsStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List contactUsList = snapshot.data!.docs;
                      return Container(
                        width: double.infinity,
                        height: 520,
                        child: GridView.builder(
                            shrinkWrap: false,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: width > 780 ? 5 : 2),
                            itemCount: contactUsList.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot doc = contactUsList[index];
                              String docID = doc.id;
                              String nameI = contactUsList[index]['name'];
                              String emailI = contactUsList[index]['email'];
                              String messageI = contactUsList[index]['message'];
                              return Padding(
                                padding: const EdgeInsets.only(
                                    right: 7, left: 7, bottom: 5),
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 500,
                                        child: ListTile(
                                          onTap: () {},
                                          title: Text(
                                            nameI,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          subtitle: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    emailI,
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  )),
                                              Container(
                                                height: 5,
                                              ),
                                              Center(
                                                  child: Text('"${messageI}"',
                                                      style: TextStyle(
                                                          fontSize: 16))),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.bottomRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextButton(
                                                onPressed: () {
                                                  firestoreService
                                                      .deleteMsg(docID);
                                                },
                                                child: Icon(
                                                  Icons.delete_outline_rounded,
                                                  color: Color(0xFF920000),
                                                  size: 30,
                                                )),
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    } else {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFF0C4546))),
                          Center(
                            child: Text(
                              'Loading data...',
                              style: TextStyle(
                                  color: Color(0xFF0C4546), fontSize: 16),
                            ),
                          ),
                        ],
                      );
                    }
                  })
            ],
          ),
        )
      ]),
    );
  }
}
