import 'package:disaster_management/authservices/authenticate.dart';
import 'package:disaster_management/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:disaster_management/screens/settings/settings.dart';
import 'package:disaster_management/utils/constants/colors.dart';
import 'package:disaster_management/utils/helpers/helper_functions.dart';

class NavigationbarScreen extends StatefulWidget {
  const NavigationbarScreen({super.key});

  @override
  State<NavigationbarScreen> createState() => _NavigationbarScreenState();
}

class _NavigationbarScreenState extends State<NavigationbarScreen> {
  final controller = Get.put(NavigationbarController());
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
            height: 80,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            backgroundColor: dark ? TColors.black : Colors.white,
            indicatorColor: dark
                ? TColors.white.withOpacity(0.1)
                : TColors.black.withOpacity(0.1),
            destinations: const [
              NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
              NavigationDestination(icon: Icon(Iconsax.additem), label: 'Donors'),
              NavigationDestination(
                  icon: Icon(Iconsax.receipt), label: 'Request'),
              NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
            ]),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationbarController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const AuthPage(),
    const AuthPage(),
    const HomeScreen(),

    const SettingsScreen()
  ];
}
