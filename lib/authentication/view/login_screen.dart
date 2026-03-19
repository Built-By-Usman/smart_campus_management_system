import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:CampusX/core/constant/app_color.dart';

import '../controller/login_screen_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginScreenController controller = Get.put(LoginScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: AppColor.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          children: [
                            Image.asset(
                              'assets/images/login_screen.png',
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.17,
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              top: MediaQuery.of(context).size.height * 0.04,
                              child: Column(
                                children: [
                                  SvgPicture.asset('assets/icons/logo.svg'),
                                  SizedBox(height: 10),
                                  Text(
                                    'smartt Campus',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: AppColor.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'University Digital Gateway',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: AppColor.white,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 30,
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Welcome Back',
                                style: TextStyle(
                                  color: AppColor.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Sign in to access your student dashboard',
                                style: TextStyle(
                                  color: AppColor.subHeading,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12,
                                ),
                              ),

                              SizedBox(height: 20),

                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Email',
                                  style: TextStyle(
                                    color: AppColor.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              SizedBox(height: 5),
                              Obx(()=>TextField(
                                controller: controller.emailController,
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: AppColor.black,
                                decoration: InputDecoration(
                                  errorText: controller.emailError.value.isNotEmpty?controller.emailError.value:null,
                                  hintText: 'builtbyusman@gmail.com',
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: AppColor.subHeading,
                                  ),
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: AppColor.subHeading,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: AppColor.outline,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: AppColor.outline,
                                    ),
                                  ),
                                ),
                              ),),

                              SizedBox(height: 20),

                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Password',
                                  style: TextStyle(
                                    color: AppColor.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              SizedBox(height: 5),
                              Obx(()=>TextField(
                                controller: controller.passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: !controller.showPassword.value,
                                cursorColor: AppColor.black,
                                decoration: InputDecoration(
                                  errorText: controller.passwordError.value.isNotEmpty?controller.passwordError.value:null,
                                  hintText: '*******',
                                  suffixIcon: IconButton(onPressed: (){
                                    controller.showPassword.value = !controller.showPassword.value;
                                  }, icon: controller.showPassword.value?Icon(Icons.visibility_off_outlined):Icon(Icons.remove_red_eye_outlined)),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: AppColor.subHeading,
                                  ),
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: AppColor.outline,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: AppColor.outline,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: AppColor.outline,
                                    ),
                                  ),
                                ),
                              ),),

                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Obx(
                                    () => Checkbox(
                                      value: controller.rememberMe.value,
                                      onChanged: (bool? value) {
                                        controller.rememberMe.value = value!;
                                      },
                                      activeColor: AppColor.blue,
                                      checkColor: AppColor.white,
                                    ),
                                  ),
                                  Text(
                                    'Remember device',
                                    style: TextStyle(
                                      color: AppColor.subHeading,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),

                              // InkWell(
                              //   onTap: () {
                              //     controller.changeRole('Admin');
                              //   },
                              //   child: SizedBox(
                              //     width: double.infinity,
                              //     child: Obx(
                              //       () => Card(
                              //         shape: RoundedRectangleBorder(
                              //           borderRadius:
                              //               BorderRadiusGeometry.circular(15),
                              //           side: BorderSide(
                              //             color:
                              //                 controller.selectedRole.value ==
                              //                     'Admin'
                              //                 ? AppColor.blue
                              //                 : Colors.transparent,
                              //             width: 2,
                              //           ),
                              //         ),
                              //         elevation: 2,
                              //         shadowColor:
                              //             controller.selectedRole.value ==
                              //                 'Admin'
                              //             ? AppColor.blue
                              //             : AppColor.subHeading,
                              //         color: AppColor.white,
                              //         child: Padding(
                              //           padding: const EdgeInsets.symmetric(
                              //             vertical: 16,
                              //           ),
                              //           child: Center(
                              //             child: Text(
                              //               'Admin',
                              //               style: TextStyle(
                              //                 color:
                              //                     controller
                              //                             .selectedRole
                              //                             .value ==
                              //                         "Admin"
                              //                     ? AppColor.blue
                              //                     : AppColor.subHeading,
                              //                 fontWeight:
                              //                     controller
                              //                             .selectedRole
                              //                             .value ==
                              //                         "Admin"
                              //                     ? FontWeight.bold
                              //                     : FontWeight.w500,
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              //
                              // SizedBox(height: 5),
                              //
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       child: InkWell(
                              //         onTap: () {
                              //           controller.changeRole('Teacher');
                              //         },
                              //         child: SizedBox(
                              //           width: double.infinity,
                              //           child: Obx(
                              //             () => Card(
                              //               shape: RoundedRectangleBorder(
                              //                 borderRadius:
                              //                     BorderRadiusGeometry.circular(
                              //                       15,
                              //                     ),
                              //                 side: BorderSide(
                              //                   color:
                              //                       controller
                              //                               .selectedRole
                              //                               .value ==
                              //                           'Teacher'
                              //                       ? AppColor.blue
                              //                       : Colors.transparent,
                              //                   width: 2,
                              //                 ),
                              //               ),
                              //               elevation: 2,
                              //               shadowColor:
                              //                   controller.selectedRole.value ==
                              //                       'Teacher'
                              //                   ? AppColor.blue
                              //                   : AppColor.subHeading,
                              //               color: AppColor.white,
                              //               child: Padding(
                              //                 padding:
                              //                     const EdgeInsets.symmetric(
                              //                       vertical: 16,
                              //                     ),
                              //                 child: Center(
                              //                   child: Text(
                              //                     'Teacher',
                              //                     style: TextStyle(
                              //                       color:
                              //                           controller
                              //                                   .selectedRole
                              //                                   .value ==
                              //                               "Teacher"
                              //                           ? AppColor.blue
                              //                           : AppColor.subHeading,
                              //                       fontWeight:
                              //                           controller
                              //                                   .selectedRole
                              //                                   .value ==
                              //                               "Teacher"
                              //                           ? FontWeight.bold
                              //                           : FontWeight.w500,
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //
                              //     SizedBox(width: 10),
                              //
                              //     Expanded(
                              //       child: InkWell(
                              //         onTap: () {
                              //           controller.changeRole('Student');
                              //         },
                              //         child: SizedBox(
                              //           width: double.infinity,
                              //           child: Obx(
                              //             () => Card(
                              //               shape: RoundedRectangleBorder(
                              //                 borderRadius:
                              //                     BorderRadiusGeometry.circular(
                              //                       15,
                              //                     ),
                              //                 side: BorderSide(
                              //                   color:
                              //                       controller
                              //                               .selectedRole
                              //                               .value ==
                              //                           'Student'
                              //                       ? AppColor.blue
                              //                       : Colors.transparent,
                              //                   width: 2,
                              //                 ),
                              //               ),
                              //               elevation: 2,
                              //               shadowColor:
                              //                   controller.selectedRole.value ==
                              //                       'Student'
                              //                   ? AppColor.blue
                              //                   : AppColor.subHeading,
                              //               color: AppColor.white,
                              //               child: Padding(
                              //                 padding:
                              //                     const EdgeInsets.symmetric(
                              //                       vertical: 16,
                              //                     ),
                              //                 child: Center(
                              //                   child: Text(
                              //                     'Student',
                              //                     style: TextStyle(
                              //                       color:
                              //                           controller
                              //                                   .selectedRole
                              //                                   .value ==
                              //                               "Student"
                              //                           ? AppColor.blue
                              //                           : AppColor.subHeading,
                              //                       fontWeight:
                              //                           controller
                              //                                   .selectedRole
                              //                                   .value ==
                              //                               "Student"
                              //                           ? FontWeight.bold
                              //                           : FontWeight.w500,
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),

                              SizedBox(height: 20),

                              SizedBox(
                                width: double.infinity,
                                child: Obx(
                                  () => ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.blue,
                                      padding: EdgeInsets.all(15),
                                      elevation: 6,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(23),
                                      ),
                                    ),

                                    onPressed: () {
                                      controller.isLoading.value?null:controller.validateInput();
                                    },
                                    child: controller.isLoading.value
                                        ? CircularProgressIndicator(
                                            color: AppColor.white,
                                          )
                                        : Text(
                                            'Sign In',
                                            style: TextStyle(
                                              color: AppColor.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),

                              Divider(color: AppColor.lightBlue, thickness: 1),
                              SizedBox(height: 20),
                              RichText(
                                text: TextSpan(
                                  text: "New to the campus? ",
                                  style: TextStyle(
                                    color: AppColor.subHeading,
                                    fontSize: 13,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "Create Account",
                                      style: TextStyle(
                                        color: AppColor.blue,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          controller.goToSignUpScreen();
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: AppColor.footer,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.verified_user_outlined,
                            color: AppColor.subHeading,
                            size: 15,
                          ),
                          Text(
                            'Secure Portal',
                            style: TextStyle(
                              color: AppColor.subHeading,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Icon(
                            Icons.contact_support_outlined,
                            color: AppColor.subHeading,
                            size: 15,
                          ),
                          Text(
                            'IT support',
                            style: TextStyle(
                              color: AppColor.subHeading,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
