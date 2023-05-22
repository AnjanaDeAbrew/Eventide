import 'package:alan_voice/alan_voice.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eventide_app/components/custom_text_poppins.dart';
import 'package:eventide_app/providers/organizer/organizer_provider.dart';
import 'package:eventide_app/screens/main/booking/main_booking_page.dart';
import 'package:eventide_app/screens/main/camera/ar_camera_page.dart';
import 'package:eventide_app/screens/main/category/category_page.dart';
import 'package:eventide_app/screens/main/favourite/favourite_page.dart';
import 'package:eventide_app/screens/main/home/home_screen.dart';
import 'package:eventide_app/screens/main/organizer_category_list/aniversary_organizer_list/aniversary_organizer_list_page.dart';
import 'package:eventide_app/screens/main/organizer_category_list/birthday_organizer_list/birthday_organizer_list_page.dart';
import 'package:eventide_app/screens/main/organizer_category_list/engagement_organizer_list/engagement_organizer_list_page.dart';
import 'package:eventide_app/screens/main/organizer_category_list/exhibition_organizer_list/exhibition_organizer_list_page.dart';
import 'package:eventide_app/screens/main/organizer_category_list/office_organizer_list/office_organizer_list_page.dart';
import 'package:eventide_app/screens/main/organizer_category_list/wedding_organizer_list/wedding_organizer_list_page.dart';
import 'package:eventide_app/screens/main/profile/profile.dart';
import 'package:eventide_app/utils/app_colors.dart';
import 'package:eventide_app/utils/util_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //-------store the active index
  int activeIndex = 0;
  @override
  void initState() {
    super.initState();
    setupAlan();
  }

  setupAlan() {
    AlanVoice.addButton(
      "93aa2d9ad7cfd8808251294021cecbb72e956eca572e1d8b807a3e2338fdd0dc/stage",
      buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT,
    );
    AlanVoice.onCommand.add((command) => _handleCommand(command.data));
  }

  void _handleCommand(Map<String, dynamic> command) {
    switch (command["command"]) {
      case "forward":
        UtilFunction.navigateTo(context, const Category());
        break;
      case "forwardWedding":
        Provider.of<OrganizerProvider>(context, listen: false)
            .addToCategoryList(
                Provider.of<OrganizerProvider>(context, listen: false)
                    .organizers);
        UtilFunction.navigateTo(context, const WeddingList());
        break;
      case "forwardBirthday":
        Provider.of<OrganizerProvider>(context, listen: false)
            .addToCategoryList(
                Provider.of<OrganizerProvider>(context, listen: false)
                    .organizers);
        UtilFunction.navigateTo(context, const BirthdayList());
        break;
      case "forwardEngagement":
        Provider.of<OrganizerProvider>(context, listen: false)
            .addToCategoryList(
                Provider.of<OrganizerProvider>(context, listen: false)
                    .organizers);
        UtilFunction.navigateTo(context, const EngagementList());
        break;
      case "forwardAniversary":
        Provider.of<OrganizerProvider>(context, listen: false)
            .addToCategoryList(
                Provider.of<OrganizerProvider>(context, listen: false)
                    .organizers);
        UtilFunction.navigateTo(context, const AniversaryList());
        break;
      case "forwardOffice":
        Provider.of<OrganizerProvider>(context, listen: false)
            .addToCategoryList(
                Provider.of<OrganizerProvider>(context, listen: false)
                    .organizers);
        UtilFunction.navigateTo(context, const OfficeList());
        break;
      case "forwardExhibition":
        Provider.of<OrganizerProvider>(context, listen: false)
            .addToCategoryList(
                Provider.of<OrganizerProvider>(context, listen: false)
                    .organizers);
        UtilFunction.navigateTo(context, const ExhibitionList());
        break;
      case "back":
        UtilFunction.goBack(context);
        break;
      case "backToHome":
        UtilFunction.navigateTo(context, const MainScreen());
        break;
      case "forwardOrg":
        UtilFunction.navigateTo(context, const Category());
        break;
      case "forwardCam":
        UtilFunction.navigateTo(context, const ARCamera());
        break;
      case "forwardProfile":
        UtilFunction.navigateTo(context, const Profile());
        break;
      case "forwardBooking":
        UtilFunction.navigateTo(context, const MainBookingPage());
        break;
      case "forwardFav":
        UtilFunction.navigateTo(context, const Favourite());
        break;
      default:
        print('unknown command');
    }
  }

  //-------screen list
  final List<Widget> _screens = [
    const HomeScreen(),
    const Category(),
    const Favourite(),
    const Profile(),
  ];
  DateTime backPressedTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackButtonDoubleClicked(context),
      child: StreamBuilder<ConnectivityResult>(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapshot) {
            return Scaffold(
                backgroundColor: snapshot.data == ConnectivityResult.none
                    ? const Color.fromARGB(255, 212, 211, 211)
                    : AppColors.white,
                body: snapshot.data == ConnectivityResult.none
                    ? CupertinoAlertDialog(
                        title: const CustomText('Oops unable to load',
                            color: AppColors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w400),
                        content: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CustomText(
                              "We're having trouble to connecting. Please check your connectivity.",
                              textAlign: TextAlign.left,
                              color: AppColors.primaryAshThree,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        actions: [
                          CupertinoButton(
                            color: AppColors.primaryColor,
                            onPressed: () {},
                            padding: const EdgeInsets.all(10),
                            child: const CustomText('PLEASE TRY AGAIN',
                                textAlign: TextAlign.center,
                                color: AppColors.white,
                                fontSize: 18),
                          )
                        ],
                      )
                    : _screens[activeIndex],
                bottomNavigationBar: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 0.5,
                        color: Colors.black54,
                        offset: Offset(0.0, 0.75),
                      )
                    ],
                    color: Color.fromARGB(255, 41, 41, 41),
                  ),
                  height: 75,
                  child: GNav(
                    gap: 6,
                    iconSize: 26,
                    curve: Curves.easeInCubic,
                    haptic: true,
                    tabMargin: const EdgeInsets.symmetric(horizontal: 12),
                    tabBorderRadius: 25,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 12),
                    duration: const Duration(milliseconds: 400),
                    textStyle: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: AppColors.white),
                    color: AppColors.primaryAshTwo,
                    activeColor: AppColors.white,
                    tabBackgroundColor: AppColors.primaryColor,
                    tabs: const [
                      GButton(
                        icon: Icons.home_filled,
                        text: 'Home',
                      ),
                      GButton(
                        icon: Icons.grid_view_rounded,
                        text: 'Browse',
                      ),
                      GButton(
                        icon: Icons.favorite_rounded,
                        text: 'Favourite',
                      ),
                      GButton(
                        icon: LineIcons.user,
                        text: 'Profile',
                      ),
                    ],
                    selectedIndex: activeIndex,
                    onTabChange: (index) {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                  ),
                ));
          }),
    );
  }

  void toast(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomText(
          text,
          fontSize: 12,
          color: AppColors.white,
        ),
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.none,
        margin: const EdgeInsets.symmetric(horizontal: 100),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor:
            const Color.fromARGB(255, 120, 119, 119).withOpacity(.7),
      ),
    );
  }

  Future<bool> _onBackButtonDoubleClicked(BuildContext context) async {
    final difference = DateTime.now().difference(backPressedTime);
    backPressedTime = DateTime.now();
    if (difference >= const Duration(seconds: 2)) {
      toast(context, "Double tap to exit");
      return false;
    } else {
      SystemNavigator.pop(animated: true);
      return true;
    }
  }
}
