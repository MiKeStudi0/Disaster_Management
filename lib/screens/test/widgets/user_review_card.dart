import 'package:flutter/material.dart';
import 'package:disaster_management/screens/homescreens/widget/homewidget.dart';
import 'package:disaster_management/screens/test/widgets/progress_indicator.dart';
import 'package:disaster_management/utils/constants/colors.dart';
import 'package:disaster_management/utils/constants/image_strings.dart';
import 'package:disaster_management/utils/constants/sizes.dart';
import 'package:disaster_management/utils/helpers/helper_functions.dart';
import 'package:readmore/readmore.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                    backgroundImage: AssetImage(TImages.userProfileImage1)),
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Text("Mike", style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert))
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        Row(
          children: [
            const TRatingBarIndicator(rating: 4),

            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text( "10 Nov ,2021", style: Theme.of(context).textTheme.bodyMedium),
           
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
         const ReadMoreText("The user interface is very good and the product is also very good. I am very happy with the product and the service. The user interface is very good and the product is also very good. I am very happy with the product and the service. The user interface is very good and the product is also very good. I am very happy with the product and the service.",
              trimLines: 2,
              
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Show less',
              
              moreStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,color: TColors.primary
              ),
              lessStyle:    TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,color: TColors.primary
              ),
            ),

            const SizedBox( height: TSizes.spaceBtwItems,),
            TRoundedContainer(
              backgroundColor: dark? TColors.darkerGrey:TColors.grey,
              child: Padding(padding: 
              const EdgeInsets.all(TSizes.md),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
Text("Mike",style: Theme.of(context).textTheme.bodyLarge,),
Text("12 Nov 2023",style: Theme.of(context).textTheme.bodyMedium,)

                    ],
                  ),
                       const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
         const ReadMoreText("The user interface is very good and the product is also very good. I am very happy with the product and the service. The user interface is very good and the product is also very good. I am very happy with the product and the service. The user interface is very good and the product is also very good. I am very happy with the product and the service.",
              trimLines: 2,
              
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Show less',
              
              moreStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,color: TColors.primary
              ),
              lessStyle:    TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,color: TColors.primary
              ),
            ),

                ],
              ),
              ),

            ),
            const SizedBox( height: TSizes.spaceBtwSections,),

      ],
    );
  }
}
