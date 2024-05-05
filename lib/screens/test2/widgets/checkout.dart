import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:disaster_management/common/appbar.dart';
import 'package:disaster_management/common/success_screen/sucess_screen.dart';
import 'package:disaster_management/screens/test2/widgets/billing_address_section.dart';
import 'package:disaster_management/screens/test2/widgets/billing_amount_section.dart';
import 'package:disaster_management/screens/test2/widgets/billing_payment_section.dart';
import 'package:disaster_management/screens/test2/widgets/couponcode.dart';
import 'package:disaster_management/screens/test2/widgets/tcard_items.dart';
import 'package:disaster_management/screens/homescreens/widget/homewidget.dart';
import 'package:disaster_management/utils/constants/colors.dart';
import 'package:disaster_management/utils/constants/image_strings.dart';
import 'package:disaster_management/utils/constants/sizes.dart';
import 'package:disaster_management/utils/helpers/helper_functions.dart';
import 'package:disaster_management/widget/navigationbar.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {

        final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        showbackarrow: true,
        title: Text(
          "Checkout",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            const TCardItems(
              showAddRemoveButton: false,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            const TCouponCode(),
            const SizedBox(height: TSizes.spaceBtwSections),
            TRoundedContainer(
              padding: const EdgeInsets.all(TSizes.md),
              showBorder: true,
              backgroundColor: dark ? TColors.black : TColors.white,
           child: const Column(
            children: [
              TBillingAmountSection(),
              SizedBox(height: TSizes.spaceBtwItems),
              Divider(),
              SizedBox(height: TSizes.spaceBtwItems),
              TBillingPaymentSection(),
              SizedBox(height: TSizes.spaceBtwItems),
              TBillingAddressSection()
            ],
           ),
            )
          ],
        ),
      )),
    
    
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(onPressed: ()=> Get.to(()=>  SucessScreen(
          image: TImages.successfulPaymentIcon,
          title: "Payment Successful",
          subTitle: 'Your Item Will be Delivered Soon',
          onPressed: ()=> Get.offAll(()=> const NavigationbarScreen()),
        )), child: const Text("CheckOut 256")),
        
      ) ,
    );
  }
}
