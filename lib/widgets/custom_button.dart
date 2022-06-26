import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../styles/custom_text_style.dart';

class CustomButton extends StatelessWidget {

  final String title;
  final Color ? color;
  final VoidCallback onTap;
  final BorderRadius? borderRadius;
  final Border ? border;
  final EdgeInsets ? padding;
  final EdgeInsets ? margin;


  CustomButton({required this.title,required this.color,required this.onTap, this.borderRadius, this.border, this.padding, this.margin});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100,
        decoration: BoxDecoration(
            borderRadius: borderRadius,
            border:  border ,
            color: color?? AppColors.primaryColor
        ),
        padding: padding ?? const EdgeInsets.symmetric(vertical: 15),
        margin: margin ?? const EdgeInsets.symmetric(horizontal: 0,vertical: 10),
        child: Center(child: Text(title,style: CustomTextStyle.smallBoldTextStyle1(color:Colors.white),),),
      ),
    );
  }
}