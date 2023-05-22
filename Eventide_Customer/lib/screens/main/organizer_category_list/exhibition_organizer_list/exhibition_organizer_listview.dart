import 'package:eventide_app/components/custom_text_poppins.dart';
import 'package:eventide_app/providers/organizer/organizer_provider.dart';
import 'package:eventide_app/providers/organizer/review_provider.dart';
import 'package:eventide_app/screens/main/organizer_details/organizer_details.dart';
import 'package:eventide_app/utils/app_colors.dart';
import 'package:eventide_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExhibitionOrganizersList extends StatefulWidget {
  const ExhibitionOrganizersList({
    Key? key,
  }) : super(key: key);

  @override
  State<ExhibitionOrganizersList> createState() =>
      _ExhibitionOrganizersListState();
}

class _ExhibitionOrganizersListState extends State<ExhibitionOrganizersList> {
  final bool _isClicked = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<OrganizerProvider>(
      builder: (context, value, child) {
        return ListView.separated(
            itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    //---first set the product model
                    Provider.of<OrganizerProvider>(context, listen: false)
                        .setOrganizer = value.organizers[index];
                    Provider.of<ReviewProvider>(context, listen: false)
                        .startFetchReviews(value.organizerModel.uid, context);
                    UtilFunction.navigateTo(
                        context, const OrganizerDetailsPage());
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // border: Border.all(
                        //   width: 1,
                        //   color: const Color.fromARGB(255, 221, 221, 221),
                        // ),
                        color: AppColors.white,
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 5,
                              color: AppColors.primaryAshTwo,
                              offset: Offset(2, 3))
                        ]),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 130,
                          height: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(
                                    value.exhibitionList[index].img),
                                fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(width: 25),
                        SizedBox(
                          width: 210,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                value.exhibitionList[index].name,
                                fontSize: 15,
                                color: AppColors.black,
                                textOverflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                              ),
                              CustomText(value.exhibitionList[index].mobile,
                                  fontSize: 14,
                                  color: AppColors.primaryAshThree),
                              CustomText(value.exhibitionList[index].address,
                                  fontSize: 15,
                                  textAlign: TextAlign.left,
                                  color: AppColors.primaryAshThree),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            separatorBuilder: (context, index) => const SizedBox(
                  height: 20,
                ),
            itemCount: value.exhibitionList.length);
      },
    );
  }
}
