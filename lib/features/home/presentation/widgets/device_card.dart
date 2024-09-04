import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:games_manager/core/functions/generate_unique.dart';
import 'package:games_manager/core/widgets/custom_text_field.dart';
import 'package:games_manager/features/home/domain/entities/booking_entity.dart';
import 'package:games_manager/features/home/domain/entities/device_entity.dart';
import 'package:games_manager/features/home/presentation/bloc/home_bloc.dart';
import 'package:games_manager/features/home/presentation/widgets/add_reservation_dialog.dart';

import '../../../../config/theme/app_colors.dart';

class DeviceCard extends StatefulWidget {
  const DeviceCard({super.key, required this.device});
  final DeviceEntity device;

  @override
  State<DeviceCard> createState() => _DeviceCardState();
}

Future displayBottomSheet(BuildContext context, String name, String time) {
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "تفاصيل الجلسة",
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
          ),
          20.verticalSpace,
          CustomTextFormField(
            initialValue: name,
            enabled: false,
            label: "اسم الزبون",
          ),
          CustomTextFormField(
            initialValue: time,
            enabled: false,
            label: "الوقت",
          ),
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
      buildWhen: (previous, current) => previous.bookingItemStatus != current.bookingItemStatus,
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
                    displayBottomSheet(context, bookingEntity!.clientName,
                        bookingEntity!.endTime.format(context).toString());
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
                    const SnackBar(content: Text("الجهاز تم حجزه بالفعل"));
                  }
                },
                icon: Icons.edit_outlined,
                foregroundColor: orangeColor,
                backgroundColor: orangeColor.withOpacity(.3),
                borderRadius: BorderRadius.circular(12),
              )
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
              trailing: CircleAvatar(
                backgroundColor: widget.device.idle ? greenColor : redColor,
                maxRadius: 8,
              ),
            ),
          ),
        );
      },
    );
  }
}
