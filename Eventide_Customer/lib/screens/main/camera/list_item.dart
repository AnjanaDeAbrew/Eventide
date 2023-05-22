import 'package:eventide_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ListItems extends StatefulWidget {
  const ListItems({super.key, required this.onTap});
  final Function onTap;

  @override
  State<ListItems> createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  List<String> items = [
    'assets/images/choc_cake.png',
    'assets/images/wedding_flower.png',
    'assets/images/flower_two.png',
    'assets/images/love.png',
    'assets/images/flower.png',
    'assets/images/wed_cake.png',
    'assets/images/wed_cake_two.png',
  ];
  String? selected;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                selected = items[index];
                widget.onTap(items[index]);
              });
            },
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: selected == items[index]
                    ? const Color.fromARGB(255, 226, 195, 193)
                    : AppColors.white,
              ),
              child: Image.asset(
                items[index],
                width: 300,
                filterQuality: FilterQuality.high,
              ),
            ),
          );
        },
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 20),
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
