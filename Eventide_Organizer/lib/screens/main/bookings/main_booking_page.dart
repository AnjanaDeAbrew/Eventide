import 'package:animate_do/animate_do.dart';
import 'package:eventide_organizer_app/components/custom_text_poppins.dart';
import 'package:eventide_organizer_app/providers/home/booking_provider.dart';
import 'package:eventide_organizer_app/screens/main/bookings/cancel/cancel_booking_page.dart';
import 'package:eventide_organizer_app/screens/main/bookings/confirm/confirm_booking_page.dart';
import 'package:eventide_organizer_app/screens/main/bookings/done/done_booking_page.dart';
import 'package:eventide_organizer_app/utils/app_colors.dart';
import 'package:eventide_organizer_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pending/pending_booking_page.dart';

class MainBookingPage extends StatefulWidget {
  const MainBookingPage({super.key});

  @override
  State<MainBookingPage> createState() => _MainBookingPageState();
}

bool _isCicked = true;

class _MainBookingPageState extends State<MainBookingPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 244, 247, 254),
        body: DefaultTabController(
            length: 4,
            child: Consumer<BookingProvider>(
              builder: (context, value, child) {
                return Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            UtilFunction.goBack(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        const SizedBox(width: 70),
                        const CustomText(
                          "Bookings",
                          color: AppColors.black,
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 55,
                      // color: const Color.fromARGB(255, 239, 105, 105),
                      child: TabBar(
                        indicator: BoxDecoration(
                            color: const Color(0xff7BD5CA),
                            // border: Border.all(
                            //     width: 1.5,
                            //     color: const Color.fromARGB(255, 137, 137, 137)),
                            borderRadius: BorderRadius.circular(10)),
                        // indicatorPadding: const EdgeInsets.all(1),
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        indicatorPadding:
                            const EdgeInsets.symmetric(horizontal: 2),
                        unselectedLabelColor: AppColors.primaryAshThree,
                        labelStyle: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),

                        tabs: const [
                          Tab(text: 'Pending'),
                          Tab(text: 'Confirmed'),
                          Tab(text: 'Success'),
                          Tab(text: 'Canceled')
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    _isCicked
                        ? FadeIn(
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              width: size.width,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: AppColors.red),
                                  color: const Color.fromARGB(255, 255, 85, 0)
                                      .withOpacity(.1)),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: size.width * 0.86,
                                    height: 55,
                                    child: const CustomText(
                                      "*!!! You are unable to cancel a reservation once it has been confirmed. Consult with the customer and come to an arrangement if you want to cancel. !!!* ",
                                      fontSize: 11,
                                      color: AppColors.primaryAshThree,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isCicked = !_isCicked;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      size: 18,
                                      color: AppColors.red,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : FadeIn(
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              width: size.width,
                              height: 35,
                              color: const Color.fromARGB(255, 162, 196, 238)
                                  .withOpacity(.2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(width: 20),
                                  const CustomText(
                                    "More Info !",
                                    fontSize: 11,
                                    color: AppColors.primaryAshThree,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isCicked = !_isCicked;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      size: 22,
                                      color: Color.fromARGB(255, 140, 140, 140),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    const SizedBox(height: 20),
                    const Expanded(
                      child: TabBarView(
                        children: [
                          PendingBookingPage(),
                          ConfirmedBookingPage(),
                          DoneBookingPage(),
                          CanceledBookingPage(),
                        ],
                      ),
                    ),
                  ],
                );
              },
            )),
      ),
    );
  }
}
