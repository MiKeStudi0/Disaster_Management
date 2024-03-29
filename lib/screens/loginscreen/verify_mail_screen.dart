import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:disaster_management/core/app_export.dart';
import 'package:disaster_management/widgets/app_bar/appbar_leading_image.dart';
import 'package:disaster_management/widgets/app_bar/appbar_title.dart';
import 'package:disaster_management/widgets/app_bar/custom_app_bar.dart';
import 'package:disaster_management/widgets/custom_icon_button.dart';
import 'package:disaster_management/widgets/custom_pin_code_text_field.dart';
import 'package:flutter/widgets.dart';

class VerifyMailScreen extends StatefulWidget {
  const VerifyMailScreen({Key? key}) : super(key: key);

  @override
  _VerifyMailScreenState createState() => _VerifyMailScreenState();
}

class _VerifyMailScreenState extends State<VerifyMailScreen> {
  late String pinCode;
  EmailOTP myauth = EmailOTP();
  String userEmail = '';
  Future<void> getUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      setState(() {
        userEmail = user.email!;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    pinCode = "";
    getUserEmail();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 34.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 36.v),
              Text(
                "Code has been sent to your mail",
                style: theme.textTheme.titleSmall,
              ),
              SizedBox(height: 38.v),
              CustomPinCodeTextField(
                context: context,
                onChanged: (value) {
                  setState(() {
                    pinCode = value;
                  });
                },
              ),
              SizedBox(height: 51.v),
              GestureDetector(
                onTap: () async {
                  myauth.setConfig(
                      appEmail: "flutteremperor@gmail.com",
                      appName: "Email OTP",
                      userEmail: userEmail,
                      otpLength: 4,
                      otpType: OTPType.digitsOnly);
                  if (await myauth.sendOTP() == true) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("OTP has been sent"),
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Oops, OTP send failed"),
                    ));
                  }
                },
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Resend otp if not recieved in 4 min",
                        style: CustomTextStyles.titleMediumff0961f5,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 51.v),
              GestureDetector(
                  onTap: () async {
                    print(pinCode);
                    if (await myauth.verifyOTP(otp: pinCode) == true) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("OTP is verified"),
                      ));
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.fillYourProfileScreen);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Invalid OTP"),
                      ));
                    }
                  },
                  child: _buildOtpVerification(context)),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 61.h,
      leading: Center(
        child: AppbarLeadingImage(
          onTap: () {
            Navigator.pushReplacementNamed(context, AppRoutes.letSYouInScreen);
          },
          imagePath: ImageConstant.imgArrowDown,
          margin: EdgeInsets.only(
            left: 10.h,
            top: 17.v,
            bottom: 18.v,
          ),
        ),
      ),
      title: AppbarTitle(
        text: "Verify your mail",
        margin: EdgeInsets.only(left: 12.h),
      ),
    );
  }

  /// Section Widget
  Widget _buildOtpVerification(BuildContext context) {
    return SizedBox(
      height: 60.v,
      width: 350.h,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 60.v,
              width: 350.h,
              decoration: BoxDecoration(
                color: appTheme.blueA700,
                borderRadius: BorderRadius.circular(
                  30.h,
                ),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary,
                    spreadRadius: 2.h,
                    blurRadius: 2.h,
                    offset: Offset(
                      1,
                      2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 9.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 11.v,
                      bottom: 9.v,
                    ),
                    child: Text(
                      "Verify",
                      style: CustomTextStyles.titleMediumJostOnError,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 94.h),
                    child: CustomIconButton(
                      height: 48.adaptSize,
                      width: 48.adaptSize,
                      padding: EdgeInsets.all(13.h),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgFill1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
