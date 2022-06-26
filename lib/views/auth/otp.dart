import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webingo_dash/views/auth/registration_success.dart';
import '../../controller/auth/register_account_controller.dart';
import '../../database_manager/database_manager.dart';
import '../../styles/app_colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';



class VerifyOTP extends StatefulWidget {
  const VerifyOTP({Key? key}) : super(key: key);
  @override
  _VerifyOTPState createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  int start = 30;
  bool wait = true;
  String buttonName = "" ;
  String cdate = DateFormat("dd-MM-yyyy").format(DateTime.now());
  String tdata = DateFormat("hh:mm:ss a").format(DateTime.now());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RegisterAccountController _registerAccountController = Get.put(RegisterAccountController());
  late String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = const BoxDecoration(
    color: AppColors.primaryColor,

  );
  void startTimer(){
    const onSec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onSec, (timer){
      if(start == 0){
        if(mounted) {
          setState(() {
            timer.cancel();
            wait = false;
          });
        }
      }
      else {
        if(mounted) {
          setState(() {
            start --;
          });
        }
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Verify OTP'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              color: AppColors.primaryColor
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            const SizedBox(height: 10,),

            Container(
              margin: const EdgeInsets.only(top: 40),
              child: Center(
                child: Column(
                  children: [
                    const Text("Enter OTP"),
                    const SizedBox(height: 7,),
                    Text(
                      '+91-${_registerAccountController.contactNumber.text}',
                      style: const TextStyle(fontSize: 26),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Pinput(
                length: 6,
                focusNode: _pinPutFocusNode,
                controller: _pinPutController,
                pinAnimationType: PinAnimationType.fade,
                onCompleted: (pin) async {
                  try {
                    await FirebaseAuth.instance
                        .signInWithCredential(PhoneAuthProvider.credential(
                        verificationId: _verificationCode, smsCode: pin))
                        .then((value) async {
                      if (value.user != null) {
                        final User? user = FirebaseAuth.instance.currentUser;
                        final uid = user!.uid;
                        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString("uid", uid);
                        await DatabaseManager().createUserData(
                            _registerAccountController.firstName.text,
                            _registerAccountController.lastName.text,
                            _registerAccountController.contactNumber.text,
                            _registerAccountController.emergencyNumber.text,
                            cdate,
                            tdata,
                            uid);
                        Get.to(RegistrationSuccess());
                      }
                    });
                  } catch (e) {
                    FocusScope.of(context).unfocus();
                    _scaffoldKey.currentState!
                        .showSnackBar(const SnackBar(content: Text('invalid OTP')));
                  }
                },
              ),
            ),
            RichText(text: TextSpan(
                children: [
                  const TextSpan(text: "Send OTP again in  ", style: TextStyle(fontSize: 16, color: Colors.black)),
                  TextSpan(text: "00:$start", style: const TextStyle(fontSize: 16, color: Colors.deepOrangeAccent)),
                  const TextSpan(text: "  sec ", style: TextStyle(fontSize: 16, color: Colors.black)),

                ]
            )),
            Container(child: wait?null:
            MaterialButton(onPressed: wait? null: (){

              startTimer();
              if(mounted) {
                setState(() {
                  start = 30;
                  wait = true;
                  _verifyPhone();
                });
              }
            },
              color: Colors.transparent,
              child: const Text("Resend"),
            ))
          ],
        ),
      ),
    );
  }
  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${_registerAccountController.contactNumber.text}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              final User? user = FirebaseAuth.instance.currentUser;
              final uid = user!.uid;
              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
              sharedPreferences.setString("uid", uid);
              await DatabaseManager().createUserData(
                  _registerAccountController.firstName.text,
                  _registerAccountController.lastName.text,
                  _registerAccountController.contactNumber.text,
                  _registerAccountController.emergencyNumber.text,
                  "date",
                  "time",
                  uid);
              Get.to(RegistrationSuccess());

            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String? verificationID, int? resendToken) {
          if(mounted) {
            setState(() {
              _verificationCode = verificationID!;
            });
          }
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          if(mounted) {
            setState(() {
              _verificationCode = verificationID;
            });
          }
        },
        timeout: const Duration(seconds: 20));
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    _verifyPhone();

  }
}