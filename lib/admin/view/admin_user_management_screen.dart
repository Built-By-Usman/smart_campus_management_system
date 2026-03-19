import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:CampusX/admin/widgets/show_edit_dialog.dart';
import 'package:CampusX/core/constant/app_color.dart';

import '../../models/user_model.dart';
import '../controller/admin_user_management_screen_controller.dart';
import '../widgets/buile_text_field.dart';

class AdminUserManagementScreen extends StatelessWidget {
  AdminUserManagementScreen({super.key});

  final AdminUserManagementScreenController controller = Get.put(
    AdminUserManagementScreenController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: 35,
                  height: 35,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: SvgPicture.asset('assets/icons/logo.svg'),
                  ),
                ),

                SizedBox(width: 10),
                Text(
                  'Smart Campus',
                  style: TextStyle(
                    color: AppColor.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_none_outlined,
                    color: AppColor.subHeading,
                  ),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
              ],
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value == true) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User Management',
                    style: TextStyle(
                      color: AppColor.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Manage campus access, roles and permissions.',
                    style: TextStyle(
                      color: AppColor.subHeading,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            controller.goToApproveUser('teachers');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.blue,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.person_add_alt, color: AppColor.white),
                              SizedBox(width: 7),
                              Text(
                                'Approve Teachers',
                                style: TextStyle(color: AppColor.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            controller.goToApproveUser('students');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.blue,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.person_add_alt, color: AppColor.white),
                              SizedBox(width: 7),
                              Text(
                                'Approve Students',
                                style: TextStyle(color: AppColor.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),
                  Card(
                    color: AppColor.white,
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(17),
                      child: Column(
                        children: [
                          TextField(
                            cursorColor: AppColor.black,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppColor.subHeading,
                              ),
                              hint: Text(
                                'Search by name, email or ID',
                                style: TextStyle(color: AppColor.subHeading),
                              ),
                              isDense: true,
                              filled: true,
                              fillColor: AppColor.outline,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: AppColor.outline),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: AppColor.outline),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: AppColor.outline),
                              ),
                            ),
                            onChanged: controller.searchUsers,
                          ),

                          SizedBox(height: 15),

                          Row(
                            children: [
                              Expanded(
                                child: Obx(
                                  () => Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColor.background,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: AppColor.outline,
                                      ),
                                    ),
                                    child: DropdownButton<String>(
                                      borderRadius: BorderRadius.circular(10),
                                      dropdownColor: AppColor.white,
                                      menuWidth: 150,
                                      value: controller.selectedRole.value,
                                      underline: SizedBox(),
                                      isExpanded: true,
                                      icon: Icon(Icons.arrow_drop_down_sharp),
                                      onChanged: controller.changeRole,
                                      items: controller.roles.map((
                                        String role,
                                      ) {
                                        return DropdownMenuItem(
                                          value: role,
                                          child: Text(role),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(width: 20),

                              Expanded(
                                child: Obx(
                                  () => Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColor.background,
                                      border: Border.all(
                                        color: AppColor.outline,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: DropdownButton<String>(
                                      value: controller.selectedStatus.value,
                                      isExpanded: true,
                                      underline: SizedBox(),
                                      borderRadius: BorderRadius.circular(10),
                                      dropdownColor: AppColor.white,
                                      menuWidth: 150,
                                      items: controller.statuses.map((
                                        String status,
                                      ) {
                                        return DropdownMenuItem(
                                          value: status,
                                          child: Text(status),
                                        );
                                      }).toList(),
                                      onChanged: controller.changeStatus,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Obx(
                    () => ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
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
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
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
                                              user.isActive
                                                  ? 'Active'
                                                  : 'Inactive',
                                              style: TextStyle(
                                                color: user.isActive
                                                    ? AppColor.green
                                                    : AppColor.red,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),

                                        Column(
                                          children: [
                                            Text(
                                              'Email',
                                              style: TextStyle(
                                                color: AppColor.subHeading,
                                              ),
                                            ),
                                            Text(
                                              user.isVerifiedEmail
                                                  ? 'Verified'
                                                  : 'Unverified',
                                              style: TextStyle(
                                                color: user.isVerifiedEmail
                                                    ? AppColor.green
                                                    : AppColor.red,
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
                                            controller.showEditUserDialog(context, user.id);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColor.lightBlue,
                                          ),
                                          icon: Icon(
                                            Icons.edit_outlined,
                                            color: AppColor.blue,
                                          ),
                                          label: Text(
                                            'Edit',
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
                                            user.isActive
                                                ?controller.disableUser(user.id):null;
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: user.isActive
                                                ? AppColor.lightRed
                                                : AppColor.lightGrey,
                                          ),
                                          icon: Icon(
                                            Icons.person_off_outlined,
                                            color: user.isActive
                                                ? AppColor.red
                                                : AppColor.grey,
                                          ),
                                          label: Text(
                                            'Disable',
                                            style: TextStyle(
                                              color: user.isActive
                                                  ? AppColor.red
                                                  : AppColor.grey,
                                            ),
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
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
