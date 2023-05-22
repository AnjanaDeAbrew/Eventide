import 'package:eventide_app/components/custom_button.dart';
import 'package:eventide_app/components/custom_text_poppins.dart';
import 'package:eventide_app/components/custom_textfield.dart';
import 'package:eventide_app/components/privact_text.dart';
import 'package:eventide_app/providers/auth/login_provider.dart';
import 'package:eventide_app/utils/app_colors.dart';
import 'package:eventide_app/utils/assets_constant.dart';
import 'package:eventide_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForogotPassword extends StatefulWidget {
  const ForogotPassword({super.key});

  @override
  State<ForogotPassword> createState() => _ForogotPasswordState();
}

class _ForogotPasswordState extends State<ForogotPassword> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                UtilFunction.goBack(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.black,
                size: 28,
              )),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                Center(
                    child: Image.asset(
                        '${AssetConstant.imagePath}forgotImage.png')),
                const SizedBox(height: 52),
                const CustomText(
                  "Forgot Password",
                  color: AppColors.black,
                ),
                const SizedBox(height: 40),
                const CustomText(
                  "Please, enter your email address. You will receive\na link to create a new password via email.",
                  textAlign: TextAlign.justify,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                const SizedBox(height: 30),
                const CustomText("Enter your Email",
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: AppColors.textLabelAsh),
                const SizedBox(height: 6),
                CustomTextfield(
                  controller: Provider.of<LoginProvider>(context, listen: false)
                      .resetEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 55),
                Center(child: Consumer<LoginProvider>(
                  builder: (context, value, child) {
                    return CustomButton(
                        isLoading: value.isLoading,
                        "Send Rest Email", onTap: () {
                      value.startSendPasswordResetEmail(context);
                    });
                  },
                )),
                const SizedBox(height: 120),
                const PrivactText()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
