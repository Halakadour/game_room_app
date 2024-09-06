import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:games_manager/core/functions/final_cost_calculation.dart';
import 'package:games_manager/core/widgets/custom_text_field.dart';
import 'package:games_manager/features/home/domain/entities/booking_entity.dart';
import 'package:games_manager/features/home/presentation/bloc/home_bloc.dart';

import '../../config/theme/app_colors.dart';
import '../../features/home/presentation/widgets/close_reservation_dialog.dart';
import '../../lang/locale_keys.g.dart';

Future<dynamic> showDeviceBookingDetails(
    BuildContext context, BookingEntity booking, num costPerHour) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.only(
          top: 30.sp,
          right: 20.sp,
          left: 20.sp,
        ),
        height: .45.sh,
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
           LocaleKeys.sessionDetails,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
          ).tr(),
          25.verticalSpace,
          CustomTextFormField(
            initialValue: booking.clientName,
            enabled: false,
            label: LocaleKeys.customerName.tr(),
          ),
          CustomTextFormField(
            initialValue: booking.endTime.format(context).toString(),
            enabled: false,
            label: LocaleKeys.time.tr(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocListener<HomeBloc, HomeState>(
                listener: (context, state) {
                  if (state.bookingItemStatus == Status.deleted) {
                    context
                        .read<HomeBloc>()
                        .add(ToggleDeviceIdelEvent(deviceId: booking.deviceId));
                  }
                },
                listenWhen: (previous, current) =>
                    previous.bookingItemStatus != current.bookingItemStatus,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      num cost = calculateFinalCost(
                          booking.startTime, TimeOfDay.now(), costPerHour);
                      showDialog(
                        context: context,
                        builder: (context) =>
                            CloseReservationDialog(cost: cost),
                      );
                      context
                          .read<HomeBloc>()
                          .add(DeleteBookingEvent(id: booking.id));
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: greenColor,
                        padding: EdgeInsets.symmetric(
                            vertical: 15.sp, horizontal: 20.sp),
                        fixedSize: Size.fromWidth(.42.sw),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: Center(
                      child: Text(
                        LocaleKeys.closeSession,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600),
                      ).tr(),
                    )),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                          vertical: 15.sp, horizontal: 20.sp),
                      fixedSize: Size.fromWidth(.42.sw),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: redColor, width: 1.5.sp))),
                  child: Center(
                    child: Text(
                     LocaleKeys.back,
                      style: TextStyle(
                          color: redColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600),
                    ).tr(),
                  ))
            ],
          )
        ]),
      ),
    ),
  );
}
