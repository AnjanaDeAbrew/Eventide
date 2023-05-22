import 'package:eventide_app/components/custom_text_poppins.dart';
import 'package:eventide_app/screens/main/main_screen.dart';
import 'package:eventide_app/utils/app_colors.dart';
import 'package:eventide_app/utils/assets_constant.dart';
import 'package:eventide_app/utils/util_functions.dart';
import 'package:flutter/material.dart';

class Success extends StatefulWidget {
  const Success({super.key});

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const double mainBoxHeight = 500;
    const double bookingBox = 60;
    const top = mainBoxHeight - bookingBox;
    return SafeArea(
        child: Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 500,
              decoration: BoxDecoration(
                  color:
                      const Color.fromARGB(255, 255, 242, 242).withOpacity(.2),
                  borderRadius: const BorderRadiusDirectional.only(
                      topStart: Radius.circular(60),
                      bottomEnd: Radius.circular(60)),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 20,
                        color: Color.fromARGB(255, 250, 208, 208))
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        AssetConstant.success,
                        width: 290,
                      ),
                    ],
                  ),
                  const Center(
                    child: CustomText(
                      "Your Booking is \nSuccess!",
                      fontSize: 30,
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          Positioned(
            top: top + top / 2,
            child: Container(
              height: 60,
              width: 250,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: AppColors.red),
                borderRadius: const BorderRadiusDirectional.only(
                    topEnd: Radius.circular(20),
                    bottomStart: Radius.circular(20)),
              ),
              child: InkWell(
                onTap: () {
                  UtilFunction.navigateTo(context, const MainScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetConstant.smile,
                      width: 30,
                    ),
                    const SizedBox(width: 10),
                    const CustomText(
                      "see your booking",
                      fontSize: 20,
                      color: Color.fromARGB(255, 84, 84, 84),
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
