import 'package:CampusX/teacher/provider/teacher_dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constant/app_color.dart';

class TeacherDashboardScreen extends StatefulWidget {
  const TeacherDashboardScreen({super.key});

  @override
  State<TeacherDashboardScreen> createState() => _TeacherDashboardScreenState();
}

class _TeacherDashboardScreenState extends State<TeacherDashboardScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TeacherDashboardProvider>(context, listen: false).loadDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TeacherDashboardProvider>(context);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
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
        child: provider.isLoading
            ?  Center(child: CircularProgressIndicator(color: AppColor.blue,))
            : RefreshIndicator(
          onRefresh: () => provider.loadDashboard(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Teacher Overview',
                    style: TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Welcome back, ${provider.userName}. Here is your academic summary.',
                    style: TextStyle(
                      color: AppColor.subHeading,
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// STATS ROW 1
                  Row(
                    children: [
                      Expanded(
                        child: _buildCard(
                          title: 'My Courses',
                          value: provider.totalCourses.toString(),
                          icon: Icons.auto_stories_outlined,
                          iconColor: AppColor.blue,
                          bgColor: AppColor.lightBlue,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildCard(
                          title: 'Assignments',
                          value: provider.totalAssignments.toString(),
                          icon: Icons.assignment_outlined,
                          iconColor: AppColor.purple,
                          bgColor: AppColor.lightPurple,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  /// STATS ROW 2
                  Row(
                    children: [
                      Expanded(
                        child: _buildCard(
                          title: 'Total Submissions',
                          value: provider.totalSubmissions.toString(),
                          icon: Icons.fact_check_outlined,
                          iconColor: AppColor.orange,
                          bgColor: AppColor.lightOrange,
                        ),
                      ),
                      const SizedBox(width: 20),
                      // Placeholder card to keep the 2x2 design look
                      Expanded(
                        child: _buildCard(
                          title: 'Support Requests',
                          value: "0",
                          icon: Icons.help_outline,
                          iconColor: AppColor.red,
                          bgColor: AppColor.lightRed,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  /// RECENT SUBMISSIONS TABLE
                  Card(
                    color: AppColor.white,
                    elevation: 1,
                    child: Column(
                      children: [
                        _header('Recent Submissions'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: _tableHeader(['ID', 'Assignment', 'Grade']),
                        ),
                        provider.recentSubmissions.isEmpty
                            ? const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text("No recent submissions found"),
                        )
                            : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: provider.recentSubmissions.length,
                          itemBuilder: (context, index) {
                            final sub = provider.recentSubmissions[index];
                            return _row(
                              left: '#${sub.id}',
                              middle: 'Assign ID: ${sub.assignmentId}',
                              right: sub.grade != null
                                  ? sub.grade.toString()
                                  : 'Pending',
                              isActive: sub.grade != null,
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
      ),
    );
  }

  // --- UI Helper Widgets (Preserving your exact design) ---

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
            Text(title, style: TextStyle(color: AppColor.subHeading, fontSize: 12)),
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
          style: TextStyle(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _tableHeader(List<String> items) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: AppColor.footer,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.map((e) => Expanded(
          child: Text(
            e,
            textAlign: e == items.last ? TextAlign.right : TextAlign.left,
            style: TextStyle(color: AppColor.blue, fontWeight: FontWeight.bold),
          ),
        )).toList(),
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
          Expanded(child: Text(left, style: const TextStyle(fontSize: 13))),
          Expanded(child: Text(middle, style: const TextStyle(fontSize: 13))),
          Expanded(
            child: Text(
              right,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.green : Colors.orange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}