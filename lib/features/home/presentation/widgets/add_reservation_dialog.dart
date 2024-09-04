import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:games_manager/core/services/notification_services.dart';
import 'package:games_manager/features/home/domain/entities/booking_entity.dart';
import 'package:games_manager/features/home/presentation/bloc/home_bloc.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../core/widgets/custom_text_field.dart';

class AddReservationDialog extends StatefulWidget {
  const AddReservationDialog(
      {super.key,
      required this.customerNameController,
      required this.deviceId,
      required this.costPerHour,
      required this.bookingId});
  final TextEditingController customerNameController;
  final String deviceId;
  final num costPerHour;
  final String bookingId;

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
              "أدخل اسم الزبون",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
            20.verticalSpace,
            CustomTextFormField(
                controller: widget.customerNameController,
                validator: (p0) {
                  return null;
                },
                label: "اسم الزبون"),
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ).then((value) {
                        setState(() {
                          endTime = value!;
                          if (endTime != null) {
                            context.read<HomeBloc>().add(AddBookingEvent(
                                booking: BookingEntity(
                                    id: widget.bookingId,
                                    deviceId: widget.deviceId,
                                    clientName:
                                        widget.customerNameController.text,
                                    startTime: TimeOfDay.now(),
                                    endTime: endTime!)));
                            context.read<HomeBloc>().add(GetDevicesListEvent());
                            NotificationService().scheduleNotification(
                                value, widget.costPerHour);
                          }
                          Navigator.pop(context);
                        });
                      });
                    },
                    child: Text(
                      "التالي",
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
                      "إلغاء",
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
