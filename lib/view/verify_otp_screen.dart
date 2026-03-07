import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:smar_campus_management_system/controller/verify_otp_screen_controller.dart';
import 'package:smar_campus_management_system/core/constant/app_color.dart';

class VerifyOtpScreen extends StatelessWidget {
  final String email;

  VerifyOtpScreen({super.key, required this.email});

  late final VerifyOtpScreenController controller = Get.put(VerifyOtpScreenController(email: email));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              color: AppColor.white,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: (){
                         controller.goBack();
                        },
                        child: Icon(Icons.arrow_back,color: AppColor.subHeading,),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.lightBlue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Icon(
                          Icons.mark_email_read_outlined,
                          color: AppColor.blue,
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text(
                      'Verify your email',
                      style: TextStyle(
                        color: AppColor.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),

                    SizedBox(height: 10),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'We have sent a 6 digit verification code to ',
                        style: TextStyle(
                          color: AppColor.subHeading,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: email,
                            style: TextStyle(
                              color: AppColor.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    Pinput(
                      length: 6,
                      keyboardType: TextInputType.number,
                      onCompleted: (pin) {
                        print(pin);
                        controller.verifyOtp(pin.toString());
                      },
                    ),

                    SizedBox(height: 30),

                    Text(
                      "Didn't receive a code?",
                      style: TextStyle(
                        color: AppColor.subHeading,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),

                    SizedBox(height: 10),

                    Obx(()=>Text(
                      'Resend in 00:${controller.resendOtpTimer.value.toString()}',
                      style: TextStyle(
                        color: AppColor.subHeading,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: (){
                        controller.validForResendCode.value?controller.resendOtp():null;
                      },
                      child: Obx(()=>Text(
                        'Resend Code',
                        style: TextStyle(
                          color: controller.validForResendCode.value?AppColor.blue:AppColor.subHeading,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      )),
                    ),


                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
