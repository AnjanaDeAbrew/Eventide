import 'package:eventide_organizer_app/components/custom_text_poppins.dart';
import 'package:eventide_organizer_app/models/booking_model.dart';
import 'package:eventide_organizer_app/providers/home/booking_provider.dart';
import 'package:eventide_organizer_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmedBookingItem extends StatelessWidget {
  const ConfirmedBookingItem({
    required this.bookingModel,
    required this.index,
    super.key,
  });
  final BookingModel bookingModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      height: 230,
      width: size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white,
          border: Border.all(width: 1, color: AppColors.primaryAshOne)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.supervisor_account_rounded,
                color: Colors.blue,
              ),
              const SizedBox(width: 12),
              CustomText(
                bookingModel.userName,
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                textOverflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
              ),
            ],
          ),
          Row(
            children: [
              CustomText('#${bookingModel.docId}',
                  fontSize: 15,
                  color: AppColors.primaryAshThree,
                  fontWeight: FontWeight.w500),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.email_outlined,
                  size: 20, color: AppColors.primaryAshTwo),
              const SizedBox(width: 12),
              CustomText(bookingModel.userEmail,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: AppColors.black),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.calendar_month_outlined,
                  size: 20, color: AppColors.primaryAshTwo),
              const SizedBox(width: 12),
              CustomText(bookingModel.date.substring(0, 10),
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: AppColors.black),
              const SizedBox(width: 22),
              const Icon(Icons.timelapse_outlined,
                  size: 20, color: AppColors.primaryAshTwo),
              const SizedBox(width: 12),
              CustomText(bookingModel.time,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: AppColors.black),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.chair_alt_outlined,
                  size: 20, color: AppColors.primaryAshTwo),
              const SizedBox(width: 12),
              CustomText(bookingModel.count,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: AppColors.black),
              const SizedBox(width: 22),
              const Icon(Icons.star_border_purple500,
                  size: 20, color: AppColors.primaryAshTwo),
              const SizedBox(width: 12),
              bookingModel.catValue == 1
                  ? const CustomText('Wedding',
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: AppColors.black)
                  : bookingModel.catValue == 2
                      ? const CustomText('Birthday',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: AppColors.black)
                      : bookingModel.catValue == 3
                          ? const CustomText('Engagement',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: AppColors.black)
                          : bookingModel.catValue == 4
                              ? const CustomText('Aniversary',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: AppColors.black)
                              : bookingModel.catValue == 5
                                  ? const CustomText('Office',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: AppColors.black)
                                  : const CustomText('Exhibition',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: AppColors.black)
            ],
          ),
          Row(
            children: [
              const CustomText('confirmed on',
                  fontSize: 11,
                  color: AppColors.primaryAshThree,
                  fontWeight: FontWeight.w500),
              const SizedBox(width: 12),
              CustomText(bookingModel.dateTime.substring(0, 10),
                  fontSize: 11,
                  color: AppColors.primaryAshTwo,
                  fontWeight: FontWeight.w500),
              const SizedBox(width: 12),
              CustomText(bookingModel.dateTime.substring(11, 19),
                  fontSize: 11,
                  color: AppColors.primaryAshTwo,
                  fontWeight: FontWeight.w500),
            ],
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                width: 120,
                height: 30,
                decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(255, 44, 202, 57).withOpacity(.1),
                    border: Border.all(
                      width: 1,
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Icon(
                      Icons.emoji_emotions,
                      size: 18,
                      color: Colors.green,
                    ),
                    CustomText(
                      "Confirmed",
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 30),
              InkWell(
                onTap: () {
                  Provider.of<BookingProvider>(context, listen: false)
                      .startupdateStatus(bookingModel.docId, 'done', index);
                },
                child: Container(
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 228, 130, 230),
                      borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: const Center(child: CustomText("Done", fontSize: 15)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
