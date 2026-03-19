import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:CampusX/core/constant/app_color.dart';

import '../controller/signup_screen_controller.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final SignupScreenController controller = Get.put(SignupScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Text(
          'University Portal',
          style: TextStyle(color: AppColor.black, fontWeight: FontWeight.w500),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Image.asset(
              'assets/images/signup_screen.png',
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.14,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Create Student Account',
              style: TextStyle(
                color: AppColor.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 7),
            Text(
              'Enter your details to access the smartt campus services',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.black,
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Full Name',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColor.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(height: 5),
                      Obx(
                        () => TextField(
                          controller: controller.nameController,
                          cursorColor: AppColor.black,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hint: Text(
                              'John Doe',
                              style: TextStyle(color: AppColor.subHeading),
                            ),
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: AppColor.subHeading,
                            ),
                            fillColor: AppColor.white,
                            filled: true,
                            isDense: true,
                            errorText: controller.nameError.value.isEmpty
                                ? null
                                : controller.nameError.value,

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: AppColor.outline),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: AppColor.outline),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: AppColor.outline),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Email',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColor.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),

                      Obx(
                        () => TextField(
                          controller: controller.emailController,
                          cursorColor: AppColor.black,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hint: Text(
                              'example@uos.edu.pk',
                              style: TextStyle(color: AppColor.subHeading),
                            ),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: AppColor.subHeading,
                            ),
                            fillColor: AppColor.white,
                            filled: true,
                            isDense: true,

                            errorText: controller.emailError.value.isEmpty
                                ? null
                                : controller.emailError.value,

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: AppColor.outline),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: AppColor.outline),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: AppColor.outline),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Password',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColor.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Obx(
                        () => TextField(
                          controller: controller.passwordController,
                          cursorColor: AppColor.black,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !controller.showPassword.value,
                          decoration: InputDecoration(
                            hint: Text(
                              '******',
                              style: TextStyle(color: AppColor.subHeading),
                            ),
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: AppColor.subHeading,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.showPassword.value =
                                    !controller.showPassword.value;
                              },
                              icon: controller.showPassword.value
                                  ? Icon(
                                      Icons.visibility_off_outlined,
                                      color: AppColor.subHeading,
                                    )
                                  : Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: AppColor.subHeading,
                                    ),
                            ),
                            fillColor: AppColor.white,
                            filled: true,
                            isDense: true,
                            errorText: controller.passwordError.value.isEmpty
                                ? null
                                : controller.passwordError.value,

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: AppColor.outline),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: AppColor.outline),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: AppColor.outline),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Confirm Password',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColor.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Obx(
                        () => TextField(
                          controller: controller.confirmPasswordController,
                          cursorColor: AppColor.black,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !controller.showConfirmPassword.value,
                          decoration: InputDecoration(
                            hint: Text(
                              '******',
                              style: TextStyle(color: AppColor.subHeading),
                            ),
                            prefixIcon: Icon(
                              Icons.lock_reset_outlined,
                              color: AppColor.subHeading,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.showConfirmPassword.value =
                                    !controller.showConfirmPassword.value;
                              },
                              icon: controller.showConfirmPassword.value
                                  ? Icon(
                                      Icons.visibility_off_outlined,
                                      color: AppColor.subHeading,
                                    )
                                  : Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: AppColor.subHeading,
                                    ),
                            ),
                            fillColor: AppColor.white,
                            filled: true,
                            isDense: true,

                            errorText:
                                controller.confirmPasswordError.value.isEmpty
                                ? null
                                : controller.confirmPasswordError.value,

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: AppColor.outline),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: AppColor.outline),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: AppColor.outline),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      SizedBox(
                        height: 60,
                        child: Obx(
                          () => Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    controller.selectedRole.value = "Teacher";
                                  },
                                  child: Card(
                                    elevation: 2,
                                    shadowColor:
                                        controller.selectedRole.value ==
                                            "Teacher"
                                        ? AppColor.blue
                                        : null,
                                    color: AppColor.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(15),
                                      side: BorderSide(
                                        color:
                                            controller.selectedRole.value ==
                                                "Teacher"
                                            ? AppColor.blue
                                            : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Teacher',
                                        style: TextStyle(
                                          color:
                                              controller.selectedRole.value ==
                                                  "Teacher"
                                              ? AppColor.blue
                                              : null,
                                          fontWeight:
                                              controller.selectedRole.value ==
                                                  "Teacher"
                                              ? FontWeight.bold
                                              : FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),

                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    controller.selectedRole.value = "Student";
                                  },
                                  child: Card(
                                    elevation: 2,
                                    shadowColor:
                                        controller.selectedRole.value ==
                                            "Student"
                                        ? AppColor.blue
                                        : null,
                                    color: AppColor.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(15),
                                      side: BorderSide(
                                        color:
                                            controller.selectedRole.value ==
                                                "Student"
                                            ? AppColor.blue
                                            : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Student',
                                        style: TextStyle(
                                          color:
                                              controller.selectedRole.value ==
                                                  "Student"
                                              ? AppColor.blue
                                              : null,
                                          fontWeight:
                                              controller.selectedRole.value ==
                                                  "Student"
                                              ? FontWeight.bold
                                              : FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 10),
                      Row(
                        children: [
                          Obx(
                            () => Checkbox(
                              value: controller.isConditionsChecked.value,
                              onChanged: (bool? value) {
                                controller.isConditionsChecked.value = value!;
                              },
                              activeColor: AppColor.blue,
                              checkColor: AppColor.white,
                            ),
                          ),

                          RichText(
                            text: TextSpan(
                              text: 'I agree to the ',
                              style: TextStyle(
                                color: AppColor.subHeading,
                                fontSize: 13,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Terms of Service ',
                                  style: TextStyle(
                                    color: AppColor.blue,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                                TextSpan(text: 'and '),
                                TextSpan(
                                  text: 'Privacy policy. ',
                                  style: TextStyle(
                                    color: AppColor.blue,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: Obx(()=>ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(15),
                            backgroundColor: AppColor.blue,
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23),
                            ),
                          ),
                          onPressed: () {
                            controller.isLoading.value?null:controller.validateInput();
                          },

                          child: controller.isLoading.value
                              ? CircularProgressIndicator(color: AppColor.white)
                              : Text(
                            'Send Otp',
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                      ),

                      SizedBox(height: 15),

                      RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(
                            color: AppColor.subHeading,
                            fontSize: 13,
                          ),
                          children: [
                            TextSpan(
                              text: 'Log in',
                              style: TextStyle(
                                color: AppColor.blue,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  controller.goToLoginScreen();
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
