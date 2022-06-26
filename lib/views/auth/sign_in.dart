import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../styles/app_colors.dart';
import '../../styles/custom_text_style.dart';
import 'login_otp.dart';
import 'otp.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String? number;
  final String _prefix = '+91 ';

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
            padding: const EdgeInsets.all(8.0),
            child: ListView(

              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                const Text("Sign In", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900)),
                const SizedBox(height: 34,),
                Text("Please Provide your Phone Number", style: CustomTextStyle.boldMediumTextStyle(color: Colors.grey)),
                Text("to Continue", style: CustomTextStyle.boldMediumTextStyle(color: Colors.grey)),
                const SizedBox(height: 40,),
                Form(
                  key: _formKey,
                  child: Material(
                    elevation: 5,
                    shadowColor: Colors.grey,
                    borderRadius: BorderRadius.circular(33),
                    child: TextFormField(
                      validator: (value){
                        if (value!.isEmpty){
                          return 'Please enter the number';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      onChanged: (val) {
                        number = val;
                      },
                      style: const TextStyle(
                        height: 1,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(33.0)),
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(33.0)),
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        prefixIcon: const Icon(Icons.phone, color: Colors.black),
                        prefixText: _prefix,
                        hintText: "Enter your number",
                        hintStyle: const TextStyle(
                          color: Colors.black54,
                          fontFamily:'Poppins',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40,),
                InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("Send OTP  ", style: TextStyle(fontSize: 15, fontFamily: 'ShipporiMinchoB1', fontWeight: FontWeight.bold),),
                        Container(

                            child: const Padding(
                              padding: EdgeInsets.all(7.0),
                              child: Icon(Icons.arrow_forward_ios_rounded,color:Colors.white,),
                            ),
                            decoration: BoxDecoration(
                                color:  AppColors.primaryButtonColor,
                                borderRadius: BorderRadius.circular(50)

                            )

                        )

                      ],
                    ),
                    onTap: ()async{


                      // final String num=number;
                      // final String user =await getData(num);
                      //
                      // setState(() {
                      //   dataa=user;
                      // });

                      if(_formKey.currentState!.validate()){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => Otp(phone:number)));
                      }
                    }
                ),



              ],
            ),
          ),
        ],
      ),
    );
  }
}