import 'package:eventide_app/components/custom_text_poppins.dart';
import 'package:eventide_app/models/organizer_model.dart';
import 'package:eventide_app/providers/auth/user_provider.dart';
import 'package:eventide_app/providers/organizer/fav_provider.dart';
import 'package:eventide_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavItem extends StatelessWidget {
  FavItem({super.key, required this.organizerModel});

  OrganizerModel organizerModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 100,
      width: size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                blurRadius: 1,
                color: AppColors.primaryAshTwo,
                offset: Offset(2, 3))
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(organizerModel.img),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 15),
              SizedBox(
                width: 242,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      organizerModel.name,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      textOverflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      color: AppColors.black,
                    ),
                    CustomText(
                      organizerModel.address,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      textOverflow: TextOverflow.ellipsis,
                      color: AppColors.black,
                      textAlign: TextAlign.left,
                    ),
                    CustomText(
                      organizerModel.mobile,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.black,
                    )
                  ],
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Provider.of<FavProvider>(context, listen: false).removeFromFav(
                  Provider.of<UserProvider>(context, listen: false).userModel!,
                  organizerModel,
                  context);
            },
            child: const Icon(
              Icons.close,
              color: AppColors.red,
            ),
          ),
        ],
      ),
    );
  }
}
