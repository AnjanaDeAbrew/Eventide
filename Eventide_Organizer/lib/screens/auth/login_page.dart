// import 'package:eventide_app/components/custom_button.dart';
// import 'package:eventide_app/components/custom_text_poppins.dart';
// import 'package:eventide_app/components/custom_textfield.dart';
// import 'package:eventide_app/components/privact_text.dart';
// import 'package:eventide_app/components/social_button.dart';
// import 'package:eventide_app/providers/auth/login_provider.dart';
// import 'package:eventide_app/screens/auth/forgotpassword_page.dart';
// import 'package:eventide_app/screens/auth/signup_page.dart';
// import 'package:eventide_app/utils/app_colors.dart';
// import 'package:eventide_app/utils/assets_constant.dart';
// import 'package:eventide_app/utils/util_functions.dart';
import 'package:animate_do/animate_do.dart';
import 'package:eventide_organizer_app/components/custom_button.dart';
import 'package:eventide_organizer_app/components/custom_password_textfield.dart';
import 'package:eventide_organizer_app/components/custom_text_poppins.dart';
import 'package:eventide_organizer_app/components/custom_textfield.dart';
import 'package:eventide_organizer_app/components/privact_text.dart';
import 'package:eventide_organizer_app/providers/auth/login_provider.dart';
import 'package:eventide_organizer_app/screens/auth/forgotpassword_page.dart';
import 'package:eventide_organizer_app/screens/auth/signup_page.dart';
import 'package:eventide_organizer_app/utils/app_colors.dart';
import 'package:eventide_organizer_app/utils/assets_constant.dart';
import 'package:eventide_organizer_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(child: Consumer<LoginProvider>(
      builder: (context, value, child) {
        return Scaffold(
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            width: size.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            CustomText(
                              "Welcome,",
                              color: AppColors.black,
                            ),
                            SizedBox(height: 30),
                            CustomText(
                              "Login to\na joyful\nlife",
                              fontSize: 28,
                              color: AppColors.black,
                              textAlign: TextAlign.justify,
                            )
                          ]),
                      Image.asset(
                        "${AssetConstant.imagePath}login.png",
                        width: 200,
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                  CustomTextfield(
                    controller:
                        Provider.of<LoginProvider>(context).emailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Enter your email',
                  ),
                  const SizedBox(height: 25),
                  CustomTextfieldPass(
                    controller:
                        Provider.of<LoginProvider>(context).passwordController,
                    hintText: 'Enter your password',
                    isObsecure: true,
                    keyboardType: TextInputType.emailAddress,
                    iconOne: Icons.visibility_off,
                    iconTwo: Icons.visibility,
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        UtilFunction.navigateTo(
                            context,
                            FadeInRight(
                                duration: const Duration(milliseconds: 300),
                                child: const ForogotPassword()));
                      },
                      child: const CustomText("Forgot your password ?",
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Center(child: Consumer<LoginProvider>(
                  //   builder: (context, value, child) {
                  //     return

                  Center(
                    child: CustomButton("Login", onTap: () {
                      value.startSignIn(context);
                    }),
                  ),

                  const SizedBox(height: 30),
                  orTextRow(),

                  const SizedBox(height: 30),
                  Center(
                    child: InkWell(
                      onTap: () {
                        UtilFunction.navigateTo(context, const SignupPage());
                      },
                      child: const CustomText("Don't have an account?",
                          fontSize: 15,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const PrivactText()
                ],
              ),
            ),
          ),
        );
      },
    ));
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
