import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:games_manager/core/functions/final_cost_calculation.dart';
import 'package:games_manager/core/functions/generate_unique.dart';
import 'package:games_manager/core/widgets/custom_text_field.dart';
import 'package:games_manager/features/home/domain/entities/booking_entity.dart';
import 'package:games_manager/features/home/domain/entities/device_entity.dart';
import 'package:games_manager/features/home/presentation/bloc/home_bloc.dart';
import 'package:games_manager/features/home/presentation/widgets/add_reservation_dialog.dart';
import 'package:games_manager/features/home/presentation/widgets/close_reservation_dialog.dart';

import '../../../../config/theme/app_colors.dart';

class DeviceCard extends StatefulWidget {
  const DeviceCard({super.key, required this.device});
  final DeviceEntity device;

  @override
  State<DeviceCard> createState() => _DeviceCardState();
}

Future displayBottomSheet(BuildContext context, String name,
    TimeOfDay startTime, TimeOfDay endTime, num costPerHour) {
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
            "تفاصيل الجلسة",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
          ),
          25.verticalSpace,
          CustomTextFormField(
            initialValue: name,
            enabled: false,
            label: "اسم الزبون",
          ),
          CustomTextFormField(
            initialValue: endTime.format(context).toString(),
            enabled: false,
            label: "الوقت",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    num cost = FinalCostCalculation()
                        .calculateFinalCost(startTime, endTime, costPerHour);
                    showDialog(
                      context: context,
                      builder: (context) => CloseReservationDialog(cost: cost),
                    );
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
                      'إغلاق الجلسة',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  )),
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
                      'عودة',
                      style: TextStyle(
                          color: redColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ))
            ],
          )
        ]),
      ),
    ),
  );
}

class _DeviceCardState extends State<DeviceCard> {
  TextEditingController customerNameController = TextEditingController();
  BookingEntity? bookingEntity;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.bookingItemStatus != current.bookingItemStatus,
      builder: (context, state) {
        return Card(
          color: Colors.white,
          elevation: 3,
          child: Slidable(
            startActionPane:
                ActionPane(motion: const ScrollMotion(), children: [
              SlidableAction(
                onPressed: (context) {
                  if (widget.device.idle) {
                    context
                        .read<HomeBloc>()
                        .add(DeleteDeviceEvent(id: widget.device.id));
                    context.read<HomeBloc>().add(GetDevicesListEvent());
                  } else {
                    context.read<HomeBloc>().add(
                        GetBookingByDeviceIdEvent(deviceId: widget.device.id));
                    bookingEntity = state.bookingItem;
                    displayBottomSheet(
                        context,
                        bookingEntity!.clientName,
                        bookingEntity!.startTime,
                        bookingEntity!.endTime,
                        widget.device.costPerHoure);
                  }
                },
                icon: Icons.delete_outline,
                foregroundColor: redColor,
                backgroundColor: redColor.withOpacity(.4),
                borderRadius: BorderRadius.circular(12),
              )
            ]),
            endActionPane: ActionPane(motion: const ScrollMotion(), children: [
              SlidableAction(
                onPressed: (context) {},
                icon: Icons.edit_outlined,
                foregroundColor: orangeColor,
                backgroundColor: orangeColor.withOpacity(.3),
              ),
              SlidableAction(
                onPressed: (context) {
                  if (widget.device.idle) {
                    showDialog(
                        context: context,
                        builder: (context) => AddReservationDialog(
                            customerNameController: customerNameController,
                            deviceId: widget.device.id,
                            costPerHour: widget.device.costPerHoure,
                            bookingId: IdManager.generateId()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("الجهاز تم حجزه بالفعل")));
                  }
                },
                icon: Icons.add,
                foregroundColor: greenColor,
                backgroundColor: greenColor.withOpacity(.3),
                borderRadius:
                    BorderRadius.horizontal(left: Radius.circular(12)),
              ),
            ]),
            child: ListTile(
              leading: (widget.device.type == 0)
                  ? Icon(Icons.laptop, color: grayColor)
                  : (widget.device.type == 1)
                      ? Icon(Icons.card_giftcard_rounded, color: grayColor)
                      : Icon(Icons.gamepad_rounded, color: grayColor),
              title: Text(
                widget.device.name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                "${widget.device.costPerHoure} ل.س/س",
                style: TextStyle(color: grayColor),
              ),
              trailing: GestureDetector(
                onTap: () {
                  num cost = FinalCostCalculation().calculateFinalCost(
                      bookingEntity!.startTime,
                      bookingEntity!.endTime,
                      widget.device.costPerHoure);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("$cost")));
                },
                child: CircleAvatar(
                  backgroundColor: widget.device.idle ? greenColor : redColor,
                  maxRadius: 8,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
