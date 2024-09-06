// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ar = {
  "thedevices": "الأجهزة",
  "settings": "الإعدادات",
  "lang": "اللغة",
  "theTimeRem": "الوقت المتبقي",
  "cannotBeDeleted": "لا يمكن حذف الجهاز لأنه محجوز",
  "deviceAlreadyReserved": "الجهاز تم حجزه بالفعل",
  "syphr": "ل.س/س",
  "sessionDetails": "تفاصيل الجلسة",
  "enterCustomName": "أدخل اسم الزبون",
  "customerName": "اسم الزبون",
  "time": "الوقت",
  "closeSession": "إغلاق الجلسة",
  "back": "عودة",
  "deviceName": "اسم الجهاز",
  "deviceType": "نوع الجهاز",
  "costPerHour": "سعر الساعة",
  "save": "حفظ",
  "close": "إغلاق",
  "next": "التالي",
  "cancel": "إلغاء",
  "sessionClosed": "تم إغلاق الجلسة",
  "customerInvoice": "حساب الزبون : "
};
static const Map<String,dynamic> en = {
  "thedevices": "The devices",
  "settings": "The settings",
  "lang": "Language",
  "theTimeRem": "The time remaining",
  "cannotBeDeleted": "It cannot be deleted becouse it is reserved",
  "deviceAlreadyReserved": "The device has already been reserved",
  "syphr": "SYP/H",
  "sessionDetails": "Session Details",
  "enterCustomName": "Enter customer name",
  "customerName": "customer name",
  "time": "time",
  "closeSession": "close the session",
  "back": "back",
  "deviceName": "device name",
  "deviceType": "device Type",
  "costPerHour": "cost per hour",
  "save": "save",
  "close": "close",
  "next": "next",
  "cancel": "cancel",
  "sessionClosed": "The session closed",
  "customerInvoice": "The customer invoice : "
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": ar, "en": en};
}
