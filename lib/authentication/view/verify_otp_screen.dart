import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:CampusX/core/constant/app_color.dart';
import 'package:CampusX/core/constant/app_routes.dart';
import '../provider/verify_otp_provider.dart';

class VerifyOtpScreen extends StatelessWidget {
  final String email;

  const VerifyOtpScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VerifyOtpProvider(email: email)..startTimer(),
      child: const _VerifyOtpView(),
    );
  }
}

class _VerifyOtpView extends StatelessWidget {
  const _VerifyOtpView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VerifyOtpProvider>();

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
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    /// 🔙 Back
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back, color: AppColor.subHeading),
                      ),
                    ),

                    /// 📧 Icon
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.lightBlue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Icon(Icons.mark_email_read_outlined, color: AppColor.blue),
                    ),

                    const SizedBox(height: 15),

                    /// Title
                    Text(
                      'Verify your email',
                      style: TextStyle(
                        color: AppColor.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// Email text
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
                            text: provider.email,
                            style: TextStyle(
                              color: AppColor.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// 🔢 OTP Input
                    Pinput(
                      length: 6,
                      keyboardType: TextInputType.number,
                      onCompleted: (pin) async {
                        final success = await context
                            .read<VerifyOtpProvider>()
                            .verifyOtp(pin);

                        if (success) {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.login);
                        }
                      },
                    ),

                    const SizedBox(height: 30),

                    Text(
                      "Didn't receive a code?",
                      style: TextStyle(
                        color: AppColor.subHeading,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// ⏳ Timer
                    Text(
                      'Resend in 00:${provider.resendOtpTimer}',
                      style: TextStyle(
                        color: AppColor.subHeading,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// 🔁 Resend
                    InkWell(
                      onTap: provider.validForResendCode
                          ? () => context.read<VerifyOtpProvider>().resendOtp()
                          : null,
                      child: Text(
                        'Resend Code',
                        style: TextStyle(
                          color: provider.validForResendCode
                              ? AppColor.blue
                              : AppColor.subHeading,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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