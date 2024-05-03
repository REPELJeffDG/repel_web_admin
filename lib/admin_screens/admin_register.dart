// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repel/components/admin_drawer_appbar.dart';
import 'package:repel/admin_screens/admin_login.dart';
import 'package:repel/services/firestore.dart';

class AdminRegister extends StatefulWidget {
  const AdminRegister({super.key});

  @override
  State<AdminRegister> createState() => _AdminRegisterState();
}

class _AdminRegisterState extends State<AdminRegister> {
  final FirestoreService firestoreService = FirestoreService();
  final FirebaseAuthService firebaseAuthService = FirebaseAuthService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isSignIn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RRAppBar(context),
      body: Center(
        child: Stack(
          children: [
            Container(
              color: Color(0xFFCECECE),
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              height: 70,
              width: double.infinity,
              child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fappbar.png?alt=media&token=29e0f034-d748-472b-9f40-ea525b654f5b',
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Center(
                  child: Container(
                    width: 500,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Center(
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 35, vertical: 3),
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Container(
                                      height: 195,
                                      width: 470,
                                      color: Colors.white,
                                      child: Stack(
                                        children: [
                                          Image.network(
                                            'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fbgg.jpg?alt=media&token=61211789-3142-4bce-ab78-0106ac65e4c8',
                                            height: 200,
                                            width: 500,
                                            fit: BoxFit.cover,
                                          ),
                                          Opacity(
                                            opacity: 0.35,
                                            child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Image.network(
                                                    'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Frepellogo.png?alt=media&token=f7a0ffa1-eb7b-425e-85f6-830ef76b32e4')),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 30, left: 30, right: 55),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'REGISTER',
                                                  style: GoogleFonts
                                                      .firaSansCondensed(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 50,
                                                          color: Colors.white),
                                                ),
                                                Text(
                                                    '     Welcome, administrators! Register now for access to our holistic approach pond management system, designed to optimize your fishpond operations.',
                                                    style: GoogleFonts.sarabun(
                                                        fontWeight:
                                                            FontWeight.w100,
                                                        fontSize: 12,
                                                        color: Colors.white))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        Container(height: 2),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          child: Column(
                            children: [
                              Container(height: 4),
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 5),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter name';
                                    } else if (value.length < 4) {
                                      return 'Please enter a valid name';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                  ),
                                  controller: nameController,
                                ),
                              ),
                              Container(height: 4),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Email Address',
                                  style: GoogleFonts.firaSansCondensed(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 12, 69, 70),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 5),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter email address';
                                    } else if (!value.contains('@') &&
                                        !value.contains('.')) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                  ),
                                  controller: emailController,
                                ),
                              ),
                              Container(height: 4),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Password',
                                  style: GoogleFonts.firaSansCondensed(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 12, 69, 70),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 5),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter password';
                                    } else if (value.length < 4) {
                                      return 'Please enter a valid password';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                  ),
                                  controller: passwordController,
                                  obscureText: true,
                                ),
                              ),
                              Container(height: 4),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Phone Number',
                                  style: GoogleFonts.firaSansCondensed(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 12, 69, 70),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 5),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter phone number';
                                    } else if (value.length < 11) {
                                      return 'Please enter a valid phone number';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                  ),
                                  controller: phoneNumController,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              Container(height: 25),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        isSignIn = true;
                                      });
                                      if (_formKey.currentState!.validate()) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Registered Successfully')));
                                        //SIGN IN
                                        firebaseAuthService.signUpWEP(
                                            emailController.text,
                                            passwordController.text,
                                            nameController.text,
                                            phoneNumController.text,
                                            true);

                                        nameController.clear();
                                        emailController.clear();
                                        passwordController.clear();
                                        phoneNumController.clear();
                                        setState(() {
                                          isSignIn = false;
                                        });
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AdminLogin()));
                                      } else {
                                        setState(() {
                                          isSignIn = false;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Please complete the form')));
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(250, 45),
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: Color(0xFFDCB03B),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 2, vertical: 2),
                                      child: isSignIn
                                          ? CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                      Colors.white),
                                            )
                                          : Text(
                                              'Sign-Up',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFF0C4546),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('       Already have an account?',
                                        style: GoogleFonts.sarabun(
                                            color: Color(0xFF0C4546),
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12)),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AdminLogin()));
                                      },
                                      child: Text(
                                        'Log-in now!',
                                        style: GoogleFonts.sarabun(
                                            color: Color(0xFF0C4546),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
