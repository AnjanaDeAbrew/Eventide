import 'package:eventide_app/components/custom_text_poppins.dart';
import 'package:eventide_app/models/category_model.dart';
import 'package:eventide_app/screens/main/organizer_category_list/birthday_organizer_list/birthday_organizer_listview.dart';
import 'package:eventide_app/utils/app_colors.dart';
import 'package:eventide_app/utils/assets_constant.dart';
import 'package:eventide_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/organizer/organizer_provider.dart';

class BirthdayList extends StatefulWidget {
  const BirthdayList({super.key});

  @override
  State<BirthdayList> createState() => _BirthdayListState();
}

final List<CategoryModel> category = [
  CategoryModel(
      id: 2,
      widget: const BirthdayList(),
      category: "Birthday",
      image: "catBirthday.png",
      vectorImage: "bdayVector.png"),
];

class _BirthdayListState extends State<BirthdayList> {
  final _isClicked = false;
  // var _isColorChange = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: size.width,
                height: 160,
                color: AppColors.organizerPageColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            UtilFunction.goBack(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        const SizedBox(height: 30),
                        CustomText(
                          category[0].category,
                          fontSize: 32,
                          color: const Color(0xff524E4E),
                        )
                      ],
                    ),
                    Image.asset(
                        "${AssetConstant.organierVectorPath}${category[0].vectorImage}")
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    CustomText(
                      "Results : ${Provider.of<OrganizerProvider>(context, listen: false).birthdayList.length}",
                      fontSize: 20,
                      color: AppColors.black,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Expanded(child: BirthdayOrganizersList()),
            ],
          ),
        ),
      ),
    );
  }
}
