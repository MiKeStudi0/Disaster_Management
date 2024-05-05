import 'package:disaster_management/screens/receiver_screen/list_view_accepted.dart';
import 'package:disaster_management/screens/receiver_screen/list_view_requsters.dart';
import 'package:disaster_management/screens/receiver_screen/my_request_list.dart';
import 'package:flutter/material.dart';
import 'package:disaster_management/common/appbar.dart';
import 'package:disaster_management/common/tabbar.dart';
import 'package:disaster_management/utils/constants/colors.dart';
import 'package:disaster_management/utils/constants/sizes.dart';
import 'package:disaster_management/utils/helpers/helper_functions.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TAppBar(
          title: Text("Requests List",
          style: TextStyle(
            color: dark ? const Color.fromARGB(255, 255, 255, 255) : const Color.fromARGB(255, 0, 0, 0),
            fontSize: 16,
          ),
          )),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  backgroundColor: THelperFunctions.isDarkMode(context)
                      ? TColors.black
                      : TColors.white,
                  expandedHeight: 10,
                  flexibleSpace: Padding(
                      padding: const EdgeInsets.all(TSizes.defaultSpace),
                      child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(
                              height: TSizes.spaceBtwItems,
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwSections,
                            ),
                          ])),
                  bottom: const TTabBar(tabs: [
                    Tab(
                      child: Text("Requsters"),
                    ),
                    Tab(
                      child: Text("Accepted"),
                    ),
                    Tab(
                      child: Text("My Requests"),
                    ),
                  ]))
            ];
          },
          body: const TabBarView(
            children: [
              ListViewRequsters(),
              ListViewAccepted(),
              MyRequestWait()
            ],
          ),
        ),
      ),
    );
  }
}
