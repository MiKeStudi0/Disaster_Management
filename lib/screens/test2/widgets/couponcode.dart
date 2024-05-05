import 'package:flutter/material.dart';
import 'package:disaster_management/screens/homescreens/widget/homewidget.dart';
import 'package:disaster_management/utils/constants/colors.dart';
import 'package:disaster_management/utils/constants/sizes.dart';
import 'package:disaster_management/utils/helpers/helper_functions.dart';


class TCouponCode extends StatelessWidget {
  const TCouponCode({
    super.key,
    
  });


  @override
  Widget build(BuildContext context) {
        final dark = THelperFunctions.isDarkMode(context);

    return TRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? TColors.dark : TColors.white,
      padding: const EdgeInsets.only(
        left: TSizes.sm,
        right: TSizes.sm,
        top: TSizes.sm,
        bottom: TSizes.sm,
      ),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: "Have a Promo code? Enter Here",
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder:  InputBorder.none
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: dark? TColors.white.withOpacity(0.9): TColors.dark.withOpacity(0.5),
                backgroundColor: TColors.grey.withOpacity(0.1)
                ,side: BorderSide( color: Colors.grey.withOpacity(0.1))
              ),
    
              onPressed: (){}, child: const Text('Apply'),
              )
              ,
              )
        ],
      ),
    );
  }
}
