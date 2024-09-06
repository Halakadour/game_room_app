import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:games_manager/core/functions/generate_unique.dart';
import 'package:games_manager/core/services/notification_services.dart';
import 'package:games_manager/features/home/domain/entities/booking_entity.dart';
import 'package:games_manager/features/home/presentation/bloc/home_bloc.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../lang/locale_keys.g.dart';

class AddReservationDialog extends StatefulWidget {
  const AddReservationDialog({
    super.key,
    required this.customerNameController,
    required this.deviceId,
    required this.costPerHour,
  });
  final TextEditingController customerNameController;
  final String deviceId;
  final num costPerHour;

  @override
  State<AddReservationDialog> createState() => _AddReservationDialogState();
}

class _AddReservationDialogState extends State<AddReservationDialog> {
  TimeOfDay? endTime;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: .27.sh,
        padding: EdgeInsets.all(20.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.enterCustomName.tr(),
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
            20.verticalSpace,
            CustomTextFormField(
                controller: widget.customerNameController,
                validator: (p0) {
                  return null;
                },
                label: LocaleKeys.customerName.tr()),
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ).then((value) {
                        if (value != null) {
                          setState(() {
                            endTime = value;
                            print("device id ${widget.deviceId}");
                            print(
                                "client name ${widget.customerNameController.text}");
                            print("start date ${TimeOfDay.now()}");
                            print("end date $value");
                            context.read<HomeBloc>().add(AddBookingEvent(
                                  booking: BookingEntity(
                                    id: IdManager.generateId(),
                                    deviceId: widget.deviceId,
                                    clientName:
                                        widget.customerNameController.text,
                                    startTime: TimeOfDay.now(),
                                    endTime: endTime!,
                                  ),
                                ));
                            context.read<HomeBloc>().add(GetDevicesListEvent());
                            NotificationService().scheduleNotification(
                                TimeOfDay.now(), value, widget.costPerHour);
                          });
                          Navigator.pop(context);
                        }
                      });
                    },
                    child: Text(
                      LocaleKeys.next.tr(),
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: greenColor),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      LocaleKeys.cancel.tr(),
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: greenColor),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
