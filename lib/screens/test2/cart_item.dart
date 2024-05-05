
import 'package:flutter/material.dart';
import 'package:disaster_management/common/productcartvertical.dart';
import 'package:disaster_management/screens/homescreens/widget/homewidget.dart';
import 'package:disaster_management/utils/constants/colors.dart';
import 'package:disaster_management/utils/constants/image_strings.dart';
import 'package:disaster_management/utils/constants/sizes.dart';
import 'package:disaster_management/utils/helpers/helper_functions.dart';

class TCardItem extends StatelessWidget {
  const TCardItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TRoundedImage(
          imageUrl: TImages.productImage1,
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(TSizes.sm),
          backgroundColor:
              THelperFunctions.isDarkMode(context)
                  ? TColors.darkerGrey
                  : TColors.light,
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const TBRandTitleWithVerificationICon(title: 'Nike'),
              const Flexible(
                  child: TBrandTitleText(
                title: 'Black Sports Shoes',
                maxLines: 1,
              )),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: 'Color ',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall),
                TextSpan(
                    text: 'Green ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge),
                TextSpan(
                    text: 'Size ',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall),
                TextSpan(
                    text: 'UK ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge),
              ]))
            ],
          ),
        )
      ],
    );
  }
}
