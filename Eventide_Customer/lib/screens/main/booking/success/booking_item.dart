import 'package:eventide_app/components/custom_text_poppins.dart';
import 'package:eventide_app/models/booking_model.dart';
import 'package:eventide_app/utils/app_colors.dart';
import 'package:eventide_app/utils/assets_constant.dart';
import 'package:flutter/material.dart';

class SuccessBookingItem extends StatelessWidget {
  const SuccessBookingItem({
    required this.bookingModel,
    super.key,
  });
  final BookingModel bookingModel;

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
              Image.asset(
                '${AssetConstant.imagePath}organize.png',
                width: 20,
                height: 20,
                color: const Color.fromARGB(255, 233, 17, 14),
              ),
              const SizedBox(width: 12),
              CustomText(
                bookingModel.orgName,
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                textOverflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
              ),
            ],
          ),
          CustomText('#${bookingModel.docId}',
              fontSize: 15,
              color: AppColors.primaryAshThree,
              fontWeight: FontWeight.w500),
          Row(
            children: [
              const Icon(Icons.email_outlined,
                  size: 20, color: AppColors.primaryAshTwo),
              const SizedBox(width: 12),
              CustomText(bookingModel.orgEmail,
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            width: 100,
            height: 30,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 196, 156, 233).withOpacity(.2),
                border: Border.all(
                  width: 1,
                  color: Colors.purple,
                ),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(
                  Icons.emoji_events,
                  size: 16,
                  color: Colors.purple,
                ),
                CustomText(
                  "Success",
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
