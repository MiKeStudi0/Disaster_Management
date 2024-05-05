import 'package:disaster_management/common/shimmer_effect.dart';
import 'package:disaster_management/screens/donor/textblock.dart';
import 'package:disaster_management/screens/homescreens/widget/homewidget.dart';
import 'package:disaster_management/screens/receiver_screen/receiver_controller.dart';
import 'package:disaster_management/utils/constants/image_strings.dart';
import 'package:disaster_management/utils/constants/sizes.dart';
import 'package:disaster_management/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class MyRequestWait extends StatelessWidget {
  const MyRequestWait({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
        final RequestController controller = Get.put(RequestController());

    return Scaffold(
      body: Padding(
                padding: const EdgeInsets.all(16.0),
      
                child: Obx(() {
                  if (controller.isLoading.value) {
                    // Return a loading indicator if data is still loading
                    return const Center(
                      child: TshimmerEffect(
                        height: 260,
                        width: double.infinity,
                      ),
                    );
                  } else {
                    return ListView.separated(
                        separatorBuilder: (_, __) => const SizedBox(
                              height: TSizes.spaceBtwItems,
                            ),
                        itemCount: controller.userDataList4
                            .where((userData4) => (userData4['bloodGroup'] != 'Nill'))
                            .length,
                        itemBuilder: (_, index) {
                          // Filtered userDataList excluding items with blood group 'Nill'
                          final filtereduserDataList4 = controller.userDataList4
                              .where((userData4) => (userData4['bloodGroup'] != 'Nill'))
                              .toList();
                    
                          final bloodGroup =
                              controller.userDataList4[index]['bloodGroup'] ?? '';
                          final userID = controller.userDataList4[index]['RequesterID'] ?? '';
                    
                          String letter = '';
                          String sign = '';
                          if (bloodGroup.isNotEmpty) {
                            letter = bloodGroup.substring(0, bloodGroup.length - 1);
                            sign = bloodGroup.substring(bloodGroup.length - 1);
                          }
                    
                          final userData4 = filtereduserDataList4[index];
                          final imageURl = userData4['ProfilePicture'] == ''
                              ? TImages.user
                              : userData4['ProfilePicture'];
                    
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFF868484)),
                                borderRadius: BorderRadius.circular(10.0),
                                color: const Color(0xFFFFFFFF),
                              ),
                              height: 260,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(height: 16.0),
                                  Row(
                                    children: [
                                      const SizedBox(width: 16.0),
                                      TRoundedImage(
                                        isNetworkImage:
                                            userData4['ProfilePicture'] != '',
                                        imageUrl: imageURl,
                                        height: 50,
                                        width: 50,
                                        borderRadius: 50,
                                      ),
                                      const SizedBox(width: 16.0),
                                      Text(
                                        '${userData4["FirstName"]} ${userData4["LastName"]}',
                                        style: GoogleFonts.lexend(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18.0,
                                          color: const Color(0xFF490008),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 16.0, right: 16),
                                    child: Stack(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10.0),
                                                  color: const Color.fromRGBO(
                                                      255, 218, 218, 1),
                                                ),
                                                height: 90,
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                    children: [
                                                      Stack(
                                                        alignment: Alignment.center,
                                                        children: [
                                                          Text(
                                                            letter,
                                                            style: GoogleFonts.lexend(
                                                              fontWeight:
                                                                  FontWeight.w700,
                                                              fontSize: 30.0,
                                                              color: const Color(
                                                                  0xFFD9214B),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            top: -14.0,
                                                            right: -1,
                                                            child: Text(
                                                              sign,
                                                              style: GoogleFonts.lexend(
                                                                fontWeight:
                                                                    FontWeight.w700,
                                                                fontSize: 24.0,
                                                                color: const Color(
                                                                    0xFFD9214B),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(width: 16.0),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            'Eligibility:',
                                                            style: GoogleFonts.lexend(
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                              fontSize: 9.0,
                                                              color: const Color(
                                                                  0xFF868484),
                                                            ),
                                                          ),
                                                          const SizedBox(height: 4.0),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets.all(
                                                                    4.0),
                                                            decoration: BoxDecoration(
                                                              color: const Color(
                                                                  0xFF32D418),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      3.0),
                                                            ),
                                                            child: Text(
                                                              'Eligible',
                                                              style: GoogleFonts.lexend(
                                                                fontWeight:
                                                                    FontWeight.w400,
                                                                fontSize: 9.0,
                                                                color: const Color(
                                                                    0xCCFFFFFF),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: TSizes.md),
                                            Expanded(
                                              flex: 3,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextBlock(
                                                    title:
                                                        "${userData4['Gender']} (${userData4['Age']} Age) " ??
                                                            'Nill',
                                                    icons: Iconsax.user,
                                                  ),
                                                  const SizedBox(height: 8.0),
                                                  TextBlock(
                                                      title: "${userData4['Street']}",
                                                      icons: Iconsax.location_add),
                                                  const SizedBox(height: 8.0),
                                                  TextBlock(
                                                      title: userData4['City'],
                                                      icons: Iconsax.location),
                                                  const SizedBox(height: 8.0),
                                                  TextBlock(
                                                      title: userData4['PhoneNumber'] ??
                                                          'Nill',
                                                      icons: Iconsax.call_add)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Positioned(
                                            top: 5,
                                            left: -3,
                                            child: SizedBox(
                                                height: 30,
                                                width: 30,
                                                child: Image.asset(
                                                    'assets/images/content/blood.png'))),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 1),
                                  const Divider(),
                                  Row(
                                    children: [
                                      const SizedBox(width: TSizes.sm),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () async {
                        // Call the deleteRequest method and pass the userID of the request to be deleted
                        await controller.deletewaiting(userID);
                        // Since the state has changed, the UI will automatically update
                      },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5.0),
                                              border: Border.all(
                                                  color: const Color(0xFF868484)),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                    Iconsax.arrow_swap_horizontal,
                                                    color: Colors.red),
                                                const SizedBox(width: 8.0),
                                                Text(
                                                  'Cancel Request',
                                                  style: GoogleFonts.lexend(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15.0,
                                                    color: const Color(0xFF868484),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8.0),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () async {
                                           
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5.0),
                                              color: const Color.fromARGB(255, 251, 21, 21),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(Iconsax.card_send,
                                                    color: Colors.white),
                                                const SizedBox(width: 8.0),
                                                Text(
                                                  'Waiting...',
                                                  style: GoogleFonts.lexend(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15.0,
                                                    color: dark
                                                        ? const Color(0xFFFFFFFF)
                                                        : const Color(0xFFFFFFFF),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: TSizes.sm),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                }),
              ),
    );
  }
}