import 'package:eventide_app/components/custom_text_poppins.dart';
import 'package:eventide_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class PrivactText extends StatelessWidget {
  const PrivactText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomText(
          "By continue to login, you accept our company's",
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppColors.primaryAshTwo,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Term & conditions",
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 14,
                color: AppColors.primaryAshThree,
              ),
            ),
            Text(
              " and",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: AppColors.primaryAshTwo,
              ),
            ),
            Text(
              " Privacy policies",
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 14,
                color: AppColors.primaryAshThree,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
