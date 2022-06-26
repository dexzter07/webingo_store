import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  final CollectionReference adminList =
      FirebaseFirestore.instance.collection('AdminInfo');

  Future<void> createUserData(
      String firstName,
      String lastName,
      String contactNumber,
      String emergencyNumber,
      String date,
      String time,
      String uid) async {
    return await adminList.doc(uid).set({
      'fName': firstName,
      'lName': lastName,
      'contact': contactNumber,
      'emergency': emergencyNumber,
      'date': date,
      'time': time,
    });
  }

  Future getUsersList() async {
    List itemsList = [];

    try {
      await FirebaseFirestore.instance
          .collection("orderList")
          .get()
          .then((value) {
        for (var i in value.docs) {
          itemsList.add(i.data());
          print(itemsList);
        }
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
