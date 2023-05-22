import 'package:eventide_app/components/custom_text_poppins.dart';
import 'package:eventide_app/providers/home/booking_provider.dart';
import 'package:eventide_app/screens/main/booking/accepted/accepted_booking_page.dart';
import 'package:eventide_app/screens/main/booking/cancel/cancel_booking_page.dart';
import 'package:eventide_app/screens/main/booking/success/success_booking_page.dart';
import 'package:eventide_app/utils/app_colors.dart';
import 'package:eventide_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pending/pending_booking_page.dart';

class MainBookingPage extends StatefulWidget {
  const MainBookingPage({super.key});

  @override
  State<MainBookingPage> createState() => _MainBookingPageState();
}

class _MainBookingPageState extends State<MainBookingPage> {
  @override
  Widget build(BuildContext context) {
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
                            fontSize: 18, fontWeight: FontWeight.w500),

                        tabs: const [
                          Tab(text: 'Pending'),
                          Tab(text: 'Accepted'),
                          Tab(text: 'Canceled'),
                          Tab(text: 'Success')
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Expanded(
                      child: TabBarView(
                        children: [
                          PendingBookingPage(),
                          ConfirmedBookingPage(),
                          CanceledBookingPage(),
                          SuccessBookingPage()
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
