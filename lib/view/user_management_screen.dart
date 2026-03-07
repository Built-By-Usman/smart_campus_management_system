import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smar_campus_management_system/controller/user_management_screen_controller.dart';
import 'package:smar_campus_management_system/core/constant/app_color.dart';

class UserManagementScreen extends StatelessWidget {
  UserManagementScreen({super.key});

  final UserManagementScreenController controller = Get.put(
    UserManagementScreenController(),
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
        child: Padding(
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
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.blue,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_add_alt, color: AppColor.white),
                      SizedBox(width: 7),
                      Text(
                        'Create new user',
                        style: TextStyle(color: AppColor.white),
                      ),
                    ],
                  ),
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
                          ),
                        ),

                        SizedBox(height: 15),

                        Row(
                          children: [
                            Expanded(
                              child: Obx(
                                () => Container(
                                  padding: EdgeInsets.symmetric(horizontal: 6),
                                  decoration: BoxDecoration(
                                    color: AppColor.background,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: AppColor.outline),
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
                                    items: controller.roles.map((String role) {
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
                                  padding: EdgeInsets.symmetric(horizontal: 6),
                                  decoration: BoxDecoration(
                                    color: AppColor.background,
                                    border: Border.all(color: AppColor.outline),
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
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final user = controller.users[index];
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundImage: AssetImage(
                                          '${user['image']}',
                                        ),
                                      ),
                                      SizedBox(width: 15),

                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            user['name'],
                                            style: TextStyle(
                                              color: AppColor.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            user['email'],
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
                                      color: user['role'] == 'Student'
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
                                        user['role'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: user['role'] == 'Student'
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
                                          user['status'],
                                          style: TextStyle(
                                            color: user['status'] == 'Active'
                                                ? AppColor.green
                                                : AppColor.subHeading,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),

                                    Column(
                                      children: [
                                        Text(
                                          'Last Login',
                                          style: TextStyle(
                                            color: AppColor.subHeading,
                                          ),
                                        ),
                                        Text(
                                          user['last_login'],
                                          style: TextStyle(
                                            color: AppColor.black,
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
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColor.lightBlue,
                                      ),
                                      icon: Icon(
                                        Icons.edit_outlined,
                                        color: AppColor.blue,
                                      ),
                                      label: Text(
                                        'Edit',
                                        style: TextStyle(color: AppColor.blue),
                                      ),
                                    ),
                                  ),

                                  SizedBox(width: 20),

                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColor.lightRed,
                                      ),
                                      icon: Icon(
                                        Icons.edit_outlined,
                                        color: AppColor.red,
                                      ),
                                      label: Text(
                                        'Delete',
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
                  itemCount: controller.users.length,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
