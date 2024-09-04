import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:games_manager/config/theme/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key, required this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: greenColor,
            padding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 20.sp),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        child: Center(
          child: Text(
            "حفظ",
            style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600),
          ),
        ));
  }
}
