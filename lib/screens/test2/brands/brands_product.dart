import 'package:flutter/material.dart';
import 'package:disaster_management/common/appbar.dart';
import 'package:disaster_management/common/sortable.dart';
import 'package:disaster_management/screens/request_list_screen/widget/brandshowcase.dart';
import 'package:disaster_management/utils/constants/sizes.dart';

class BrandsProducts extends StatelessWidget {
  const BrandsProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TAppBar(
        title: Text('Brands Product'),
        showbackarrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            TBrandCard(showBorder: true),
            SizedBox(height: TSizes.spaceBtwSections,),
            TSortableProducts(),
          ],
        ),),
      ),
    );
  }
}