import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:games_manager/core/widgets/custom_text_field.dart';

import '../../config/theme/app_colors.dart';
import '../../features/home/domain/entities/device_entity.dart';
import '../../features/home/presentation/bloc/home_bloc.dart';

Future<dynamic> updateDeviceBottomSheet(
  BuildContext context,
  DeviceEntity device,
  String dropdownvalue,
  void Function(String?)? onChanged,
) {
  TextEditingController nameController =
      TextEditingController(text: device.name);
  TextEditingController priceController =
      TextEditingController(text: device.costPerHoure.toString());
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
          CustomTextFormField(
            controller: nameController,
            validator: (p0) {
              return null;
            },
            label: "اسم الجهاز",
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 15.sp),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  label: const Text("نوع الجهاز"),
                  labelStyle: TextStyle(
                      color: greenColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey.shade400, width: 1.5.sp),
                      borderRadius: BorderRadius.circular(12.r)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey.shade400, width: 1.5.sp),
                      borderRadius: BorderRadius.circular(12.r))),
              icon: const Icon(Icons.keyboard_arrow_down),
              value: dropdownvalue,
              items: ["PC", "XBOX", "PLAYSTATION"]
                  .map<DropdownMenuItem<String>>(
                    (String item) => DropdownMenuItem<String>(
                        value: item, child: Text(item)),
                  )
                  .toList(),
              onChanged: onChanged,
              borderRadius: BorderRadius.circular(12),
              focusColor: Colors.white,
              dropdownColor: Colors.white,
            ),
          ),
          CustomTextFormField(
            controller: priceController,
            validator: (p0) {
              return null;
            },
            label: "سعر الساعة",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: () {
                    context.read<HomeBloc>().add(UpdateDeviceEvent(
                        id: device.id,
                        device: DeviceEntity(
                            id: device.id,
                            name: nameController.text,
                            type: dropdownvalue == "PC"
                                ? 0
                                : dropdownvalue == "XBOX"
                                    ? 1
                                    : 2,
                            costPerHoure: num.parse(priceController.text))));
                    context.read<HomeBloc>().add(GetDevicesListEvent());
                    Navigator.pop(context);
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
                      'تعديل',
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
