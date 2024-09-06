import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:games_manager/config/theme/app_colors.dart';

import '../../../../lang/locale_keys.g.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          textAlign: TextAlign.center,
          LocaleKeys.settings.tr(),
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade300),
        padding: EdgeInsets.all(15.sp),
        margin: EdgeInsets.all(25.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(LocaleKeys.lang).tr(),
            CupertinoSwitch(
              value: context.locale.languageCode == 'ar' ? true : false,
              onChanged: (value) {
                setState(() {
                  value = !value;
                  value
                      ? context.setLocale(const Locale('en'))
                      : context.setLocale(const Locale('ar'));
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
