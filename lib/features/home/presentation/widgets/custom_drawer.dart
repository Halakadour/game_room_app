import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/theme/app_colors.dart';
import '../pages/home_page.dart';
import '../pages/setting_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: backgroundColor,
      child: Column(
        children: [
          DrawerHeader(
              child: Center(
            child: Icon(
              Icons.gamepad_rounded,
              color: greenColor,
              size: 40.sp,
            ),
          )),
          Padding(
            padding: EdgeInsets.only(right: 10.sp, left: 10.sp),
            child: ListTile(
                title: Text(
                  "H O M E",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp),
                ),
                leading: const Icon(
                  Icons.home_rounded,
                  color: Colors.grey,
                ),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ));
                }),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.sp, left: 10.sp),
            child: ListTile(
                title: Text(
                  "S E T T I N G",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp),
                ),
                leading: const Icon(
                  Icons.settings,
                  color: Colors.grey,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingPage(),
                      ));
                }),
          )
        ],
      ),
    );
  }
}