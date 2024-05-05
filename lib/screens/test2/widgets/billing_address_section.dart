import 'package:flutter/material.dart';
import 'package:disaster_management/common/style/section_heading.dart';
import 'package:disaster_management/utils/constants/sizes.dart';

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(title: 'Shipping Address', showActionButton: true,buttonTitle: 'Change',onPressed: (){},)
        ,
        Text("Coding With Mike",style: Theme.of(context).textTheme.bodyLarge,),
       const SizedBox(height: TSizes.spaceBtwItems /2,),
       
        Row(
          children: [
            const Icon(Icons.phone,color: Colors.grey,size: 16,),
            const SizedBox(width: TSizes.spaceBtwItems,),
            Text("+91 9876543210",style: Theme.of(context).textTheme.bodyMedium,)
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems /2,),
                Row(
          children: [
            const Icon(Icons.location_history,color: Colors.grey,size: 16,),
            const SizedBox(width: TSizes.spaceBtwItems,),
            Expanded(child: Text("South Liana,Maine 9834,USA",style: Theme.of(context).textTheme.bodyMedium,))
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems /2,),
    
      ],
    );
  }
}