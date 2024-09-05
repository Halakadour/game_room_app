import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:games_manager/core/functions/final_cost_calculation.dart';
import 'package:games_manager/core/functions/generate_unique.dart';
import 'package:games_manager/features/home/domain/entities/booking_entity.dart';
import 'package:games_manager/features/home/domain/entities/device_entity.dart';
import 'package:games_manager/features/home/presentation/bloc/home_bloc.dart';
import 'package:games_manager/features/home/presentation/widgets/add_reservation_dialog.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../core/functions/show_device_booking_details.dart';

class DeviceCard extends StatefulWidget {
  const DeviceCard({super.key, required this.device});
  final DeviceEntity device;

  @override
  State<DeviceCard> createState() => _DeviceCardState();
}

Future displayBottomSheet(
    BuildContext context, BookingEntity booking, num costPerHour) {
  return showDeviceBookingDetails(context, booking, costPerHour);
}

class _DeviceCardState extends State<DeviceCard> {
  TextEditingController customerNameController = TextEditingController();
  BookingEntity? bookingEntity;

  @override
  void didChangeDependencies() {
    context
        .read<HomeBloc>()
        .add(GetBookingByDeviceIdEvent(deviceId: widget.device.id));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>  previous.bookingItemStatus != current.bookingItemStatus,
      builder: (context, state) {
        return Card(
          color: Colors.white,
          elevation: 3,
          child: Slidable(
            startActionPane:
                ActionPane(motion: const ScrollMotion(), children: [
              SlidableAction(
                onPressed: (context) {
                  bookingEntity = state.bookingItem;
                  if (bookingEntity == null) {
                    context
                        .read<HomeBloc>()
                        .add(DeleteDeviceEvent(id: widget.device.id));
                    context.read<HomeBloc>().add(GetDevicesListEvent());
                  } else {
                    displayBottomSheet(
                        context, bookingEntity!, widget.device.costPerHoure);
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
                    const BorderRadius.horizontal(left: Radius.circular(12)),
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
