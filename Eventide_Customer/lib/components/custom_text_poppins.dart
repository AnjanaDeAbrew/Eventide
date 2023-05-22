import 'package:eventide_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    this.fontSize = 40,
    this.fontWeight = FontWeight.w500,
    this.color = AppColors.white,
    this.textAlign = TextAlign.center,
    this.textOverflow,
    Key? key,
  }) : super(key: key);

  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;
  final TextOverflow? textOverflow;
  @override
  Widget build(BuildContext context) {
    return Text(
      textHeightBehavior: const TextHeightBehavior(
          applyHeightToFirstAscent: true,
          applyHeightToLastDescent: true,
          leadingDistribution: TextLeadingDistribution.even),
      text,
      textAlign: textAlign,
      overflow: textOverflow,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
