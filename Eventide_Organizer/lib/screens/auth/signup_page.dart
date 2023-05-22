// import 'package:eventide_app/components/custom_button.dart';
// import 'package:eventide_app/components/custom_text_poppins.dart';
// import 'package:eventide_app/components/custom_textfield.dart';
// import 'package:eventide_app/components/privact_text.dart';
// import 'package:eventide_app/components/social_button.dart';
// import 'package:eventide_app/providers/auth/signup_provider.dart';
// import 'package:eventide_app/utils/app_colors.dart';
// import 'package:eventide_app/utils/assets_constant.dart';
// import 'package:eventide_app/utils/util_functions.dart';
import 'package:eventide_organizer_app/components/custom_button.dart';
import 'package:eventide_organizer_app/components/custom_password_textfield.dart';
import 'package:eventide_organizer_app/components/custom_text_poppins.dart';
import 'package:eventide_organizer_app/components/custom_textfield.dart';
import 'package:eventide_organizer_app/components/privact_text.dart';
import 'package:eventide_organizer_app/providers/auth/signup_provider.dart';
import 'package:eventide_organizer_app/utils/app_colors.dart';
import 'package:eventide_organizer_app/utils/assets_constant.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../../utils/util_functions.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool checkedValue = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Consumer<SignupProvider>(builder: (context, value, child) {
        return Scaffold(
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            width: size.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          color: AppColors.primaryAshOne,
                          borderRadius: BorderRadius.circular(80),
                          image: const DecorationImage(
                              image: AssetImage(
                                  "${AssetConstant.imagePath}register.png"))),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Center(
                    child: CustomText(
                      "Register from Here",
                      fontSize: 25,
                      color: Color.fromARGB(255, 116, 116, 116),
                    ),
                  ),

                  const SizedBox(height: 20),
                  CustomTextfield(
                    controller:
                        Provider.of<SignupProvider>(context, listen: false)
                            .nameController,
                    hintText: "Enter your Organization Name",
                  ),
                  const SizedBox(height: 15),
                  CustomTextfield(
                    controller:
                        Provider.of<SignupProvider>(context, listen: false)
                            .emailController,
                    hintText: "Enter Organization Email",
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 15),
                  CustomTextfield(
                    hintText: "Address ",
                    controller:
                        Provider.of<SignupProvider>(context, listen: false)
                            .addressController,
                  ),
                  const SizedBox(height: 15),

                  CustomTextfieldPass(
                      hintText: "Enter your password ",
                      controller:
                          Provider.of<SignupProvider>(context, listen: false)
                              .passwordController,
                      isObsecure: true,
                      iconOne: Icons.visibility_off,
                      iconTwo: Icons.visibility),
                  const SizedBox(height: 15),
                  CustomTextfield(
                    hintText: "Description ",
                    controller:
                        Provider.of<SignupProvider>(context, listen: false)
                            .descriptionController,
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: size.width * 0.5,
                    child: CustomTextfield(
                      prefixText: 'Rs. ',
                      hintText: "Price for hour ",
                      sufixText: '. 00',
                      keyboardType: TextInputType.phone,
                      controller:
                          Provider.of<SignupProvider>(context, listen: false)
                              .priceController,
                    ),
                  ),
                  const SizedBox(height: 15),
                  CustomTextfield(
                    hintText: "Web Link ",
                    controller:
                        Provider.of<SignupProvider>(context, listen: false).web,
                  ),
                  const SizedBox(height: 15),
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
                    onChanged: (value) {
                      Provider.of<SignupProvider>(context, listen: false)
                          .setInitCode = value.completeNumber;
                    },
                  ),
                  const SizedBox(height: 10),
                  //--------------------------------checkboxes
                  Row(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: value.wedding,
                            activeColor: AppColors.primaryColor,
                            onChanged: (cValue) {
                              value.setWedding = cValue!;
                            },
                          ),
                          const CustomText(
                            "Wedding",
                            fontSize: 16,
                            color: AppColors.black,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: value.bday,
                            activeColor: AppColors.primaryColor,
                            onChanged: (cValue) {
                              value.setBday = cValue!;
                            },
                          ),
                          const CustomText(
                            "Birthday",
                            fontSize: 16,
                            color: AppColors.black,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: value.engage,
                            activeColor: AppColors.primaryColor,
                            onChanged: (cValue) {
                              value.setEngage = cValue!;
                            },
                          ),
                          const CustomText(
                            "Engagement",
                            fontSize: 16,
                            color: AppColors.black,
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: value.aniversary,
                            activeColor: AppColors.primaryColor,
                            onChanged: (cValue) {
                              value.setAniversary = cValue!;
                            },
                          ),
                          const CustomText(
                            "Aniversary",
                            fontSize: 16,
                            color: AppColors.black,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: value.office,
                            activeColor: AppColors.primaryColor,
                            onChanged: (cValue) {
                              value.setOffice = cValue!;
                            },
                          ),
                          const CustomText(
                            "Office",
                            fontSize: 16,
                            color: AppColors.black,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: value.exhibition,
                            activeColor: AppColors.primaryColor,
                            onChanged: (cValue) {
                              value.setExhibition = cValue!;
                            },
                          ),
                          const CustomText(
                            "Exhibition",
                            fontSize: 16,
                            color: AppColors.black,
                          )
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                  Center(
                    child: CustomButton(
                      "Register",
                      isLoading: value.isLoading,
                      onTap: () {
                        value.startSignupOrganizer(context);
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  orTextRow(),
                  const SizedBox(height: 20),
                  const PrivactText()
                ],
              ),
            ),
          ),
        );
      }),
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
