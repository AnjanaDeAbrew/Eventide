import 'package:eventide_app/components/custom_text_poppins.dart';
import 'package:eventide_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(this.text,
      {Key? key,
      required this.onTap,
      this.isLoading = false,
      this.width = 319,
      this.height = 48,
      this.color = AppColors.primaryColor})
      : super(key: key);

  final Function() onTap;
  final String text;
  final bool isLoading;
  final double width;
  final double height;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          alignment: Alignment.center,
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(10)),
          child: isLoading
              ? const CircularProgressIndicator.adaptive()
              : CustomText(
                  text,
                  fontSize: 16,
                  color: AppColors.white,
                  fontWeight: FontWeight.normal,
                )),
    );
  }
}
