import 'package:eventide_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AdminCustomTextfield extends StatelessWidget {
  const AdminCustomTextfield({
    required this.controller,
    required this.hintText,
    this.isObsecure = false,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final bool isObsecure;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObsecure,
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryAshTwo),
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
