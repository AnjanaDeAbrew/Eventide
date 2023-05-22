import 'package:eventide_app/components/custom_text_poppins.dart';
import 'package:eventide_app/components/search_bar_cat.dart';
import 'package:eventide_app/providers/auth/user_provider.dart';
import 'package:eventide_app/screens/main/category/widgets/category_grid.dart';
import 'package:eventide_app/screens/main/drawer/drawer.dart';
import 'package:eventide_app/screens/main/profile/profile.dart';
import 'package:eventide_app/utils/app_colors.dart';
import 'package:eventide_app/utils/assets_constant.dart';
import 'package:eventide_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          // padding: const EdgeInsets.symmetric(horizontal: 28),
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    CustomText(
                      "Eventide",
                      fontSize: 24,
                      color: AppColors.black,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 09),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Builder(builder: (BuildContext context) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: SizedBox(
                          height: 35,
                          width: 35,
                          child: Image.asset(
                              "${AssetConstant.iconPath}menuIcon.png"),
                        ),
                      );
                    }),
                    const Spacer(),
                    const SearchBarCat(),
                    const SizedBox(width: 12),
                    InkWell(onTap: () {
                      UtilFunction.navigateTo(context, const Profile());
                    }, child: Consumer<UserProvider>(
                      builder: (context, value, child) {
                        return CircleAvatar(
                          backgroundImage: NetworkImage(value.userModel!.img),
                          radius: 22,
                        );
                      },
                    )),
                    // IconButton(
                    //     onPressed: () {
                    //       UtilFunction.navigateTo(context, const Favourite());
                    //     },
                    //     icon: Image.asset(AssetConstant.bellPath)),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: const [
                    CustomText("All", fontSize: 25, color: AppColors.black),
                    CustomText(" Categories",
                        fontSize: 25, color: AppColors.black)
                  ],
                ),
              ),
              const SizedBox(height: 25),
              CategoryGrid()
            ],
          ),
        ),
        drawer: const CustomDrawer(),
      ),
    );
  }
}
