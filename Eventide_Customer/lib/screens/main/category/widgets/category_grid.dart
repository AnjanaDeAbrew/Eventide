import 'package:eventide_app/models/category_model.dart';
import 'package:eventide_app/providers/organizer/organizer_provider.dart';
import 'package:eventide_app/screens/main/category/widgets/category_tile.dart';
import 'package:eventide_app/screens/main/organizer_category_list/aniversary_organizer_list/aniversary_organizer_list_page.dart';
import 'package:eventide_app/screens/main/organizer_category_list/birthday_organizer_list/birthday_organizer_list_page.dart';
import 'package:eventide_app/screens/main/organizer_category_list/engagement_organizer_list/engagement_organizer_list_page.dart';
import 'package:eventide_app/screens/main/organizer_category_list/exhibition_organizer_list/exhibition_organizer_list_page.dart';
import 'package:eventide_app/screens/main/organizer_category_list/office_organizer_list/office_organizer_list_page.dart';
import 'package:eventide_app/screens/main/organizer_category_list/wedding_organizer_list/wedding_organizer_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryGrid extends StatelessWidget {
  CategoryGrid({
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
    return Expanded(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Consumer<OrganizerProvider>(
            builder: (context, value, child) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 45),
                itemBuilder: (context, index) => CategoryTile(
                  category: category[index],
                ),
                itemCount: category.length,
              );
            },
          )),
    );
  }
}
