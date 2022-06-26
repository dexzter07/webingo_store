import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:webingo_dash/views/auth/sign_in.dart';
import '../../constants/app_constants.dart';
import '../../styles/app_colors.dart';
import '../../styles/custom_text_style.dart';


class RegistrationSuccess extends StatelessWidget {
  const RegistrationSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(10)
                ),
                padding:    const EdgeInsets.symmetric(horizontal: AppConstants.screenHorizontalPadding,vertical: AppConstants.screenVerticalPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Lottie.asset("assets/animation/success.json",repeat: false),

                    ),
                    Text("Registration Successful",style: CustomTextStyle.ultraBoldTextStyle1(color: AppColors.primaryColor, letterSpacing: 3),),
                    const SizedBox(height: 10,),
                    Text("Your Account has been successfully created!",style: CustomTextStyle.boldMediumTextStyle(color: Colors.grey)) ,
                    const SizedBox(height: 40,),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: MaterialButton(
                        onPressed: (){
                          Get.offAll(Login());
                        },
                        color: AppColors.primaryButtonColor,
                        minWidth: double.infinity,
                        child: Text("Login",style: CustomTextStyle.boldMediumTextStyle(color: Colors.white),),
                      ),
                    )


                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}