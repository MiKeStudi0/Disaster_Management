import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:disaster_management/common/style/section_heading.dart';
import 'package:disaster_management/screens/test/widgets/bottom_add_cart.dart';
import 'package:disaster_management/screens/test/widgets/product_attribute.dart';

import 'package:disaster_management/screens/test/widgets/product_metadata.dart';
import 'package:disaster_management/screens/test/widgets/product_reviews.dart';
import 'package:disaster_management/screens/test/widgets/rating_and_share.dart';
import 'package:disaster_management/utils/constants/sizes.dart';
import 'package:readmore/readmore.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  const TBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // const TImageProductSlider(),
            Padding(
              padding: const EdgeInsets.only(
                  right: TSizes.defaultSpace,
                  left: TSizes.defaultSpace,
                  bottom: TSizes.defaultSpace),
              child: Column(
                children: [
                  const TRatingAndShare(),
                  const TProductMetaData(),
                  const TProductAttributes(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text("Checkout"))),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  const TSectionHeading(
                    title: 'Description',
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

               const   ReadMoreText( 
                    'This is product description  for blue sleeve less vest. there are more things that can be added'
                  ,
                  trimMode: TrimMode.Line,
                  trimLines: 2,
                  trimCollapsedText: 'Show More',
                  trimExpandedText: 'Show Less',
                  moreStyle:  TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    
                  ),
                   lessStyle:  TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    
                  ),
                  ),
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TSectionHeading(title: 'Reviews(38)',showActionButton: false,),
                      IconButton(onPressed: ()=> Get.to(()=>const ProductReviewsScreen()), icon: const Icon(Iconsax.arrow_right,size: 18,)),

                    ],
                  ),
const SizedBox( height: TSizes.spaceBtwSections,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
