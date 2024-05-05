import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:disaster_management/common/productcartvertical.dart';
import 'package:disaster_management/common/shimmer_effect.dart';

import 'package:disaster_management/screens/homescreens/widget/homewidget.dart';
import 'package:disaster_management/utils/constants/colors.dart';
import 'package:disaster_management/utils/constants/enums.dart';
import 'package:disaster_management/utils/constants/image_strings.dart';
import 'package:disaster_management/utils/constants/sizes.dart';
import 'package:disaster_management/utils/helpers/helper_functions.dart';




Widget brandTopProductImageWidget(String image,context) {
  return Expanded(
    child: TRoundedContainer(
      height: 100,
      padding: const EdgeInsets.all(TSizes.md),
      margin:  const EdgeInsets.only( right: TSizes.sm),
      backgroundColor: THelperFunctions.isDarkMode(context)? TColors.darkerGrey : TColors.light,
      child:  Image(
        fit: BoxFit.contain,
        image: AssetImage(image)),
    ),
  );

}

class TBrandShowCase extends StatelessWidget {
  const TBrandShowCase({
    super.key, required this.images,
  });

final List<String>  images;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.md),
      showBorder: true,
      borderColor: TColors.darkGrey,
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      child: Column(
           children: [
             const TBrandCard(showBorder: false),

              const SizedBox(height: TSizes.spaceBtwItems),
             Row(
              children: images.map((image) => brandTopProductImageWidget(image, context)).toList()
             )
           ],
      ),
    );
  }
}

class TBrandCard extends StatelessWidget {
  const TBrandCard({
    super.key, required this.showBorder, this.onTap,
  });

final bool showBorder;
final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
        padding: const EdgeInsets.all(TSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            Flexible(
              child: TCircularImage(
                isNetworkImage: false,
                image: TImages.clothIcon,
                backgroundColor: Colors.transparent,
                overlayColor:
                    THelperFunctions.isDarkMode(
                            context)
                        ? TColors.white
                        : TColors.dark,
              ),
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems / 2,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const TBRandTitleWithVerificationICon(
                    title: "Mango",
                    brandTextSize: TextSizes.large,
                  ),
                  Text("256 Product with asjb",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .apply(
                            color: THelperFunctions
                                    .isDarkMode(
                                        context)
                                ? TColors.white
                                : TColors.dark,
                          ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TCircularImage extends StatelessWidget {
  const TCircularImage({
    super.key,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
    this.height = 56,
    this.width = 56,
    this.padding = TSizes.sm,
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double height, width, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color:
            THelperFunctions.isDarkMode(context) ? TColors.dark : TColors.light,
        borderRadius: BorderRadius.circular(100),
      ),
      child:ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Center(
        child:   isNetworkImage?
          CachedNetworkImage(imageUrl: image,fit: fit,
          color: overlayColor,
          progressIndicatorBuilder: (context,url,downloadProgress) => const TshimmerEffect(height: 55, width: 55),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          ):
         Image(
            fit: fit,
            image: isNetworkImage
                ? NetworkImage(image)
                : AssetImage(image) as ImageProvider,
            color: overlayColor),
             ),
      ) );
  }
}
