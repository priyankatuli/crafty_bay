import 'package:crafty_bay/controller_binder.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/shimmer_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'presentation/ui/screens/splash_screen.dart';
import 'presentation/ui/utils/app_colors.dart';

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home:  SplashScreen(),
        initialBinding: ControllerBinder(),
        theme: ThemeData(
            textTheme: const TextTheme(
                headlineLarge: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600
                )
            ),
            colorSchemeSeed: AppColors.themeColor,
            scaffoldBackgroundColor: Colors.white,
            progressIndicatorTheme: const ProgressIndicatorThemeData(
                color: AppColors.themeColor
            ),
            inputDecorationTheme: InputDecorationTheme(
                border: _outlineInputBorder(),
                enabledBorder: _outlineInputBorder(),
                focusedBorder: _outlineInputBorder(),
                errorBorder: _outlineInputBorder(Colors.red),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w400
                )
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.themeColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(
                      fontSize: 14
                  ),
                  fixedSize: const Size.fromWidth(double.maxFinite),
                )
            ),
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    foregroundColor: AppColors.themeColor,
                    textStyle: TextStyle(
                        fontSize: 16
                    )
                )
            ),
            appBarTheme: AppBarTheme(
                color: Colors.white,
                titleTextStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                )
            )
        )
    );
  }

  OutlineInputBorder _outlineInputBorder([Color ? color]){
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(
            color: color ?? AppColors.themeColor,
            width: 1.4
        )
    );
  }


}