import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../core/constant/app_color.dart';
import '../controller/admin_course_management_screen_controller.dart';

class AdminCourseManagementScreen extends StatelessWidget {
  AdminCourseManagementScreen({super.key});

  final AdminCourseManagementScreenController controller = Get.put(
    (AdminCourseManagementScreenController()),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        bottom: TabBar(
          tabs: controller.coursesTab,
          controller: controller.tabController,
          indicatorColor: AppColor.blue,
          labelColor: AppColor.blue,
          splashFactory: InkRipple.splashFactory,
          overlayColor: MaterialStateProperty.all(
            AppColor.blue.withOpacity(0.1),
          ),
        ),
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
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Courses Management',
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Manage curriculum and student enrollments',
                style: TextStyle(
                  color: AppColor.subHeading,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),

              TextField(
                cursorColor: AppColor.black,
                decoration: InputDecoration(
                  hintText: 'Search courses by id or name',
                  prefixIcon: Icon(Icons.search, color: AppColor.subHeading),
                  isDense: true,
                  filled: true,
                  fillColor: AppColor.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: AppColor.outline),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: AppColor.outline),
                  ),
                ),
              ),

              SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.blue,
                    padding: EdgeInsets.symmetric(vertical: 13),
                  ),
                  onPressed: () {},
                  label: Text(
                    'Create New Course',
                    style: TextStyle(
                      color: AppColor.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  icon: Icon(
                    Icons.add,
                    color: AppColor.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    ListView.builder(
                      itemBuilder: (context, index) {
                        return Card(
                          color: AppColor.white,
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/users/1.png',
                                width: double.infinity,
                                height: 120,
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColor.lightBlue,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 3,
                                      ),
                                      child: Text(
                                        'COMPUTER SCIENCE',
                                        style: TextStyle(
                                          color: AppColor.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.edit_outlined,
                                            color: AppColor.subHeading,
                                          ),
                                        ),

                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.delete_outlined,
                                            color: AppColor.subHeading,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              Text(
                                'Introduction to react and tailwind',
                                style: TextStyle(color: AppColor.black,fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: 10,
                    ),

                    Center(child: Text("Teachers List")),
                    Center(child: Text("Admins List")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget coursesList() {
  return Card();
}
