import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:games_manager/core/widgets/custom_text_field.dart';

import '../../config/theme/app_colors.dart';
import '../../features/home/domain/entities/device_entity.dart';
import '../../features/home/presentation/bloc/home_bloc.dart';
import '../../features/home/presentation/widgets/custom_elevated_button.dart';
import '../../lang/locale_keys.g.dart';
import 'generate_unique.dart';

Future<dynamic> addDeviceBottomSheet(
    BuildContext context,
    TextEditingController nameController,
    String dropdownvalue,
    void Function(String?)? onChanged,
    TextEditingController priceController) {
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
            label:LocaleKeys.deviceName.tr(),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 15.sp),
            child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                    label: const Text(LocaleKeys.deviceType).tr(),
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
                onChanged: onChanged),
          ),
          CustomTextFormField(
            controller: priceController,
            validator: (p0) {
              return null;
            },
            label:LocaleKeys.costPerHour.tr(),
          ),
          CustomElevatedButton(
            onPressed: () {
              context.read<HomeBloc>().add(AddDeviceEvent(
                  device: DeviceEntity(
                      id: IdManager.generateId(),
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
            name:LocaleKeys.save.tr(),
            buttonColor: greenColor,
            borderColor: Colors.transparent,
            fontColor: Colors.white,
          ),
        ]),
      ),
    ),
  );
}
