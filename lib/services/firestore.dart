import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  //
  final CollectionReference admins =
      FirebaseFirestore.instance.collection('admins');
  //
  final CollectionReference contactUs =
      FirebaseFirestore.instance.collection('contactUs');
  //
  final CollectionReference orders =
      FirebaseFirestore.instance.collection('orders');
  var db = FirebaseFirestore.instance;

  //Interested/Register

  addUser(String name, String email, bool isAdmin) {
    users.doc().set({
      'name': name,
      'email': email,
      'isAdmin': isAdmin,
      'timestamp': Timestamp.now(),
    });
  }

  addAdmin(String name, String email, String phoneNum, bool isAdmin) {
    var user = FirebaseAuth.instance.currentUser;
    admins.doc(user!.uid).set({
      'id': user.uid,
      'name': name,
      'email': email,
      'phoneNum': phoneNum,
      'isAdmin': isAdmin,
      'timestamp': Timestamp.now(),
    });
  }

  addOrders(String name, String address, String payment, double amount,
      String status, String fileLink, bool paid) {
    orders.doc().set({
      'orderID': 0,
      'name': name,
      'location': address,
      'payment_method': payment,
      'amount': amount,
      'status': status,
      'fileLink': fileLink,
      'paid': paid,
      'date': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getUsersStream() {
    final usersStream =
        users.orderBy('timestamp', descending: true).snapshots();

    return usersStream;
  }

  Stream<QuerySnapshot> getContactUsStream() {
    final contactUsStream =
        contactUs.orderBy('timestamp', descending: true).snapshots();

    return contactUsStream;
  }

  Stream<QuerySnapshot> getOrdersStream() {
    final ordersStream = orders.orderBy('date', descending: true).snapshots();

    return ordersStream;
  }

  updateData(String id, bool paid) {
    String stat;
    paid ? stat = "Paid" : stat = "Pending";
    orders.doc(id).update({'paid': paid, 'status': stat}).onError(
        (e, _) => print("Error writing document: $e"));
  }

  updatePaid(
      String id, bool paid, bool paid2, bool paid3, bool paid4, bool paid5) {
    String stat;
    paid && paid2 && paid3 && paid4 && paid5
        ? stat = 'Fully Paid'
        : stat = 'Pending';
    orders.doc(id).update({
      'paid': paid,
      'paid2': paid2,
      'paid3': paid3,
      'paid4': paid4,
      'paid5': paid5,
      'status': stat
    }).onError((e, _) => print("Error writing document: $e"));
  }

  //update
  // Future<void> updateNote(String docID, bool didPurchase) {
  //   return users.doc(docID).update({'didPurchase': didPurchase});
  // }

  //Contact Us

  Future<void> addContactUs(String name, String email, String message) {
    return contactUs.add({
      'name': name,
      'email': email,
      'message': message,
      'timestamp': Timestamp.now(),
    });
  }

  // Stream<QuerySnapshot> getContactUsStream() {
  //   final contactUsStream =
  //       contactUs.orderBy('timestamp', descending: true).snapshots();

  //   return contactUsStream;
  // }

  Future<void> deleteMsg(String docID) {
    return contactUs.doc(docID).delete();
  }

  Future<void> deleteOrder(String docID) {
    return orders.doc(docID).delete();
  }

  loadAllDatas(List docData) {
    db
        .collection('contactUs')
        .orderBy('timestamp', descending: true)
        .get()
        .then((querySnapshot) {
      return {
        querySnapshot.docs.forEach((doc) {
          print('load all data ${doc.id} => ${doc.data()}');
          doc.data()['id'] = doc.id;
          docData.add(doc.data());
        })
      };
    });
  }

  getData(String docID) {
    db.collection('admins').doc(docID).get().then((querySnapshot) {
      return {print("docdoc id id ${querySnapshot.data()!.entries}")};
    });
  }
}

class FirebaseAuthService {
  FirestoreService firestoreService = FirestoreService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWEP(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      //ewan kow
      // print("current UUSER ${credential.user!.uid}");
      // print(
      //     'data of current ${firestoreService.getData(credential.user!.uid)}');
      return credential.user;
    } catch (e) {
      print("Error Singing $e");
    }
    return null;
  }

  Future<User?> signUpWEP(String email, String password, String name,
      String phoneNum, bool isAdmin) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await firestoreService.addAdmin(name, email, phoneNum, isAdmin);
      return credential.user;
    } catch (e) {
      print("Error Creating $e");
      return null;
    }
  }

  // checkAdmin(String userID) {
  //   firestoreService.getData(userID);
  // }
}
