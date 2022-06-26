import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PlaceOrderController extends GetxController{
  var length = TextEditingController();
  var width = TextEditingController();
  var height = TextEditingController();
  var weight = TextEditingController();
  var vatStatus = "VAT Registered Business".obs;
  var vatNumber = TextEditingController();
  var reason = "Gift".obs;
  var hsCode = TextEditingController();
  var isLoading = false.obs;
}