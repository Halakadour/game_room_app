import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:games_manager/core/functions/calculate_time_difference.dart';
import 'package:games_manager/core/functions/final_cost_calculation.dart';
import 'package:games_manager/core/functions/generate_unique.dart';
import 'package:games_manager/core/functions/update_device_bottom_sheet.dart';
import 'package:games_manager/features/home/domain/entities/booking_entity.dart';
import 'package:games_manager/features/home/domain/entities/device_entity.dart';
import 'package:games_manager/features/home/presentation/bloc/home_bloc.dart';
import 'package:games_manager/features/home/presentation/widgets/add_reservation_dialog.dart';
import 'package:games_manager/features/home/presentation/widgets/close_reservation_dialog.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../core/functions/show_device_booking_details.dart';
import '../../../../lang/locale_keys.g.dart';

class DeviceCard extends StatefulWidget {
  const DeviceCard({super.key, required this.device});
  final DeviceEntity device;

  @override
  State<DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
  TextEditingController customerNameController = TextEditingController();
  BookingEntity? bookingEntity;
  String dropdownvalue = "PC";
  Future displayBookingDetailsBottomSheet(
      BuildContext context, BookingEntity booking, num costPerHour) {
    return showDeviceBookingDetails(context, booking, costPerHour);
  }

  Future displayUpdateDeviceBottomSheet(BuildContext context) {
    return updateDeviceBottomSheet(context, widget.device, dropdownvalue,
        (String? newValue) {
      setState(() {
        dropdownvalue = newValue!;
      });
    });
  }

  @override
  void didChangeDependencies() {
    dropdownvalue = widget.device.type == 0
        ? "PC"
        : widget.device.type == 1
            ? "XBOX"
            : "PLAYSTATION";
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.bookingItemStatus != current.bookingItemStatus,
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (!widget.device.idle) {
              context
                  .read<HomeBloc>()
                  .add(GetBookingByDeviceIdEvent(deviceId: widget.device.id));
              print(state.bookingItemStatus);
              bookingEntity = state.bookingItem;
              (bookingEntity != null &&
                      (bookingEntity!.deviceId == widget.device.id))
                  ? showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: SizedBox(
                            height: .2.sh,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  LocaleKeys.theTimeRem.tr(),
                                  style: TextStyle(
                                      color: greenColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.sp),
                                ),
                                SlideCountdown(
                                  separatorStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.sp),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.sp),
                                  padding: EdgeInsets.all(20.sp),
                                  duration: calculateTimeDifference(
                                      TimeOfDay.now(), bookingEntity!.endTime),
                                  onDone: () {
                                    num cost = calculateFinalCost(
                                        bookingEntity!.startTime,
                                        bookingEntity!.endTime,
                                        widget.device.costPerHoure);
                                    context.read<HomeBloc>().add(
                                        DeleteBookingEvent(
                                            booking: bookingEntity!));
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          CloseReservationDialog(cost: cost),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      })
                  : SizedBox;
            }
          },
          child: Card(
            clipBehavior: Clip.hardEdge,
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
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              const Text(LocaleKeys.cannotBeDeleted).tr()));
                    }
                  },
                  icon: Icons.delete_outline,
                  foregroundColor: redColor,
                  backgroundColor: redColor.withOpacity(.4),
                  borderRadius: BorderRadius.circular(12),
                )
              ]),
              endActionPane:
                  ActionPane(motion: const ScrollMotion(), children: [
                SlidableAction(
                  onPressed: (context) {
                    if (widget.device.idle) {
                      displayUpdateDeviceBottomSheet(context);
                    } else {
                      context.read<HomeBloc>().add(GetBookingByDeviceIdEvent(
                          deviceId: widget.device.id));
                      print(state.bookingItemStatus);
                      bookingEntity = state.bookingItem;
                      if (bookingEntity != null &&
                          (bookingEntity!.deviceId == widget.device.id)) {
                        displayBookingDetailsBottomSheet(context,
                            bookingEntity!, widget.device.costPerHoure);
                      }
                    }
                  },
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
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text(LocaleKeys.deviceAlreadyReserved)
                              .tr()));
                    }
                  },
                  icon: Icons.add,
                  foregroundColor: greenColor,
                  backgroundColor: greenColor.withOpacity(.3),
                  borderRadius: context.locale.languageCode == 'ar'
                      ? const BorderRadius.horizontal(left: Radius.circular(12))
                      : const BorderRadius.horizontal(
                          right: Radius.circular(12)),
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
                  "${widget.device.costPerHoure} ${LocaleKeys.syphr.tr()}",
                  style: TextStyle(color: grayColor),
                ),
                trailing: CircleAvatar(
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
