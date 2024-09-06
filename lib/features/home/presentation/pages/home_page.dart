import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:games_manager/config/theme/app_colors.dart';
import 'package:games_manager/core/widgets/custom_float_action_button.dart';
import 'package:games_manager/features/home/domain/entities/device_entity.dart';
import 'package:games_manager/features/home/presentation/pages/setting_page.dart';
import 'package:games_manager/features/home/presentation/widgets/device_card.dart';
import 'package:games_manager/lang/locale_keys.g.dart';

import '../bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    context.read<HomeBloc>().add(GetDevicesListEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const CustomFloatActionButton(),
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              textAlign: TextAlign.center,
              LocaleKeys.thedevices.tr(),
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: backgroundColor,
        child: Column(
          children: [
            DrawerHeader(
                child: Center(
              child: Icon(
                Icons.gamepad_rounded,
                color: grayColor,
                size: 40.sp,
              ),
            )),
            Padding(
              padding: EdgeInsets.only(right: 10.sp, left: 10.sp),
              child: ListTile(
                  title: Text(
                    "H O M E",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp),
                  ),
                  leading: const Icon(
                    Icons.home_rounded,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ));
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.sp, left: 10.sp),
              child: ListTile(
                  title: Text(
                    "S E T T I N G",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp),
                  ),
                  leading: const Icon(
                    Icons.settings,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingPage(),
                        ));
                  }),
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 30.sp, right: 15.sp, left: 15.sp),
        child: Column(
          children: [
            20.verticalSpace,
            Expanded(
                child: BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (previous, current) =>
                  (previous.toggleDeviceIdelStatus !=
                          current.toggleDeviceIdelStatus ||
                      previous.deviceListStatus != current.deviceListStatus ||
                      previous.bookingItemStatus != current.bookingItemStatus),
              builder: (context, state) {
                return ListView.builder(
                    itemCount: state.deviceList.length,
                    itemBuilder: (context, index) => DeviceCard(
                        device: DeviceEntity(
                            id: state.deviceList[index].id,
                            name: state.deviceList[index].name,
                            type: state.deviceList[index].type,
                            costPerHoure: state.deviceList[index].costPerHoure,
                            idle: state.deviceList[index].idle)));
              },
            ))
          ],
        ),
      ),
    );
  }
}
