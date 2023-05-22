import 'package:eventide_app/components/custom_text_poppins.dart';
import 'package:eventide_app/models/category_model.dart';
import 'package:eventide_app/providers/organizer/organizer_provider.dart';
import 'package:eventide_app/utils/app_colors.dart';
import 'package:eventide_app/utils/assets_constant.dart';
import 'package:eventide_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../organizer_category_list/aniversary_organizer_list/aniversary_organizer_list_page.dart';
import '../../organizer_category_list/birthday_organizer_list/birthday_organizer_list_page.dart';
import '../../organizer_category_list/engagement_organizer_list/engagement_organizer_list_page.dart';
import '../../organizer_category_list/exhibition_organizer_list/exhibition_organizer_list_page.dart';
import '../../organizer_category_list/office_organizer_list/office_organizer_list_page.dart';
import '../../organizer_category_list/wedding_organizer_list/wedding_organizer_list_page.dart';

class HomePageRelatedCategory extends StatelessWidget {
  HomePageRelatedCategory({
    Key? key,
  }) : super(key: key);

  final List<CategoryModel> category = [
    CategoryModel(
        id: 1,
        widget: const WeddingList(),
        category: "Wedding",
        image: "catWedding.png",
        vectorImage: "weddingVector.png"),
    CategoryModel(
        id: 2,
        widget: const BirthdayList(),
        category: "Birthday",
        image: "catBirthday.png",
        vectorImage: "bdayVector.png"),
    CategoryModel(
        id: 3,
        widget: const EngagementList(),
        category: "Engagement",
        image: "catEngagement.png",
        vectorImage: "engagementVector.png"),
    CategoryModel(
        id: 4,
        widget: const AniversaryList(),
        category: "Aniversary",
        image: "catAniversary.png",
        vectorImage: "aniversaryVector.png"),
    CategoryModel(
        id: 5,
        widget: const OfficeList(),
        category: "Office Party",
        image: "catOffice.png",
        vectorImage: "officeVector.png"),
    CategoryModel(
        id: 6,
        widget: const ExhibitionList(),
        category: "Exhibition",
        image: "catExhibition.png",
        vectorImage: "exhibitionVector.png")
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<OrganizerProvider>(
      builder: (context, value, child) {
        return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    value.addToCategoryList(value.organizers);

                    UtilFunction.navigateTo(context, category[index].widget);
                  },
                  child: Container(
                    width: 80,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      // color: const Color.fromARGB(255, 235, 235, 235),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 70,
                          height: 55,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 238, 238, 238),
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(
                                  "${AssetConstant.organierVectorPath}${category[index].vectorImage}",
                                ),
                                fit: BoxFit.contain),
                          ),
                        ),
                        CustomText(
                          category[index].category,
                          fontSize: 11,
                          color: AppColors.bottomColor,
                          fontWeight: FontWeight.w500,
                        )
                      ],
                    ),
                  ),
                ),
            separatorBuilder: (context, index) => const SizedBox(
                  width: 20,
                ),
            itemCount: 6);
      },
    );
  }
}
