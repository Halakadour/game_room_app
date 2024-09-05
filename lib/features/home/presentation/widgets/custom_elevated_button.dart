import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      this.onPressed,
      required this.name,
      required this.buttonColor,
      required this.borderColor,
      required this.fontColor});
  final void Function()? onPressed;
  final String name;
  final Color buttonColor;
  final Color borderColor;
  final Color fontColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: buttonColor,
            padding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 20.sp),
            shape: RoundedRectangleBorder(
                side: BorderSide(color: borderColor, width: 1.sp),
                borderRadius: BorderRadius.circular(12))),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
                color: fontColor, fontSize: 12.sp, fontWeight: FontWeight.w600),
          ),
        ));
  }
}
