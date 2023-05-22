import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventide_app/components/custom_text_poppins.dart';
import 'package:eventide_app/components/notificationAPI.dart';
import 'package:eventide_app/controllers/booking_controller.dart';
import 'package:eventide_app/models/booking_model.dart';
import 'package:eventide_app/providers/auth/user_provider.dart';
import 'package:eventide_app/screens/main/camera/ar_camera_page.dart';
import 'package:eventide_app/screens/main/drawer/drawer.dart';
import 'package:eventide_app/screens/main/home/widgets/home_organizer_list.dart';
import 'package:eventide_app/screens/main/home/widgets/home_related_category.dart';
import 'package:eventide_app/utils/app_colors.dart';
import 'package:eventide_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<BookingModel> _bookings = [];
  final List<BookingModel> _bookingsPending = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Consumer<UserProvider>(
        builder: (context, value, child) {
          return StreamBuilder<QuerySnapshot>(
              stream: BookingController().getBookings(value.userModel!.uid),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: CustomText(
                      "No Bookings yet",
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

                _bookings.clear();
                _bookingsPending.clear();

                for (var e in snapshot.data!.docs) {
                  Map<String, dynamic> data = e.data() as Map<String, dynamic>;
                  var model = BookingModel.fromJason(data);

                  _bookings.add(model);
                  if (model.notify == 'notify') {
                    _bookingsPending.add(model);

                    ShowNotification(
                        id: 1,
                        body: '${model.orgName} has accepted your booking.',
                        title: 'Booking is accepted');
                    BookingController().updateNotify(
                      model.docId,
                    );
                    _bookingsPending.clear();
                  }
                }
                // for (var i = 0; i < _bookingsPending.length; i++) {
                //   if (_bookingsPending[i].status == 'confirmed') {
                //     ShowNotification(id: 1, body: 'sds', title: 'df');
                //   }
                // }

                return Scaffold(
                  body: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: size.width,
                    height: size.height,
                    child: SingleChildScrollView(child: Consumer<UserProvider>(
                      builder: (context, value, child) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Row(
                                children: [
                                  Builder(builder: (context) {
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        Scaffold.of(context).openDrawer();
                                      },
                                      child: value.isLoading
                                          ? const CircularProgressIndicator
                                              .adaptive(
                                              backgroundColor:
                                                  AppColors.primaryColor,
                                            )
                                          : CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  value.userModel!.img),
                                              radius: 30,
                                            ),
                                    );
                                  }),
                                  const SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CustomText("Welcome",
                                          color: AppColors.primaryAshTwo,
                                          fontSize: 22),
                                      CustomText(
                                        value.userModel!.name,
                                        color: AppColors.black,
                                        fontSize: 20,
                                      )
                                    ],
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                            const SearchBar(),
                            const SizedBox(height: 40),
                            SizedBox(
                              width: size.width,
                              height: 85,
                              child: HomePageRelatedCategory(),
                            ),
                            const SizedBox(height: 40),
                            SizedBox(
                              width: size.width,
                              height: 490,
                              child: const OrganizerList(),
                            )
                          ],
                        );
                      },
                    )),
                  ),
                  drawer: const CustomDrawer(),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      UtilFunction.navigateTo(context, const ARCamera());
                    },
                    backgroundColor: const Color.fromARGB(255, 193, 57, 161),
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.camera_alt,
                      color: AppColors.white,
                    ),
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.miniStartFloat,
                );
              });
        },
      ),

      // ),
    );
  }
}
