import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smar_campus_management_system/controller/dashboard_screen_controller.dart';
import 'package:smar_campus_management_system/core/constant/app_color.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final DashboardScreenController controller = Get.put(
    DashboardScreenController(),
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
        child: Padding(
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
                Text(
                  'Welcome back, Dr. Wilson. Here is what happening today.',
                  style: TextStyle(
                    color: AppColor.subHeading,
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                  ),
                ),

                SizedBox(height: 20),

                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final data = controller.overview[index];
                    Color trackBg = AppColor.outline;
                    Color trackColor = AppColor.subHeading;
                    Icon trackIcon = Icon(
                      Icons.sentiment_neutral,
                      color: trackColor,
                    );
                    if (data['track'] < 0) {
                      trackBg = AppColor.lightRed;
                      trackColor = AppColor.red;
                      trackIcon = Icon(
                        Icons.show_chart_sharp,
                        color: trackColor,
                        size: 18,
                      );
                    } else {
                      trackBg = AppColor.lightGreen;
                      trackColor = AppColor.green;
                      trackIcon = Icon(
                        Icons.show_chart,
                        color: trackColor,
                        size: 18,
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 13),
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
                                      color: data['backgroundColor'],
                                    ),
                                    width: 40,
                                    height: 40,
                                    child: data['icon'],
                                  ),

                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: trackBg,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      child: Row(
                                        children: [
                                          trackIcon,
                                          Text(
                                            '${data['track']}%',
                                            style: TextStyle(
                                              color: trackColor,
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
                                data['heading'],
                                style: TextStyle(
                                  color: AppColor.subHeading,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 5),

                              Text(
                                data['strength'],
                                style: TextStyle(
                                  color: AppColor.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: controller.overview.length,
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
                      ListView.builder(
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
                                        user['userName'],
                                        style: TextStyle(
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(user['role']),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: user['status'] == 'online'
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
                                              user['status'],
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                color:
                                                    user['status'] == 'online'
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
                      ),
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
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final user = controller.recentComplaints[index];
                          Color bgColor = AppColor.outline;
                          Color color = AppColor.subHeading;
                          if (user['priority'] == 'High') {
                            bgColor = AppColor.lightRed;
                            color = AppColor.red;
                          } else if (user['priority'] == 'Medium') {
                            bgColor = AppColor.lightOrange;
                            color = AppColor.orange;
                          } else {
                            bgColor = AppColor.outline;
                            color = AppColor.subHeading;
                          }
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
                                        user['id'],
                                        style: TextStyle(
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        user['subject'],
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: bgColor,
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
                                              user['priority'],
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                color: color,
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
