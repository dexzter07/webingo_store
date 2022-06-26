import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:webingo_dash/views/dashboard/order_list.dart';
import 'package:webingo_dash/views/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: FirebaseAuth.instance.currentUser == null
        ? const HomePage()
        : const OrderList(),
  ));
}


