
import 'package:flutter/material.dart';
import 'package:disaster_management/common/appbar.dart';
import 'package:disaster_management/screens/homescreens/widget/homewidget.dart';
import 'package:disaster_management/utils/constants/colors.dart';
import 'package:disaster_management/utils/constants/sizes.dart';
import 'package:disaster_management/utils/helpers/helper_functions.dart';

class TImageProductSlider extends StatelessWidget {
  const TImageProductSlider({
    super.key, required this.imageUrl,
    
  });

final String imageUrl;

  @override
  Widget build(BuildContext context) {
        final dark = THelperFunctions.isDarkMode(context);

    return TCurvedEdgeWidget(
      child: Container(
        color: dark ? TColors.darkerGrey : TColors.light,
        child: Stack(
          children: [
             SizedBox(
                height: 400,
                child: Padding( 
                  padding:
                     const EdgeInsets.all(TSizes.productImageRadius * 2),
                  child: Center(
                      child: Image(
                          image: NetworkImage(imageUrl))),
                )),
           
    
             const TAppBar(
              showbackarrow: true,
             
       
      )
          ]          
          
        ),
      ),
    );
  }
}

