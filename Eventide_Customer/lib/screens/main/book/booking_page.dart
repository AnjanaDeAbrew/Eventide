import 'dart:ui';

import 'package:eventide_app/components/custom_button.dart';
import 'package:eventide_app/components/custom_text_poppins.dart';
import 'package:eventide_app/components/custom_textfield.dart';
import 'package:eventide_app/providers/auth/user_provider.dart';
import 'package:eventide_app/providers/home/booking_provider.dart';
import 'package:eventide_app/providers/organizer/organizer_provider.dart';
import 'package:eventide_app/utils/app_colors.dart';
import 'package:eventide_app/utils/assets_constant.dart';
import 'package:eventide_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final DateRangePickerController _dateController = DateRangePickerController();

  final String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  // Initial Selected Value
  String? dropdownvalue;
  // Initial Selected Value
  int radioValue = 0;

  List<Map> myJson = [
    {'id': '1', 'image': AssetConstant.morning, 'value': 'Morning'},
    {'id': '2', 'image': AssetConstant.day, 'value': 'Day'},
    {'id': '3', 'image': AssetConstant.evening, 'value': 'Evening'},
    {'id': '4', 'image': AssetConstant.night, 'value': 'Night'},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(body: SingleChildScrollView(
        child: Consumer<OrganizerProvider>(
          builder: (context, value, child) {
            return Column(
              children: [
                Container(
                  width: size.width,
                  height: 200,
                  decoration: BoxDecoration(
                      color: AppColors.black,
                      image: DecorationImage(
                          image: NetworkImage(value.organizerModel.img),
                          opacity: .8,
                          fit: BoxFit.cover)),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(width: 10),
                          //---------------arrow back box
                          InkWell(
                            onTap: () {
                              UtilFunction.goBack(context);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 40, sigmaY: 50),
                                  child: Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: const Color.fromARGB(
                                                255, 90, 107, 134)
                                            .withOpacity(0.5)),
                                    child: const Icon(
                                      Icons.arrow_back,
                                      color: AppColors.white,
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        width: size.width,
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        color: AppColors.white.withOpacity(.5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              value.organizerModel.name,
                              fontSize: 22,
                              textAlign: TextAlign.left,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20)
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const CustomText(
                  "Select the date",
                  fontSize: 25,
                  color: AppColors.black,
                ),
                SizedBox(
                  width: size.width,
                  height: size.height * 0.28,
                  child: SfDateRangePicker(
                    controller: _dateController,
                    enablePastDates: false,
                    backgroundColor: const Color.fromARGB(255, 248, 248, 248),
                    onSelectionChanged: _onSelectionChanged,
                    selectionColor: AppColors.primaryColor,
                    todayHighlightColor: AppColors.primaryColor,
                    headerStyle: const DateRangePickerHeaderStyle(
                        textStyle:
                            TextStyle(color: AppColors.white, fontSize: 18),
                        backgroundColor: AppColors.primaryColor),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.watch_later,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      const CustomText(
                        "The time",
                        color: AppColors.black,
                        fontSize: 20,
                      ),
                      const SizedBox(width: 30),
                      Expanded(child: Consumer<BookingProvider>(
                        builder: (context, bvalue, child) {
                          return DropdownButtonFormField(
                            // Initial Value
                            value: dropdownvalue,
                            elevation: 1,
                            borderRadius: BorderRadius.circular(10),
                            hint: const CustomText(
                              'At what time will you held?',
                              color: AppColors.primaryAshThree,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: myJson.map((items) {
                              return DropdownMenuItem(
                                value: items['value'].toString(),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      items['image'],
                                      width: 22,
                                      height: 22,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(items['value'])
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                bvalue.setTime = newValue!;
                              });
                            },
                          );
                        },
                      )),
                      const SizedBox(width: 10)
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: const [
                      Icon(Icons.star),
                      SizedBox(width: 4),
                      CustomText(
                        "What type  ?",
                        color: AppColors.black,
                        fontSize: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                radioButtons(),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.chair,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      const CustomText(
                        "How many participants ?",
                        color: AppColors.black,
                        fontSize: 20,
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 80,
                        child: CustomTextfield(
                            controller: Provider.of<BookingProvider>(context,
                                    listen: false)
                                .count,
                            keyboardType: TextInputType.phone),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Center(child: Consumer<UserProvider>(
                  builder: (context, valueUser, child) {
                    return CustomButton(
                      "Book Now",
                      color: AppColors.bottomColor,
                      height: 65,
                      width: 400,
                      onTap: () {
                        Provider.of<BookingProvider>(context, listen: false)
                            .startBooking(
                          context,
                          valueUser.userModel!.uid,
                          valueUser.userModel!.name,
                          valueUser.userModel!.email,
                          valueUser.userModel!.mobile,
                          value.organizerModel.uid,
                          value.organizerModel.name,
                          value.organizerModel.email,
                          value.organizerModel.mobile,
                        );
                        Provider.of<BookingProvider>(context, listen: false)
                            .startFetchBookings(context);
                      },
                    );
                  },
                )),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      )),
    );
  }

  Consumer radioButtons() {
    return Consumer<OrganizerProvider>(
      builder: (context, value, child) {
        return Consumer<BookingProvider>(
          builder: (context, bvalue, child) {
            return Column(
              children: [
                Row(
                  children: [
                    if (value.organizerModel.wedding == true)
                      Radio(
                        value: 1,
                        groupValue: bvalue.catValue,
                        activeColor: AppColors.red,
                        onChanged: (value) {
                          setState(() {
                            bvalue.setCat = 1;
                          });
                        },
                      ),
                    if (value.organizerModel.wedding == true)
                      const Text(
                        'Wedding',
                        style: TextStyle(
                            fontSize: 17.0, color: AppColors.primaryAshThree),
                      ),
                    if (value.organizerModel.bday == true)
                      Radio(
                        value: 2,
                        groupValue: bvalue.catValue,
                        activeColor: AppColors.red,
                        onChanged: (value) {
                          setState(() {
                            bvalue.setCat = 2;
                          });
                        },
                      ),
                    if (value.organizerModel.bday == true)
                      const Text(
                        'Birthday',
                        style: TextStyle(
                            fontSize: 17.0, color: AppColors.primaryAshThree),
                      ),
                    if (value.organizerModel.engage == true)
                      Radio(
                        value: 3,
                        groupValue: bvalue.catValue,
                        activeColor: AppColors.red,
                        onChanged: (value) {
                          setState(() {
                            bvalue.setCat = 3;
                          });
                        },
                      ),
                    if (value.organizerModel.engage == true)
                      const Text(
                        'Engagement',
                        style: TextStyle(
                            fontSize: 17.0, color: AppColors.primaryAshThree),
                      ),
                  ],
                ),
                Row(
                  children: [
                    if (value.organizerModel.aniversary == true)
                      Radio(
                        value: 4,
                        groupValue: bvalue.catValue,
                        activeColor: AppColors.red,
                        onChanged: (value) {
                          setState(() {
                            bvalue.setCat = 4;
                          });
                        },
                      ),
                    if (value.organizerModel.aniversary == true)
                      const Text(
                        'Aniversary',
                        style: TextStyle(
                            fontSize: 17.0, color: AppColors.primaryAshThree),
                      ),
                    if (value.organizerModel.office == true)
                      Radio(
                        value: 5,
                        groupValue: bvalue.catValue,
                        activeColor: AppColors.red,
                        onChanged: (value) {
                          setState(() {
                            bvalue.setCat = 5;
                          });
                        },
                      ),
                    if (value.organizerModel.office == true)
                      const Text(
                        'Office',
                        style: TextStyle(
                            fontSize: 17.0, color: AppColors.primaryAshThree),
                      ),
                    if (value.organizerModel.exhibition == true)
                      Radio(
                        value: 6,
                        groupValue: bvalue.catValue,
                        activeColor: AppColors.red,
                        onChanged: (value) {
                          setState(() {
                            bvalue.setCat = 6;
                          });
                        },
                      ),
                    if (value.organizerModel.exhibition == true)
                      const Text(
                        'Exhibition',
                        style: TextStyle(
                            fontSize: 17.0, color: AppColors.primaryAshThree),
                      ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        Provider.of<BookingProvider>(context, listen: false).setDate =
            args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }
}
