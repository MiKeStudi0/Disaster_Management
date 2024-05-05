import 'package:flutter/material.dart';
import 'package:disaster_management/common/style/product_price.dart';
import 'package:disaster_management/common/style/product_title_text.dart';
import 'package:disaster_management/screens/homescreens/widget/homewidget.dart';
import 'package:disaster_management/screens/test/widgets/choicechip.dart';
import 'package:disaster_management/utils/constants/colors.dart';
import 'package:disaster_management/utils/constants/sizes.dart';
import 'package:disaster_management/utils/helpers/helper_functions.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        TRoundedContainer(
          backgroundColor: dark ? TColors.darkGrey : TColors.grey,
          child: Padding(
            padding: const EdgeInsets.all(TSizes.md),
            child: Column(
              children: [
                Row(
                  children: [
                    const TSectionHeading(
                      title: "Variation",
                      showActionButton: false,
                    ),
                    const SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const TProductTitleText(
                              title: 'Price : ',
                              smallSize: true,
                            ),
                            Text(
                              "\$25",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .apply(
                                      decoration: TextDecoration.lineThrough),
                            ),
                            const SizedBox(
                              width: TSizes.spaceBtwItems,
                            ),
                            const TProductPRice(price: 876),
                          ],
                        ),
                        Row(
                          children: [
                            const TProductTitleText(
                              title: 'Stock :',
                              smallSize: true,
                            ),
                            const SizedBox(
                              width: TSizes.spaceBtwItems,
                            ),
                            Text('In Stock',
                                style: Theme.of(context).textTheme.titleMedium)
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                const TProductTitleText(
                  title:
                      "This is the Description of the product adn it can be long or short based on the product and the seller",
                  smallSize: true,
                  maxLines: 4,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
         Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: 'Colors', showActionButton: false),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
           const SizedBox(height: TSizes.spaceBtwItems / 2),
Wrap(
  spacing: 8,
  children: [
                TChoiceChip(text: 'Green', selected: true , onSelected: (value){}),
            TChoiceChip(text: 'Blue', selected: false,onSelected: (value){}),
            TChoiceChip(text: 'Yellow', selected: false,onSelected: (value){}),
  ],
)
          ],
        ),
         Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: 'Size', showActionButton: false),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),

            Wrap(
              spacing: 8,
              children: [
                  TChoiceChip(text: 'EU 34', selected: true,onSelected: (value){}),
            TChoiceChip(text: 'EU 36', selected: false,onSelected: (value){}),
            TChoiceChip(text: 'EU 38', selected: false,onSelected: (value){}),
              ],
            )
          
          ],
        )
      ],
    );
  }
}
