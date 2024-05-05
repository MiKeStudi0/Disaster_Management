import 'package:flutter/material.dart';
import 'package:disaster_management/common/appbar.dart';
import 'package:disaster_management/screens/test/widgets/progress_indicator.dart';
import 'package:disaster_management/screens/test/widgets/user_review_card.dart';
import 'package:disaster_management/utils/constants/sizes.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const TAppBar(
      
        title: Text("Reviews and Ratings",),
        showbackarrow: false,
      ),

      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Rating and reivews are verified and are from people who have bought this product."),
            const SizedBox(height: TSizes.spaceBtwItems,),
           ////
           
          const  TOverallProductRating(),
          const  TRatingBarIndicator( rating: 3.5,),
          Text("12,213" , style: Theme.of(context).textTheme.bodySmall,),
          const SizedBox(height: TSizes.spaceBtwSections,),
          const UserReviewCard(),
          const UserReviewCard(),
          ],
        ),),
      ),
    );
  }
}

