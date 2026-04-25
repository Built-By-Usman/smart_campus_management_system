import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:CampusX/core/constant/app_color.dart';

import '../provider/admin_dashboard_provider.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() =>
      _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<AdminDashboardProvider>(
        context,
        listen: false,
      ).loadDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AdminDashboardProvider>(context);

    if (controller.isLoading) {
      return Scaffold(
        backgroundColor: AppColor.background,
        body: Center(
          child: CircularProgressIndicator(color: AppColor.blue),
        ),
      );
    }

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
                  icon: Icon(Icons.notifications_none_outlined,
                      color: AppColor.subHeading),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.contact_support_outlined,
                      color: AppColor.subHeading),
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

                const SizedBox(height: 3),

                Text(
                  'Welcome back, ${controller.userName}. Here is what happening today.',
                  style: TextStyle(
                    color: AppColor.subHeading,
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 20),

                /// CARDS ROW 1
                Row(
                  children: [
                    Expanded(
                      child: _buildCard(
                        title: 'Total Students',
                        value: controller.totalStudents,
                        icon: Icons.people_alt_outlined,
                        iconColor: AppColor.blue,
                        bgColor: AppColor.lightBlue,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildCard(
                        title: 'Total Teachers',
                        value: controller.totalTeachers,
                        icon: Icons.person_outline,
                        iconColor: AppColor.purple,
                        bgColor: AppColor.lightPurple,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                /// CARDS ROW 2
                Row(
                  children: [
                    Expanded(
                      child: _buildCard(
                        title: 'Active Courses',
                        value: controller.activeCourses,
                        icon: Icons.book_outlined,
                        iconColor: AppColor.orange,
                        bgColor: AppColor.lightOrange,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildCard(
                        title: 'Pending Complaints',
                        value: controller.pendingComplaints,
                        icon: Icons.warning_amber_outlined,
                        iconColor: AppColor.red,
                        bgColor: AppColor.lightRed,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// RECENT USERS
                Card(
                  color: AppColor.white,
                  child: Column(
                    children: [
                      _header('Recent User Activity'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: _tableHeader(['User', 'Role', 'Status']),
                      ),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.recentUsers.length,
                        itemBuilder: (context, index) {
                          final user = controller.recentUsers[index];

                          return _row(
                            left: user.name,
                            middle: user.role,
                            right: user.isAuthenticated
                                ? 'Active'
                                : 'Inactive',
                            isActive: user.isAuthenticated,
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// RECENT COMPLAINTS
                Card(
                  color: AppColor.white,
                  child: Column(
                    children: [
                      _header('Recent Complaints'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: _tableHeader(['ID', 'Subject', 'Status']),
                      ),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.recentComplaints.length,
                        itemBuilder: (context, index) {
                          final c = controller.recentComplaints[index];

                          return _row(
                            left: c.id.toString(),
                            middle: c.title,
                            right: c.status,
                            isActive: true,
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
    );
  }

  Widget _buildCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      elevation: 2,
      color: AppColor.white,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: bgColor,
              ),
              child: Icon(icon, color: iconColor),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: TextStyle(
                color: AppColor.subHeading,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                color: AppColor.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(String title) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            color: AppColor.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _tableHeader(List<String> items) {
    return Container(
      height: 30,
      color: AppColor.footer,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items
            .map(
              (e) => Text(
            e,
            style: TextStyle(
              color: AppColor.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
            .toList(),
      ),
    );
  }

  Widget _row({
    required String left,
    required String middle,
    required String right,
    required bool isActive,
  }) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(child: Text(left)),
          Expanded(child: Text(middle)),
          Expanded(
            child: Text(
              right,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: isActive ? Colors.green : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}