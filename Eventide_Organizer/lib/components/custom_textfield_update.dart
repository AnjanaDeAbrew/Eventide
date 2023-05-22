import 'package:eventide_organizer_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextfieldUpdate extends StatelessWidget {
  const CustomTextfieldUpdate({
    required this.controller,
    required this.hintText,
    this.isObsecure = false,
    this.keyboardType,
    this.prefixText,
    this.sufixText,
    this.iconData,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final bool isObsecure;
  final String? prefixText;
  final String? sufixText;
  final IconData? iconData;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObsecure,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        prefixText: prefixText,
        suffixText: sufixText,
        prefixIcon: Icon(iconData),
        prefixIconColor: AppColors.primaryAshThree,
        fillColor: AppColors.primaryAshOne,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.white),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.red)),
      ),
    );
  }
}
