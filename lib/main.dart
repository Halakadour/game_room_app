import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:games_manager/config/theme/app_colors.dart';
import 'package:games_manager/features/home/domain/entities/booking_entity.dart';
import 'package:games_manager/features/home/domain/entities/device_entity.dart';
import 'package:games_manager/features/home/presentation/bloc/home_bloc.dart';
import 'package:games_manager/features/splash/pages/splash_page.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DeviceEntityAdapter());
  Hive.registerAdapter(BookingEntityAdapter());
  Hive.registerAdapter(TimeOfDayAdapter());
  await Hive.openBox<DeviceEntity>("devices");
  await Hive.openBox<BookingEntity>("bookings");
  runApp(EasyLocalization(
    path: 'assets/lang',
    supportedLocales: const [Locale('en'), Locale('ar')],
    fallbackLocale: const Locale('ar'),
    child: BlocProvider(
      create: (context) => HomeBloc(),
      child: const MainApp(),
    ),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: greenColor),
            scaffoldBackgroundColor: backgroundColor,
            fontFamily:
                context.locale.languageCode == 'ar' ? 'Cairo' : 'Outfit'),
        home: const SplashPage(),
      ),
    );
  }
}
