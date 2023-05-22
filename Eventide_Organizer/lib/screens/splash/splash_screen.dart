import 'package:animate_do/animate_do.dart';
// import 'package:eventide_app/providers/auth/user_provider.dart';
// import 'package:eventide_app/utils/assets_constant.dart';
import 'package:eventide_organizer_app/components/custom_text_poppins.dart';
import 'package:eventide_organizer_app/providers/auth/user_provider.dart';
import 'package:eventide_organizer_app/utils/app_colors.dart';
import 'package:eventide_organizer_app/utils/assets_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 3),
      () {
        Provider.of<UserProvider>(context, listen: false)
            .initializeUser(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ZoomIn(
              child: Image.asset(
                '${AssetConstant.imagePath}logo.png',
              ),
            ),
            const SizedBox(height: 20),
            FadeInUp(
                child: const CustomText(
              "Eventide Organizer",
              color: AppColors.primaryColor,
            )),
          ],
        ),
      ),
    );
  }
}
