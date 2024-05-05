
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:disaster_management/utils/constants/colors.dart';
import 'package:disaster_management/utils/device/device_utility.dart';

class RatingProgressIndicator extends StatelessWidget {
  const RatingProgressIndicator({
    super.key, required this.text, required this.value,
  });

final String text;
final double value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex:1,child:  Text(text, style: Theme.of(context).textTheme.bodyMedium,)),
        Expanded(
          flex: 11,
          child: SizedBox(
            width: TDeviceUtils.getScreenWidth(context) * 0.8,
            child: LinearProgressIndicator(
              
              value: value,
              minHeight: 11,
              backgroundColor: TColors.grey,
              borderRadius: BorderRadius.circular(7),
              valueColor: const AlwaysStoppedAnimation(TColors.primary),
            ),
          ),
        )
      ],
    );
  }
}



class TOverallProductRating extends StatelessWidget {
  const TOverallProductRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
          Expanded(flex:3, child :Text("4.8", style: Theme.of(context).textTheme.displayLarge,)),
       const Expanded(
          flex: 7,
          child: Column(
            children: [
              RatingProgressIndicator(text: "5", value: 1.0,),
              RatingProgressIndicator(text: "4", value: 0.8,),
              RatingProgressIndicator(text: "3", value: 0.6,),
              RatingProgressIndicator(text: "2", value: 0.4,),
              RatingProgressIndicator(text: "1", value: 0.2,),
    
    
            ],
          ),
        ),
      ],
    );
  }
}



class TRatingBarIndicator extends StatelessWidget {
  const TRatingBarIndicator({
    super.key, required this.rating,
  });

  final double rating ;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemSize: 20,
      itemBuilder: (__,_)=> const Icon(Iconsax.star1, color: TColors.primary,),);
  }
}