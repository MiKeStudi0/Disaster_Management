import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:disaster_management/common/appbar.dart';
import 'package:disaster_management/common/productcartvertical.dart';
import 'package:disaster_management/common/shapes/TGrid_Layout.dart';
import 'package:disaster_management/common/shapes/t_circular_icon.dart';
import 'package:disaster_management/screens/homescreens/homescreen.dart';
import 'package:disaster_management/utils/constants/sizes.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          TCircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to( const HomeScreen()),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
       child: Column(
        children: [
          TGridLayout(itemCount: 6, itemBuilder:  (_,index)=> const TProductCartVertical()),
        ],
       ),
       
        ),
      ),
    );
  }
}
