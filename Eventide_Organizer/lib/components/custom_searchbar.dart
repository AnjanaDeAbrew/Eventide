// import 'package:eventide_app/utils/app_colors.dart';
// import 'package:eventide_app/utils/assets_constant.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:searchbar_animation/searchbar_animation.dart';

// class CustomSearchBar2 extends StatelessWidget {
//   const CustomSearchBar2(
//     this.hintText, {
//     required this.controller,
//     this.color = AppColors.primaryAshOne,
//     Key? key,
//   }) : super(key: key);

//   final TextEditingController controller;
//   final String hintText;
//   final Color color;

//   @override
//   Widget build(BuildContext context) {
//     return SearchBarAnimation(
//       hintText: hintText,
//       searchBoxWidth: 340,
//       searchBoxColour: AppColors.primaryAshOne,
//       trailingWidget: const Icon(Icons.search),
//       buttonWidget: Image.asset(AssetConstant.searchPath),
//       isSearchBoxOnRightSide: false,
//       durationInMilliSeconds: 500,
//       textEditingController: controller,
//       isOriginalAnimation: false,
//       buttonBorderColour: Colors.black45,
//       secondaryButtonWidget:
//           const Icon(Icons.close, color: AppColors.primaryAshTwo),
//       enableBoxShadow: false,
//       enableButtonShadow: false,
//       enteredTextStyle: GoogleFonts.poppins(fontSize: 16),
//       buttonElevation: 0,
//       onFieldSubmitted: (String value) {
//         debugPrint('onFieldSubmitted value $value');
//       },
//     );

//     // TextField(
//     //   controller: controller,
//     //   decoration: InputDecoration(
//     //     filled: true,
//     //     suffixIcon: IconButton(
//     //         onPressed: () {}, icon: Image.asset(AssetConstant.searchPath)),
//     //     hintText: hintText,
//     //     hintStyle: GoogleFonts.poppins(
//     //         fontSize: 15,
//     //         fontWeight: FontWeight.w600,
//     //         color: AppColors.primaryAshThree),
//     //     fillColor: color,
//     //     enabledBorder: OutlineInputBorder(
//     //       borderRadius: BorderRadius.circular(20),
//     //       borderSide: const BorderSide(color: AppColors.white),
//     //     ),
//     //     focusedBorder: OutlineInputBorder(
//     //         borderRadius: BorderRadius.circular(20),
//     //         borderSide: const BorderSide(color: AppColors.primaryAshOne)),
//     //   ),
//     // );
//   }
// }
