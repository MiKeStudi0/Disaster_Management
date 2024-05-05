import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:disaster_management/common/shimmer_effect.dart';
import 'package:disaster_management/screens/donor/donor_controller.dart';
import 'package:disaster_management/utils/constants/colors.dart';
import 'package:disaster_management/utils/constants/sizes.dart';
import 'package:disaster_management/utils/helpers/helper_functions.dart';
import 'package:disaster_management/utils/constants/image_strings.dart';
import 'package:disaster_management/screens/homescreens/widget/homewidget.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final DonorController controller = Get.put(DonorController());

    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Obx(
        () {
          if (controller.isLoading.value) {
            // Return a loading indicator if data is still loading
            return const Center(
              child: TshimmerEffect(
                height: 180,
                width: 180,
              ),
            );
          } else {
            return ListView.separated(
              separatorBuilder: (_, __) => const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              itemCount: controller.userDataList.length,
              itemBuilder: (_, index) {
                final userData = controller.userDataList[index];
                final imageURl = userData['ProfilePicture']==''?TImages.user:userData['ProfilePicture'];

                return GestureDetector(
                  onTap: () {},
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: dark ? TColors.white : Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              TRoundedImage(
                                isNetworkImage:  userData['ProfilePicture'] != '',
                                imageUrl: imageURl,
                                height: 50,
                                width: 50,
                              ),
                              const SizedBox(width: TSizes.sm),
                              Text(
                                '${userData["FirstName"]} ${userData["LastName"]}',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: dark ? TColors.black : TColors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          _buildInfoRow('Username', userData['UserName'], dark),
                          _buildInfoRow(
                              'Blood Group', userData['bloodGroup'], dark),
                          _buildInfoRow(
                              'Phone Number', userData['phoneNumber'], dark),
                          _buildInfoRow('Street', userData['Street'], dark),
                          _buildInfoRow('City', userData['City'], dark),
                          _buildInfoRow('State', userData['State'], dark),

                          _buildInfoRow('PostalCode', userData['PostalCode'], dark),

                          _buildInfoRow('Email', userData['Email'], dark),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, bool dark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: dark ? TColors.black : TColors.white,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 18,
                color: dark ? TColors.black : TColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
