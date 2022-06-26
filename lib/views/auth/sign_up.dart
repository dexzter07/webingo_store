import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../constants/app_constants.dart';
import '../../controller/auth/register_account_controller.dart';
import '../../styles/app_colors.dart';
import '../../styles/custom_text_style.dart';
import 'otp.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _formKey = GlobalKey<FormState>();
  final RegisterAccountController _registerAccountController = Get.put(RegisterAccountController());
  // final AuthenticationServices _auth = AuthenticationServices();
  String? number;
  final String _prefix = '+91 ';
  bool _switchValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset("assets/images/Sign_Up_bg.svg",
            fit: BoxFit.cover,
            height: Get.height,

          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 22, vertical: AppConstants.screenVerticalPadding),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20,),
                      const Text("Let's Start with creating your account",
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700,color: Colors.black),),
                      const SizedBox(
                        height: 20,
                      ),
                      Text("First Name",
                          style: CustomTextStyle.boldMediumTextStyle(
                              color: Colors.grey.shade700)),
                      const SizedBox(
                        height: 7,
                      ),

                      TextFormField(
                          controller: _registerAccountController.firstName,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          validator: RequiredValidator(errorText: "First Name is required"),
                          maxLines: 1,),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("Last Name",
                          style: CustomTextStyle.boldMediumTextStyle(
                              color: Colors.grey.shade700)),
                      const SizedBox(
                        height: 7,
                      ),
                      TextFormField(
                        controller: _registerAccountController.lastName,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        validator: RequiredValidator(errorText: "Last Name is required"),
                        maxLines: 1,),
                      const SizedBox(
                        height: 10,
                      ),

                      Text("Contact Number (for OTP)",
                          style: CustomTextStyle.boldMediumTextStyle(
                              color: Colors.grey.shade700)),
                      const SizedBox(
                        height: 7,
                      ),
                      TextFormField(
                          controller: _registerAccountController.contactNumber,
                          keyboardType: TextInputType.phone,
                          textCapitalization: TextCapitalization.sentences,
                          validator: phoneValidation,
                          maxLines: 1),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("Emergency Contact Number",
                          style: CustomTextStyle.boldMediumTextStyle(
                              color: Colors.grey.shade700),
                          ),
                      const SizedBox(
                        height: 7,
                      ),
                      TextFormField(
                        controller: _registerAccountController.emergencyNumber,
                        keyboardType: TextInputType.phone,
                        textCapitalization: TextCapitalization.sentences,
                          validator: phoneValidation,
                          maxLines: 1,
                          ),
                      const SizedBox(
                        height: 10,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Column(
                                children: const [
                                  Text(
                                    "By signing up, you agree to our Terms & Conditions and Privacy Policy",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey),
                                  ),
                                ],
                              )),
                          Checkbox(
                            activeColor: AppColors.primaryColor,
                            value: _switchValue,
                            onChanged: (value) {
                              setState(() {
                                _switchValue = value!;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.1,
                      ),
                      _switchValue == true?
                      MaterialButton(
                        minWidth: double.infinity,
                          child: Text("Continue", style: CustomTextStyle.mediumTextStyle(color: Colors.white),),
                          color: AppColors.primaryButtonColor,
                          onPressed: () {
                            if(_formKey.currentState!.validate()){
                              Get.to(() => VerifyOTP());
                            }
                          }):
                      Container(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
