import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../styles/custom_text_style.dart';
import 'auth/sign_in.dart';
import 'auth/sign_up.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset("assets/images/splash_bg.svg",
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Column(
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset("assets/images/A2.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("Parcel Dashboard",
                    style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: TextButton.styleFrom(backgroundColor: const Color(0xFF6CD8D1),
                        ),
                        onPressed: (){
                          Get.to(() => const SignUp());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text("Register",style: CustomTextStyle.boldMediumTextStyle(color: Colors.white),),
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: TextButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                                side: BorderSide(color: Color(0xFF6CD8D1))
                            )
                        ),
                        onPressed: (){
                          Get.to(() => const Login());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text("Log In",style: CustomTextStyle.boldMediumTextStyle(color: Colors.white),),
                        )
                    ),
                  ),
                ),
                const SizedBox(height: 20,),

              ],
            ),
          )
        ],
      ),
    );
  }
}
