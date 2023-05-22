import 'package:eventide_organizer_app/components/custom_text_poppins.dart';
import 'package:eventide_organizer_app/providers/auth/user_provider.dart';
import 'package:eventide_organizer_app/screens/main/chat/conversation/conversation_list_screen.dart';
import 'package:eventide_organizer_app/utils/app_colors.dart';
import 'package:eventide_organizer_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainChatScreen extends StatefulWidget {
  const MainChatScreen({super.key});

  @override
  State<MainChatScreen> createState() => _MainChatScreenState();
}

class _MainChatScreenState extends State<MainChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              createSilverAppBar1(context),
            ];
          },
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                height: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    CustomText(
                      'Chat',
                      fontSize: 24,
                      color: Color.fromARGB(255, 239, 102, 87),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.chat,
                      color: Color.fromARGB(255, 239, 102, 87),
                    )
                  ],
                ),
                // color: const Color.fromARGB(255, 239, 105, 105),
                // child: TabBar(
                //   labelColor: const Color.fromARGB(255, 239, 102, 87),
                //   labelStyle: const TextStyle(
                //       fontSize: 18, fontWeight: FontWeight.w500),
                //   indicator: const UnderlineTabIndicator(
                //     borderSide: BorderSide(
                //         width: 4, color: Color.fromARGB(255, 239, 102, 87)),
                //     insets: EdgeInsets.symmetric(horizontal: 30.0),
                //   ),
                //   unselectedLabelColor: const Color(0xff9f9aad),
                //   padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                //   tabs: [
                //     Tab(
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: const [
                //           Text('Chat'),
                //           SizedBox(width: 8),
                //           Icon(
                //             Icons.chat,
                //           )
                //         ],
                //       ),
                //     ),
                //     Tab(
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: const [
                //           Text('Customers'),
                //           SizedBox(width: 8),
                //           Icon(Icons.supervisor_account_rounded)
                //         ],
                //       ),
                //     )
                //   ],
                // ),
              ),
              Expanded(
                child: ChatListScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

SliverAppBar createSilverAppBar1(BuildContext context) {
  return SliverAppBar(
    // backgroundColor: Colors.redAccent,
    expandedHeight: 90,
    floating: false,
    elevation: 0,
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: false,

    flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      UtilFunction.goBack(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 15),
                  const CustomText(
                    'EventideChat',
                    fontSize: 20,
                    color: AppColors.black,
                  ),
                  const Spacer(),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        Provider.of<UserProvider>(context, listen: false)
                            .organizerModel!
                            .img),
                    radius: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    }),
  );
}
