import 'package:eventide_app/components/custom_button.dart';
import 'package:eventide_app/components/custom_password_textfield.dart';
import 'package:eventide_app/components/custom_text_poppins.dart';
import 'package:eventide_app/components/custom_textfield.dart';
import 'package:eventide_app/components/privact_text.dart';
import 'package:eventide_app/providers/auth/signup_provider.dart';
import 'package:eventide_app/utils/app_colors.dart';
import 'package:eventide_app/utils/assets_constant.dart';
import 'package:eventide_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
                size: 26,
              )),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IconButton(
                //     onPressed: () {
                //       UtilFunction.goBack(context);
                //     },
                //     icon: const Icon(Icons.arrow_back)),
                const SizedBox(height: 6),
                Center(
                    child: Image.asset(
                        '${AssetConstant.imagePath}signupImage.png')),
                const SizedBox(height: 16),
                const CustomText(
                  "Sign Up Here",
                  color: AppColors.black,
                ),
                const SizedBox(height: 16),
                const CustomText("Enter your Name",
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: AppColors.textLabelAsh),
                const SizedBox(height: 6),
                CustomTextfield(
                  controller:
                      Provider.of<SignupProvider>(context).nameController,
                ),
                const SizedBox(height: 6),
                const CustomText("Enter your Email",
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: AppColors.textLabelAsh),
                const SizedBox(height: 6),
                CustomTextfield(
                  controller:
                      Provider.of<SignupProvider>(context).emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 6),
                const CustomText("Enter your Password",
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: AppColors.textLabelAsh),
                const SizedBox(height: 6),
                CustomTextfieldPass(
                    controller:
                        Provider.of<SignupProvider>(context).passwordController,
                    isObsecure: true,
                    iconOne: Icons.visibility_off,
                    iconTwo: Icons.visibility),
                const SizedBox(height: 6),
                const CustomText("Enter your Mobile number",
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: AppColors.textLabelAsh),
                const SizedBox(height: 6),
                IntlPhoneField(
                  decoration: InputDecoration(
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
                  initialCountryCode: 'LK',
                  controller:
                      Provider.of<SignupProvider>(context).mobileController,
                ),
                const SizedBox(height: 12),
                Center(child: Consumer<SignupProvider>(
                  builder: (context, value, child) {
                    return CustomButton(isLoading: value.isLoading, "Register",
                        onTap: () {
                      value.startSignup(context);
                    });
                  },
                )),

                const SizedBox(height: 20),
                const PrivactText()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row orTextRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 65,
          height: 1,
          color: AppColors.primaryAshTwo,
        ),
        const SizedBox(width: 10),
        //-------widget for -or- text
        const CustomText("Or",
            fontSize: 12,
            color: AppColors.primaryAshThree,
            fontWeight: FontWeight.normal),
        const SizedBox(width: 10),
        Container(
          width: 65,
          height: 1,
          color: AppColors.primaryAshTwo,
        ),
      ],
    );
  }
}
