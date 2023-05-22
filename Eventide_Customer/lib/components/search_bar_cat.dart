import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventide_app/components/custom_text_poppins.dart';
import 'package:eventide_app/controllers/organizer_controller.dart';
import 'package:eventide_app/models/organizer_model.dart';
import 'package:eventide_app/providers/organizer/organizer_provider.dart';
import 'package:eventide_app/utils/app_colors.dart';
import 'package:eventide_app/utils/assets_constant.dart';
import 'package:eventide_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/main/organizer_details/organizer_details.dart';

class SearchBarCat extends StatefulWidget {
  const SearchBarCat({super.key});

  @override
  State<SearchBarCat> createState() => _SearchBarCatState();
}

class _SearchBarCatState extends State<SearchBarCat> {
  final List<OrganizerModel> _organizers = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream: OrganizerController().getOrganizers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: CustomText("No Organizers"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          _organizers.clear();

          for (var e in snapshot.data!.docs) {
            Map<String, dynamic> data = e.data() as Map<String, dynamic>;
            var model = OrganizerModel.fromJason(data);

            _organizers.add(model);
          }
          return InkWell(
            onTap: () {
              showSearch(
                context: context,
                delegate: MySearchDelegate(searchReults: _organizers),
              );
            },
            child: Image.asset(
              AssetConstant.searchPath,
              width: 30,
              height: 30,
            ),
          );
        });
  }
}

class MySearchDelegate extends SearchDelegate {
  MySearchDelegate({required this.searchReults});
  List<OrganizerModel> searchReults;
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back));

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = '';
              }
            },
            icon: const Icon(Icons.clear)),
      ];

  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildSuggestions(BuildContext context) {
    List<OrganizerModel> suggetions = searchReults.where((searchResult) {
      final result = searchResult.name.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemBuilder: (context, index) {
        final suggestion = suggetions[index];
        return ListTile(
          leading: Image.network(
            suggestion.img,
            width: 60,
          ),
          contentPadding: const EdgeInsets.all(5),
          title: CustomText(
            suggestion.name,
            fontSize: 16,
            color: AppColors.primaryAshThree,
            textAlign: TextAlign.left,
          ),
          onTap: () {
            Provider.of<OrganizerProvider>(context, listen: false)
                .setOrganizer = suggestion;

            UtilFunction.navigateTo(context, const OrganizerDetailsPage());
          },
        );
      },
      itemCount: suggetions.length,
    );
  }
}
