import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:games_manager/config/theme/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.controller,
      this.validator,
      required this.label,
      this.enabled = true,
      this.initialValue});
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String label;
  final bool? enabled;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.sp),
      child: TextFormField(
        initialValue: initialValue,
        style: TextStyle(
            color: grayColor, fontSize: 12.sp, fontWeight: FontWeight.w600),
        enabled: enabled ?? true,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
            label: Text(label),
            labelStyle: TextStyle(
                color: greenColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                  width: 1.5.sp,
                ),
                borderRadius: BorderRadius.circular(12.r)),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.grey.shade400, width: 1.5.sp),
                borderRadius: BorderRadius.circular(12.r)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.grey.shade400, width: 1.5.sp),
                borderRadius: BorderRadius.circular(12.r))),
      ),
    );
  }
}
