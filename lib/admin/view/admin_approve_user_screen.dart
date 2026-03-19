import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:CampusX/admin/controller/admin_approve_user_screen_controller.dart';

import '../../core/constant/app_color.dart';

class AdminApproveUserScreen extends StatelessWidget {
  final String user;
  final AdminApproveUserScreenController controller;

  AdminApproveUserScreen({super.key, required this.user})
    : controller = Get.put(AdminApproveUserScreenController(user: user));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        title: Text(
          'Unauthenticated ${user.capitalizeFirst}',
          style: TextStyle(color: AppColor.black, fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              TextField(
                cursorColor: AppColor.black,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: AppColor.subHeading),
                  hint: Text(
                    'Search by name, email or ID',
                    style: TextStyle(color: AppColor.subHeading),
                  ),
                  isDense: true,
                  filled: true,
                  fillColor: AppColor.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: AppColor.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: AppColor.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: AppColor.white),
                  ),
                ),
                onChanged: controller.searchUser,
              ),
              SizedBox(height: 20),
              Obx(() {
                if (controller.isLoading.value == true) {
                  return Center(
                    child: Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(color: AppColor.blue),
                    ),
                  );
                }
                if (controller.unauthenticatedUsers.isEmpty) {
                  return Center(
                    child: Text(
                      'No unauthenticated ${user.capitalizeFirst} available',
                      style: TextStyle(
                        color: AppColor.subHeading,
                        fontSize: 15,
                      ),
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final user = controller.filteredUsers[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(20),
                          ),
                          color: AppColor.white,
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(13),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: AppColor.outline,
                                          child: Icon(
                                            Icons.person_outline,
                                            color: AppColor.subHeading,
                                          ),
                                        ),
                                        SizedBox(width: 15),

                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              user.name,
                                              style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              user.email,
                                              style: TextStyle(
                                                color: AppColor.subHeading,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    Container(
                                      decoration: BoxDecoration(
                                        color: user.role == 'student'
                                            ? AppColor.lightBlue
                                            : AppColor.lightPurple,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 7,
                                          vertical: 2,
                                        ),
                                        child: Text(
                                          user.role[0].toUpperCase() +
                                              user.role.substring(1),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: user.role == 'student'
                                                ? AppColor.blue
                                                : AppColor.purple,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'Status',
                                            style: TextStyle(
                                              color: AppColor.subHeading,
                                            ),
                                          ),
                                          Text(
                                            user.isAuthenticated
                                                ? 'Active'
                                                : 'Inactive',
                                            style: TextStyle(
                                              color: user.isActive
                                                  ? AppColor.green
                                                  : AppColor.subHeading,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 5),

                                Divider(color: AppColor.outline),

                                SizedBox(height: 10),

                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          controller.approveUnauthenticatedUser(
                                            user.id,
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColor.lightBlue,
                                        ),
                                        icon: Icon(
                                          Icons.check_circle_outline,
                                          color: AppColor.blue,
                                        ),
                                        label: Text(
                                          'Approve',
                                          style: TextStyle(
                                            color: AppColor.blue,
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(width: 20),

                                    Expanded(
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          controller.declineUnauthenticatedUser(
                                            user.id,
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColor.lightRed,
                                        ),
                                        icon: Icon(
                                          Icons.close,
                                          color: AppColor.red,
                                        ),
                                        label: Text(
                                          'Decline',
                                          style: TextStyle(color: AppColor.red),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: controller.filteredUsers.length,
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
