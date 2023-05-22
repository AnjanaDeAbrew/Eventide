import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventide_app/components/custom_text_poppins.dart';
import 'package:eventide_app/controllers/fav_controller.dart';
import 'package:eventide_app/controllers/organizer_controller.dart';
import 'package:eventide_app/models/organizer_model.dart';
import 'package:eventide_app/providers/auth/user_provider.dart';
import 'package:eventide_app/providers/organizer/fav_provider.dart';
import 'package:eventide_app/providers/organizer/organizer_provider.dart';
import 'package:eventide_app/screens/main/organizer_details/organizer_details.dart';
import 'package:eventide_app/utils/app_colors.dart';
import 'package:eventide_app/utils/assets_constant.dart';
import 'package:eventide_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class OrganizerList extends StatefulWidget {
  const OrganizerList({
    Key? key,
  }) : super(key: key);

  @override
  State<OrganizerList> createState() => _OrganizerListState();
}

bool _isClicked = false;

class _OrganizerListState extends State<OrganizerList> {
  final List<OrganizerModel> _favList = [];
  final List<OrganizerModel> _organizers = [];
  @override
  Widget build(BuildContext context) {
    return Consumer<OrganizerProvider>(
      builder: (context, value, child) {
        return value.isLoading
            ? const CircularProgressIndicator.adaptive(
                backgroundColor: AppColors.primaryColor,
              )
            : StreamBuilder<QuerySnapshot>(
                stream: FavController().getFavs(
                    Provider.of<UserProvider>(context, listen: false)
                        .userModel!
                        .uid),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: CustomText(
                        "No fav items",
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
                  Logger().i(snapshot.data!.docs.length);
                  _favList.clear();

                  for (var e in snapshot.data!.docs) {
                    Map<String, dynamic> data =
                        e.data() as Map<String, dynamic>;
                    var model = OrganizerModel.fromJason(data);

                    _favList.add(model);
                  }
                  return StreamBuilder<QuerySnapshot>(
                      stream: OrganizerController().getOrganizers(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: CustomText(
                              "No Organizers",
                              fontSize: 20,
                              color: AppColors.primaryAshTwo,
                            ),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        Logger().i(snapshot.data!.docs.length);
                        _organizers.clear();

                        for (var e in snapshot.data!.docs) {
                          Map<String, dynamic> data =
                              e.data() as Map<String, dynamic>;
                          var model = OrganizerModel.fromJason(data);

                          _organizers.add(model);
                        }
                        return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    //---first set the organizer model
                                    Provider.of<OrganizerProvider>(context,
                                            listen: false)
                                        .setOrganizer = _organizers[index];

                                    UtilFunction.navigateTo(
                                        context, const OrganizerDetailsPage());
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    width: 380,
                                    height: 490,
                                    decoration: BoxDecoration(
                                      color: AppColors.black,
                                      borderRadius: BorderRadius.circular(40),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              _organizers[index].img),
                                          opacity: .7,
                                          fit: BoxFit.cover),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const SizedBox(width: 220),
                                            const SizedBox(height: 90),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaX: 40, sigmaY: 50),
                                                child: Container(
                                                  width: 48,
                                                  height: 48,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      color: const Color
                                                                  .fromARGB(
                                                              255, 90, 107, 134)
                                                          .withOpacity(0.5)),
                                                  child: Consumer<FavProvider>(
                                                    builder: (context, fvalue,
                                                        child) {
                                                      return IconButton(
                                                          onPressed: () {
                                                            if (_organizers[
                                                                        index]
                                                                    .fav ==
                                                                'true') {
                                                              fvalue.removeFromFav(
                                                                  Provider.of<UserProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .userModel!,
                                                                  _organizers[
                                                                      index],
                                                                  context);
                                                            } else if (_organizers[
                                                                        index]
                                                                    .fav ==
                                                                'false') {
                                                              fvalue.startAddFav(
                                                                  Provider.of<UserProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .userModel!,
                                                                  value.organizers[
                                                                      index],
                                                                  context);
                                                            }
                                                          },
                                                          icon: _organizers[
                                                                          index]
                                                                      .fav ==
                                                                  'true'
                                                              ? Image.asset(
                                                                  AssetConstant
                                                                      .heartFillPath)
                                                              : Image.asset(
                                                                  AssetConstant
                                                                      .hpth,
                                                                  width: 25,
                                                                  height: 25,
                                                                  color: AppColors
                                                                      .white));
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 320,
                                                child: CustomText(
                                                  value.organizers[index].name,
                                                  fontSize: 20,
                                                  textAlign: TextAlign.left,
                                                  color: AppColors.white,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.location_on,
                                                    color: AppColors.white,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  SizedBox(
                                                    width: 300,
                                                    child: CustomText(
                                                      value.organizers[index]
                                                          .address,
                                                      fontSize: 12,
                                                      textAlign: TextAlign.left,
                                                      color: AppColors.white,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20)
                                      ],
                                    ),
                                  ),
                                ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 12),
                            itemCount: _organizers.length);
                      });
                });
      },
    );
  }
}
