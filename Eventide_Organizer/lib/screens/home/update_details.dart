import 'package:eventide_organizer_app/components/custom_button.dart';
import 'package:eventide_organizer_app/components/custom_text_poppins.dart';
import 'package:eventide_organizer_app/components/custom_textfield_update.dart';
import 'package:eventide_organizer_app/providers/auth/user_provider.dart';
import 'package:eventide_organizer_app/utils/app_colors.dart';
import 'package:eventide_organizer_app/utils/assets_constant.dart';
import 'package:eventide_organizer_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class UpdateDetails extends StatefulWidget {
  const UpdateDetails({super.key});

  @override
  State<UpdateDetails> createState() => _UpdateDetailsState();
}

class _UpdateDetailsState extends State<UpdateDetails> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Consumer<UserProvider>(builder: (context, value, child) {
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
                      "Update from Here",
                      fontSize: 25,
                      color: Color.fromARGB(255, 116, 116, 116),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextfieldUpdate(
                    iconData: Icons.description_outlined,
                    controller:
                        Provider.of<UserProvider>(context, listen: false)
                            .updateDescription,
                    hintText: value.organizerModel!.description,
                  ),
                  const SizedBox(height: 15),
                  CustomTextfieldUpdate(
                    iconData: Icons.location_on_outlined,
                    controller:
                        Provider.of<UserProvider>(context, listen: false)
                            .updateAddress,
                    hintText: value.organizerModel!.address,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: size.width * 0.5,
                    child: CustomTextfieldUpdate(
                      iconData: Icons.attach_money_outlined,
                      hintText: value.organizerModel!.price,
                      keyboardType: TextInputType.phone,
                      controller:
                          Provider.of<UserProvider>(context, listen: false)
                              .updatePrice,
                    ),
                  ),
                  const SizedBox(height: 15),
                  IntlPhoneField(
                    decoration: InputDecoration(
                      hintText: value.organizerModel!.mobile,
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
                    onChanged: (phone) {
                      value.setInitCode = phone.completeNumber;
                    },
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: CustomButton(
                      "Update",
                      isLoading: value.isLoading,
                      onTap: () {
                        value.startEditDetails(
                            value.organizerModel!.uid, context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
