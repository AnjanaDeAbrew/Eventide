import 'package:eventide_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextfieldPass extends StatefulWidget {
  const CustomTextfieldPass({
    required this.controller,
    this.isObsecure = false,
    this.keyboardType,
    this.iconOne,
    this.iconTwo,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool isObsecure;
  final IconData? iconOne;
  final IconData? iconTwo;

  @override
  State<CustomTextfieldPass> createState() => _CustomTextfieldPassState();
}

class _CustomTextfieldPassState extends State<CustomTextfieldPass> {
  bool _pwVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: !_pwVisible,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _pwVisible = !_pwVisible;
              });
            },
            icon: _pwVisible ? Icon(widget.iconOne) : Icon(widget.iconTwo)),
        filled: true,
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
