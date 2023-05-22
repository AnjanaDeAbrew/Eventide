import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventide_app/components/custom_text_poppins.dart';
import 'package:eventide_app/controllers/booking_controller.dart';
import 'package:eventide_app/models/booking_model.dart';
import 'package:eventide_app/providers/auth/user_provider.dart';
import 'package:eventide_app/screens/main/booking/cancel/booking_item.dart';
import 'package:eventide_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class CanceledBookingPage extends StatefulWidget {
  const CanceledBookingPage({super.key});

  @override
  State<CanceledBookingPage> createState() => _CanceledBookingPageState();
}

class _CanceledBookingPageState extends State<CanceledBookingPage> {
  final List<BookingModel> _bookings = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Consumer<UserProvider>(
      builder: (context, value, child) {
        return StreamBuilder<QuerySnapshot>(
            stream: BookingController().getBookings(value.userModel!.uid),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: CustomText(
                    "No Bookings yet",
                    fontSize: 20,
                    color: AppColors.primaryAshTwo,
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: CustomText(
                    "No bookings",
                    fontSize: 20,
                    color: AppColors.primaryAshTwo,
                  ),
                );
              }
              Logger().i(snapshot.data!.docs.length);
              _bookings.clear();

              for (var e in snapshot.data!.docs) {
                Map<String, dynamic> data = e.data() as Map<String, dynamic>;
                var model = BookingModel.fromJason(data);

                _bookings.add(model);
              }
              return ListView.separated(
                  itemBuilder: (context, index) => CanceledBookingItem(
                        bookingModel: _bookings
                            .where((e) => e.status == 'ucancel')
                            .elementAt(index),
                      ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 40),
                  itemCount:
                      _bookings.where((e) => e.status == 'ucancel').length);
            });
      },
    ));
  }
}
