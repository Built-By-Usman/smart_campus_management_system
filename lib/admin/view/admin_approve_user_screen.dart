import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constant/app_color.dart';
import '../provider/admin_approve_user_provider.dart';

// Helper to replace capitalizeFirst without needing external libraries
extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class AdminApproveUserScreen extends StatelessWidget {
  final String user;

  const AdminApproveUserScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AdminApproveUserProvider(user: user)..init(),
      child: _Body(user: user),
    );
  }
}

class _Body extends StatelessWidget {
  final String user;

  const _Body({required this.user});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AdminApproveUserProvider>(context);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        title: Text(
          'Unauthenticated ${user.capitalize()}',
          style: TextStyle(
            color: AppColor.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              /// SEARCH BAR
              Container(
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  cursorColor: AppColor.black,
                  onChanged: controller.searchUser,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: AppColor.subHeading),
                    hintText: 'Search by name, email or ID',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(15),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              /// CONTENT
              Expanded(
                child: controller.isLoading
                    ? Center(
                  child: CircularProgressIndicator(color: AppColor.blue),
                )
                    : controller.filteredUsers.isEmpty
                    ? Center(
                  child: Text(
                    'No unauthenticated ${user.capitalize()} available',
                    style: TextStyle(
                      color: AppColor.subHeading,
                      fontSize: 15,
                    ),
                  ),
                )
                    : ListView.builder(
                  itemCount: controller.filteredUsers.length,
                  itemBuilder: (context, index) {
                    final userData = controller.filteredUsers[index];
                    return _UserCard(
                      user: userData,
                      controller: controller,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  final dynamic user;
  final AdminApproveUserProvider controller;

  const _UserCard({
    required this.user,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        children: [
          /// TOP SECTION
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// USER INFO
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColor.outline,
                    child: Icon(Icons.person_outline, color: AppColor.subHeading),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name ?? "No Name",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        user.email ?? "No Email",
                        style: TextStyle(
                          color: AppColor.subHeading,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              /// ROLE TAG
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: user.role == 'student' ? AppColor.lightBlue : AppColor.lightPurple,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  (user.role as String? ?? "user").capitalize(),
                  style: TextStyle(
                    color: user.role == 'student' ? AppColor.blue : AppColor.purple,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// STATUS ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _infoBox(
                "Status",
                user.isAuthenticated ? "Active" : "Inactive",
                user.isActive ? AppColor.green : AppColor.red,
              ),
            ],
          ),

          const Divider(height: 20),

          /// ACTIONS
          Row(
            children: [
              /// APPROVE
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => controller.approveUnauthenticatedUser(user.id),
                  icon: Icon(Icons.check_circle_outline, color: AppColor.blue),
                  label: Text("Approve", style: TextStyle(color: AppColor.blue)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.lightBlue,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              /// DECLINE
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => controller.declineUnauthenticatedUser(user.id),
                  icon: Icon(Icons.close, color: AppColor.red),
                  label: Text("Decline", style: TextStyle(color: AppColor.red)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.lightRed,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoBox(String title, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: AppColor.subHeading, fontSize: 12),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}