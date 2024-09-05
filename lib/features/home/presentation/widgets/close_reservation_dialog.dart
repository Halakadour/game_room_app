import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:games_manager/config/theme/app_colors.dart';

class CloseReservationDialog extends StatelessWidget {
  const CloseReservationDialog({super.key, required this.cost});
  final num cost;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: .24.sh,
        padding: EdgeInsets.all(20.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "تم إغلاق الجلسة",
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
            ),
            20.verticalSpace,
            RichText(
                text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: "حساب الزبون : ",
                  style: TextStyle(
                      color: grayColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Cairo')),
              TextSpan(
                  text: "$cost ل.س",
                  style: TextStyle(
                      color: greenColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Cairo'))
            ])),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "إغلاق",
                      style: TextStyle(
                          color: grayColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
