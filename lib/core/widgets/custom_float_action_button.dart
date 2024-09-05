import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:games_manager/config/theme/app_colors.dart';
import 'package:games_manager/core/functions/add_device_bottom_sheet.dart';

class CustomFloatActionButton extends StatefulWidget {
  const CustomFloatActionButton({super.key});

  @override
  State<CustomFloatActionButton> createState() =>
      _CustomFloatActionButtonState();
}

class _CustomFloatActionButtonState extends State<CustomFloatActionButton> {
  String dropdownvalue = "PC";
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  Future displayBottomSheet(BuildContext context) {
    return addDeviceBottomSheet(context, nameController, dropdownvalue,
        (String? newValue) {
      setState(() {
        dropdownvalue = newValue!;
      });
    }, priceController);
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        displayBottomSheet(context);
      },
      backgroundColor: greenColor,
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 24.sp,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    nameController.clear();
    priceController.clear();
  }
}
