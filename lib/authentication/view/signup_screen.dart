import 'package:CampusX/authentication/provider/signup_provider.dart';
import 'package:CampusX/core/constant/app_routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:CampusX/core/constant/app_color.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signupProvider = Provider.of<SignUpProvider>(context);

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
              'Enter your details to access the smart333 campus services',
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
                          style: TextStyle(
                            color: AppColor.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(height: 5),

                      TextField(
                        controller: signupProvider.nameController,
                        cursorColor: AppColor.black,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: 'John Doe',
                          hintStyle: TextStyle(color: AppColor.subHeading),
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: AppColor.subHeading,
                          ),
                          fillColor: AppColor.white,
                          filled: true,
                          isDense: true,
                          errorText: signupProvider.nameError.isEmpty
                              ? null
                              : signupProvider.nameError,
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

                      SizedBox(height: 10),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Email',
                          style: TextStyle(
                            color: AppColor.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(height: 5),

                      TextField(
                        controller: signupProvider.emailController,
                        cursorColor: AppColor.black,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'example@uos.edu.pk',
                          hintStyle: TextStyle(color: AppColor.subHeading),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: AppColor.subHeading,
                          ),
                          fillColor: AppColor.white,
                          filled: true,
                          isDense: true,
                          errorText: signupProvider.emailError.isEmpty
                              ? null
                              : signupProvider.emailError,
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

                      SizedBox(height: 10),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Password',
                          style: TextStyle(
                            color: AppColor.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(height: 5),

                      TextField(
                        controller: signupProvider.passwordController,
                        obscureText: !signupProvider.showPassword,
                        cursorColor: AppColor.black,
                        decoration: InputDecoration(
                          hintText: '******',
                          hintStyle: TextStyle(color: AppColor.subHeading),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: AppColor.subHeading,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              signupProvider.togglePassword(
                                !signupProvider.showPassword,
                              );
                            },
                            icon: signupProvider.showPassword
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
                          errorText: signupProvider.passwordError.isEmpty
                              ? null
                              : signupProvider.passwordError,
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

                      SizedBox(height: 10),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Confirm Password',
                          style: TextStyle(
                            color: AppColor.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(height: 5),

                      TextField(
                        controller: signupProvider.confirmPasswordController,
                        obscureText: !signupProvider.showConfirmPassword,
                        cursorColor: AppColor.black,
                        decoration: InputDecoration(
                          hintText: '******',
                          hintStyle: TextStyle(color: AppColor.subHeading),
                          prefixIcon: Icon(
                            Icons.lock_reset_outlined,
                            color: AppColor.subHeading,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              signupProvider.toggleConfirmPassword(
                                !signupProvider.showConfirmPassword,
                              );
                            },
                            icon: signupProvider.showConfirmPassword
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
                          errorText: signupProvider.confirmPasswordError.isEmpty
                              ? null
                              : signupProvider.confirmPasswordError,
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

                      SizedBox(height: 10),

                      SizedBox(
                        height: 60,
                        child: Consumer<SignUpProvider>(
                          builder: (context, value, child) {
                            return Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      value.changeRole("Teacher");
                                    },
                                    child: Card(
                                      elevation: 2,
                                      shadowColor:
                                      value.selectedRole == "Teacher"
                                          ? AppColor.blue
                                          : null,
                                      color: AppColor.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadiusGeometry.circular(15),
                                        side: BorderSide(
                                          color: value.selectedRole == "Teacher"
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
                                            value.selectedRole == "Teacher"
                                                ? AppColor.blue
                                                : null,
                                            fontWeight:
                                            value.selectedRole == "Teacher"
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
                                      value.changeRole("Student");
                                    },
                                    child: Card(
                                      elevation: 2,
                                      shadowColor:
                                      value.selectedRole == "Student"
                                          ? AppColor.blue
                                          : null,
                                      color: AppColor.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadiusGeometry.circular(15),
                                        side: BorderSide(
                                          color: value.selectedRole == "Student"
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
                                            value.selectedRole == "Student"
                                                ? AppColor.blue
                                                : null,
                                            fontWeight:
                                            value.selectedRole == "Student"
                                                ? FontWeight.bold
                                                : FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                      Row(
                        children: [
                          Checkbox(
                            value: signupProvider.isConditionChecked,
                            checkColor: AppColor.white,
                            activeColor: AppColor.blue,
                            onChanged: (v) {
                              signupProvider.toggleConditionsCheck(v!);
                            },
                          ),
                          Expanded(
                            child: RichText(
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
                                    ),
                                  ),
                                  TextSpan(text: 'and '),
                                  TextSpan(
                                    text: 'Privacy policy. ',
                                    style: TextStyle(
                                      color: AppColor.blue,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(15),
                            backgroundColor: AppColor.blue,
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23),
                            ),
                          ),
                          onPressed: signupProvider.isLoading
                              ? null
                              : (){
                            signupProvider.validateInput(context);
                          } ,
                          child: signupProvider.isLoading
                              ? CircularProgressIndicator(color: AppColor.blue)
                              : Text(
                                  'Send Otp',
                                  style: TextStyle(
                                    color: AppColor.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
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
                                fontWeight: FontWeight.w700,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    AppRoutes.login,
                                    (route) => false,
                                  );
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
