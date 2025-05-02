import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pathly/views/forget_pass_view.dart';
import 'package:pathly/views/set_pass_view.dart';
import 'package:pathly/views/splash_screen.dart';
import 'package:pathly/views/verification_code_view.dart';

class Pathly extends StatelessWidget {
  const Pathly({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 851),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          home: SplashView(),
        );
      },
    );
  }
}
