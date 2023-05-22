import 'package:eventide_app/components/custom_text_poppins.dart';
import 'package:eventide_app/models/category_model.dart';
import 'package:eventide_app/providers/organizer/organizer_provider.dart';
import 'package:eventide_app/utils/app_colors.dart';
import 'package:eventide_app/utils/assets_constant.dart';
import 'package:eventide_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({required this.category, super.key});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Consumer<OrganizerProvider>(
      builder: (context, value, child) {
        return InkWell(
            onTap: () {
              value.addToCategoryList(value.organizers);
              UtilFunction.navigateTo(context, category.widget);
            },
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        '${AssetConstant.categoryPath}${category.image}'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, color: AppColors.primaryAshOne),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    // padding: const EdgeInsets.symmetric(horizontal: 8),
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.8),
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(18),
                            bottomRight: Radius.circular(18))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          category.category,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }
}
