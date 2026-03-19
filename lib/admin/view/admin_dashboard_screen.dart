import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:CampusX/core/constant/app_color.dart';

import '../controller/admin_dashboard_screen_controller.dart';

class AdminDashboardScreen extends StatelessWidget {
  AdminDashboardScreen({super.key});

  final AdminDashboardScreenController controller = Get.put(
    AdminDashboardScreenController(),
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
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.menu, color: AppColor.subHeading),
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
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.contact_support_outlined,
                    color: AppColor.subHeading,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Obx((){
          if(controller.isLoading.value==true){
            return Center(child: CircularProgressIndicator(color: AppColor.blue,));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Campus Overview',
                    style: TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(height: 3),
                  Obx(()=>Text(
                    'Welcome back, ${controller.userName.value}. Here is what happening today.',
                    style: TextStyle(
                      color: AppColor.subHeading,
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),),

                  SizedBox(height: 20),

                  Row(
                    children: [
                      ///Total Students
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                          elevation: 2,
                          color: AppColor.white,
                          clipBehavior: Clip.antiAlias,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(14),
                                            color: AppColor.lightBlue
                                        ),
                                        width: 40,
                                        height: 40,
                                        child: Icon(Icons.people_alt_outlined,color: AppColor.blue,)
                                    ),

                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: AppColor.lightGreen,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.show_chart,color: AppColor.green,),
                                            Text(
                                              '10%',
                                              style: TextStyle(
                                                color: AppColor.green,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 15),

                                Text(
                                  'Total Students',
                                  style: TextStyle(
                                    color: AppColor.subHeading,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 5),

                                Obx(()=>Text(
                                  controller.totalTeachers.value,
                                  style: TextStyle(
                                    color: AppColor.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 20,),
                      ///Total Teacher
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                          elevation: 2,
                          color: AppColor.white,
                          clipBehavior: Clip.antiAlias,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(14),
                                            color: AppColor.lightPurple
                                        ),
                                        width: 40,
                                        height: 40,
                                        child: Icon(Icons.person_outline,color: AppColor.purple,)
                                    ),

                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: AppColor.lightGreen,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.show_chart,color: AppColor.green,),
                                            Text(
                                              '10%',
                                              style: TextStyle(
                                                color: AppColor.green,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 15),

                                Text(
                                  'Total Teachers',
                                  style: TextStyle(
                                    color: AppColor.subHeading,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 5),

                                Obx(()=>Text(
                                  controller.totalStudents.value,
                                  style: TextStyle(
                                    color: AppColor.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      ///Active Courses
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                          elevation: 2,
                          color: AppColor.white,
                          clipBehavior: Clip.antiAlias,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(14),
                                            color: AppColor.lightOrange
                                        ),
                                        width: 40,
                                        height: 40,
                                        child: Icon(Icons.book_outlined,color: AppColor.orange,)
                                    ),

                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: AppColor.lightGreen,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.show_chart,color: AppColor.green,),
                                            Text(
                                              '10%',
                                              style: TextStyle(
                                                color: AppColor.green,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 15),

                                Text(
                                  'Active Courses',
                                  style: TextStyle(
                                    color: AppColor.subHeading,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 5),

                                Obx(()=>Text(
                                  controller.activeCourses.value,
                                  style: TextStyle(
                                    color: AppColor.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 20,),
                      ///Pending Complaints
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                          elevation: 2,
                          color: AppColor.white,
                          clipBehavior: Clip.antiAlias,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(14),
                                            color: AppColor.lightRed
                                        ),
                                        width: 40,
                                        height: 40,
                                        child: Icon(Icons.warning_amber_outlined,color: AppColor.red,)
                                    ),

                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: AppColor.lightGreen,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.show_chart,color: AppColor.green,),
                                            Text(
                                              '10%',
                                              style: TextStyle(
                                                color: AppColor.green,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 15),

                                Text(
                                  'Pending Complaints',
                                  style: TextStyle(
                                    color: AppColor.subHeading,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 5),

                                Obx(()=>Text(
                                  controller.pendingComplaints.value,
                                  style: TextStyle(
                                    color: AppColor.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 20),

                  ///Recent User
                  Card(
                    color: AppColor.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Recent User Activity',
                                style: TextStyle(
                                  color: AppColor.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),

                              InkWell(
                                onTap: () {},
                                child: Text(
                                  'View all',
                                  style: TextStyle(
                                    color: AppColor.blue,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 30,
                          color: AppColor.footer,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 5,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'User',
                                  style: TextStyle(
                                    color: AppColor.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Role',
                                  style: TextStyle(
                                    color: AppColor.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Status',
                                  style: TextStyle(
                                    color: AppColor.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Obx(()=>ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final user = controller.recentUsers[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          user.name,
                                          style: TextStyle(
                                            color: AppColor.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(user.role),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: user.isAuthenticated
                                                  ? AppColor.lightGreen
                                                  : AppColor.outline,
                                              borderRadius: BorderRadius.circular(
                                                12,
                                              ),
                                            ),

                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 5,
                                                vertical: 2,
                                              ),
                                              child: Text(
                                                user.isAuthenticated?'Active':'Inactive',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  color:
                                                  user.isAuthenticated
                                                      ? AppColor.green
                                                      : AppColor.subHeading,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                ],
                              ),
                            );
                          },
                          itemCount: controller.recentUsers.length,
                        ),)
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  ///Recent complaints
                  Card(
                    color: AppColor.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Recent Complaints',
                                style: TextStyle(
                                  color: AppColor.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),

                              InkWell(
                                onTap: () {},
                                child: Text(
                                  'View all',
                                  style: TextStyle(
                                    color: AppColor.blue,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 30,
                          color: AppColor.footer,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 5,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'ID',
                                  style: TextStyle(
                                    color: AppColor.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Subject',
                                  style: TextStyle(
                                    color: AppColor.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Priority',
                                  style: TextStyle(
                                    color: AppColor.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Obx(()=>ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final complaints = controller.recentComplaints[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          complaints.id.toString(),
                                          style: TextStyle(
                                            color: AppColor.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          complaints.title,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColor.lightBlue,
                                              borderRadius: BorderRadius.circular(
                                                12,
                                              ),
                                            ),

                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 5,
                                                vertical: 2,
                                              ),
                                              child: Text(
                                                complaints.status,
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  color: AppColor.blue,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                ],
                              ),
                            );
                          },
                          itemCount: controller.recentComplaints.length,
                        )),
                      ],
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
