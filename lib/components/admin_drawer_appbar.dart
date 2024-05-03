import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repel/admin_screens/admin_buyers_datatable.dart';
import 'package:repel/admin_screens/admin_interested.dart';
import 'package:repel/admin_screens/admin_home.dart';
import 'package:repel/admin_screens/admin_messages.dart';
import 'package:repel/admin_screens/admin_buyers.dart';
import 'package:repel/admin_screens/admin_sales.dart';
import 'package:repel/components/textstyle.dart';

Widget RDrawer(BuildContext context, List orderDatas) {
  return Drawer(
    child: Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.grey[200],
        ),
        ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bluegreen.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                  child: Container(
                      height: 100,
                      width: 100,
                      child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Frepellogo.png?alt=media&token=f7a0ffa1-eb7b-425e-85f6-830ef76b32e4'))),
            ),
            Container(
              height: 120,
            ),
            ListTile(
              leading: Icon(
                Icons.stacked_line_chart,
                color: Color.fromARGB(255, 12, 69, 70),
              ),
              title: Text(
                'Dashboard',
                style: GoogleFonts.firaSansCondensed(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 12, 69, 70),
                  fontSize: 22,
                ),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AdminHome()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.messenger,
                color: Color.fromARGB(255, 12, 69, 70),
              ),
              title: Text(
                'Messages',
                style: GoogleFonts.firaSansCondensed(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 12, 69, 70),
                  fontSize: 22,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AdminMessages()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.group,
                color: Color.fromARGB(255, 12, 69, 70),
              ),
              title: Text(
                'Interested',
                style: GoogleFonts.firaSansCondensed(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 12, 69, 70),
                  fontSize: 22,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AdminBuyers()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.group,
                color: Color.fromARGB(255, 12, 69, 70),
              ),
              title: Badge(
                label: Text("${orderDatas.length.toString()}"),
                child: Text(
                  'Buyers',
                  style: GoogleFonts.firaSansCondensed(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 12, 69, 70),
                    fontSize: 22,
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AdminPurchase()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.content_paste,
                color: Color.fromARGB(255, 12, 69, 70),
              ),
              title: Text(
                'Buyer Details',
                style: GoogleFonts.firaSansCondensed(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 12, 69, 70),
                  fontSize: 22,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AdminBuyerDataTable()));
              },
            ),
          ],
        ),
      ],
    ),
  );
}

PreferredSizeWidget RAppBar(context, orderDatas) {
  final width = MediaQuery.of(context).size.width;
  return width > 780
      ? AppBar(
          flexibleSpace: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fappbar.png?alt=media&token=29e0f034-d748-472b-9f40-ea525b654f5b',
                fit: BoxFit.cover,
              ),
            ],
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AdminHome())),
                child: Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Frepel.png?alt=media&token=f5c682e7-c340-407c-a315-ede9b367d898',
                ),
              ),
            ),
          ),
          leadingWidth: 200,
          actions: [
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => AdminHome()));
                    },
                    child: Text('Dashboard', style: getNavStyle(context))),
                Container(width: 30),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AdminMessages()));
                    },
                    child: Text('Inbox', style: getNavStyle(context))),
                Container(width: 30),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AdminBuyers()));
                    },
                    child: Text('Interested', style: getNavStyle(context))),
                Container(width: 30),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AdminPurchase()));
                    },
                    child: Badge(
                        label: Text("${orderDatas.length.toString()}"),
                        child: Text('Buyers', style: getNavStyle(context)))),
                Container(width: 30),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AdminBuyerDataTable()));
                    },
                    child: Text('Buyer Details', style: getNavStyle(context))),
                Container(width: 50)
              ],
            ),
          ],
        )
      : AppBar(
          flexibleSpace: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fappbar.png?alt=media&token=29e0f034-d748-472b-9f40-ea525b654f5b',
                fit: BoxFit.cover,
              ),
            ],
          ),
          actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AdminHome())),
                    child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Frepel.png?alt=media&token=f5c682e7-c340-407c-a315-ede9b367d898'),
                  ),
                ),
              ),
            ]);
}

PreferredSizeWidget RRAppBar(context) {
  final width = MediaQuery.of(context).size.width;
  return width > 780
      ? AppBar(
          flexibleSpace: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fappbar.png?alt=media&token=29e0f034-d748-472b-9f40-ea525b654f5b',
                fit: BoxFit.cover,
              ),
            ],
          ),
          leadingWidth: 200,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Frepel.png?alt=media&token=f5c682e7-c340-407c-a315-ede9b367d898'),
            ),
          ),
        )
      : AppBar(
          flexibleSpace: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fappbar.png?alt=media&token=29e0f034-d748-472b-9f40-ea525b654f5b',
                fit: BoxFit.cover,
              ),
            ],
          ),
          actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Frepel.png?alt=media&token=f5c682e7-c340-407c-a315-ede9b367d898'),
                ),
              ),
            ]);
}
