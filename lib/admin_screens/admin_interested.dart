// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repel/admin_screens/myprofile.dart';
import 'package:repel/components/admin_drawer_appbar.dart';
import 'package:repel/services/firestore.dart';

class AdminBuyers extends StatefulWidget {
  const AdminBuyers({super.key});

  @override
  State<AdminBuyers> createState() => _AdminBuyersState();
}

class _AdminBuyersState extends State<AdminBuyers> {
  FirestoreService firestoreService = FirestoreService();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RAppBar(context, orderDatas),
      drawer: RDrawer(context, orderDatas),
      body: Stack(
        children: [
          Image.network(
            'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fbuyersbg.jpg?alt=media&token=0d375b20-af7a-4dab-9aa2-33746ce7696a',
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
                          Icons.person,
                          size: 80,
                          color: Color(0xFF0C4546),
                        ),
                        Text('INTERESTED',
                            style: GoogleFonts.firaSansCondensed(
                                color: Color(0xFF0C4546),
                                fontSize: 35,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                StreamBuilder(
                    stream: firestoreService.getUsersStream(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List usersList = snapshot.data!.docs;
                        return Container(
                          width: double.infinity,
                          height: 520,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: false,
                              itemCount: usersList.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot document = usersList[index];
                                Map<String, dynamic> data =
                                    document.data() as Map<String, dynamic>;
                                String nameI = data['name'];
                                String emailI = data['email'];
                                String docID = document.id;
                                //bool isAdmin = data['isAdmin'];
                                //make it so only non admin show ups
                                //ok na, separate docs for each acc
                                return Stack(
                                  children: [
                                    Container(
                                      color: Color(0xFFA0A0A0),
                                      height: 60,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 2, bottom: 1),
                                      child: Container(
                                        color: Color(0xFFD9D9D9),
                                        height: 58,
                                        child: ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyProfile(
                                                            docID: docID)));
                                          },
                                          title: Text(
                                            nameI,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Column(
                                            children: [
                                              Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(emailI)),
                                              Container(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
                            Text(
                              'Loading data...',
                              style: TextStyle(
                                  color: Color(0xFF0C4546), fontSize: 16),
                            ),
                          ],
                        );
                      }
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
