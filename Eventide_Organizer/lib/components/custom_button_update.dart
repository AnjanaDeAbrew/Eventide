import 'package:eventide_organizer_app/components/custom_text_poppins.dart';
import 'package:eventide_organizer_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButtonUpdate extends StatelessWidget {
  const CustomButtonUpdate(this.text,
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
              : Row(
                  children: [
                    const SizedBox(width: 20),
                    const Icon(
                      Icons.restart_alt_outlined,
                      color: AppColors.white,
                    ),
                    const SizedBox(width: 20),
                    CustomText(
                      text,
                      fontSize: 16,
                      color: AppColors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                )),
    );
  }
}
