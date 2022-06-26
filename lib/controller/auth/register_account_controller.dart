import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterAccountController extends GetxController{
  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var contactNumber = TextEditingController();
  var emergencyNumber = TextEditingController();
  var isLoading = false.obs;

}