import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventide_app/components/custom_text_poppins.dart';
import 'package:eventide_app/controllers/fav_controller.dart';
import 'package:eventide_app/models/organizer_model.dart';
import 'package:eventide_app/providers/auth/user_provider.dart';
import 'package:eventide_app/providers/organizer/organizer_provider.dart';
import 'package:eventide_app/screens/main/drawer/drawer.dart';
import 'package:eventide_app/screens/main/favourite/fav_item.dart';
import 'package:eventide_app/utils/app_colors.dart';
import 'package:eventide_app/utils/assets_constant.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  final List<OrganizerModel> _favList = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Builder(
            builder: (BuildContext context) {
              return InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: const Image(
                  image: AssetImage("${AssetConstant.iconPath}menuIcon.png"),
                  color: AppColors.black,
                ),
              );
            },
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 244, 247, 254),
        body: SizedBox(
          width: size.width,
          child: Column(
            children: [
              const CustomText(
                "Favourites",
                color: AppColors.black,
              ),
              const SizedBox(height: 30),
              Consumer<OrganizerProvider>(
                builder: (context, value, child) {
                  return StreamBuilder<QuerySnapshot>(
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                        return Expanded(
                          child: _favList.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.heart_broken_outlined,
                                          size: 100,
                                          color: Color.fromARGB(
                                              255, 228, 228, 228)),
                                      CustomText(
                                        "No Favourites",
                                        fontSize: 40,
                                        color:
                                            Color.fromARGB(255, 228, 228, 228),
                                      ),
                                    ],
                                  ),
                                )
                              : ListView.separated(
                                  itemBuilder: (context, index) =>
                                      FavItem(organizerModel: _favList[index]),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 20,
                                      ),
                                  itemCount: _favList.length),
                        );
                      });
                },
              )
            ],
          ),
        ),
        drawer: const CustomDrawer(),
      ),
    );
  }
}
