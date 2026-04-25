import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:CampusX/core/constant/app_color.dart';
import '../provider/admin_user_management_provider.dart';

class AdminUserManagementScreen extends StatefulWidget {
  const AdminUserManagementScreen({super.key});

  @override
  State<AdminUserManagementScreen> createState() =>
      _AdminUserManagementScreenState();
}

class _AdminUserManagementScreenState extends State<AdminUserManagementScreen> {

  @override
  void initState() {
    super.initState();
    // CALL THE DATA FETCH HERE
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AdminUserManagementProvider>(context, listen: false).fetchAllUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    // listen: true (default) is required here to rebuild when data arrives
    final controller = Provider.of<AdminUserManagementProvider>(context);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
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
                const SizedBox(width: 10),
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
                  icon: Icon(Icons.notifications_none_outlined, color: AppColor.subHeading),
                ),
                const SizedBox(width: 10),
                const CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: controller.isLoading
            ?  Center(child: CircularProgressIndicator(color: AppColor.blue,))
            : RefreshIndicator(
          onRefresh: () => controller.fetchAllUsers(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('User Management', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const Text('Manage campus access, roles and permissions.', style: TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 10),

                // Approve Buttons Row
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => controller.goToApproveUser(context, 'teachers'),
                        style: ElevatedButton.styleFrom(backgroundColor: AppColor.blue),
                        icon: const Icon(Icons.person_add_alt, color: Colors.white),
                        label: const Text('Approve Teachers', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => controller.goToApproveUser(context, 'students'),
                        style: ElevatedButton.styleFrom(backgroundColor: AppColor.blue),
                        icon: const Icon(Icons.person_add_alt, color: Colors.white),
                        label: const Text('Approve Students', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                // Filter Card
                Card(
                  color: Colors.white,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(17),
                    child: Column(
                      children: [
                        TextField(
                          onChanged: controller.searchUsers,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search, color: Colors.grey),
                            hintText: 'Search by name, email or ID',
                            filled: true,
                            fillColor: AppColor.outline,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: _buildDropdown(
                                value: controller.selectedRole,
                                items: controller.roles,
                                onChanged: controller.changeRole,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: _buildDropdown(
                                value: controller.selectedStatus,
                                items: controller.statuses,
                                onChanged: controller.changeStatus,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // User List Logic
                controller.filteredUsers.isEmpty
                    ? const Center(child: Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Text("No users found", style: TextStyle(color: Colors.grey)),
                ))
                    : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = controller.filteredUsers[index];
                    return _UserCard(user: user, controller: controller);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({required String value, required List<String> items, required Function(String?) onChanged}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColor.outline),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        onChanged: onChanged,
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      ),
    );
  }
}

// Extracted User Card for cleaner code (Maintains your original design)
class _UserCard extends StatelessWidget {
  final dynamic user;
  final AdminUserManagementProvider controller;

  const _UserCard({required this.user, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                        backgroundColor: AppColor.outline,
                        child: Icon(Icons.person_outline, color: AppColor.subHeading),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text(user.email, style: TextStyle(color: AppColor.subHeading, fontSize: 13)),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: user.role == 'student' ? AppColor.lightBlue : AppColor.lightPurple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    child: Text(
                      user.role.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: user.role == 'student' ? AppColor.blue : AppColor.purple,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _statusColumn('Status', user.isActive ? 'Active' : 'Inactive', user.isActive ? AppColor.green : AppColor.red),
                  _statusColumn('Email', user.isVerifiedEmail ? 'Verified' : 'Unverified', user.isVerifiedEmail ? AppColor.green : AppColor.red),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => controller.showEditUserDialog(context, user.id),
                      style: ElevatedButton.styleFrom(backgroundColor: AppColor.lightBlue),
                      icon: Icon(Icons.edit_outlined, color: AppColor.blue),
                      label: Text('Edit', style: TextStyle(color: AppColor.blue)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => user.isActive ? controller.disableUser(user.id) : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: user.isActive ? AppColor.lightRed : AppColor.lightGrey,
                      ),
                      icon: Icon(Icons.person_off_outlined, color: user.isActive ? AppColor.red : AppColor.grey),
                      label: Text('Disable', style: TextStyle(color: user.isActive ? AppColor.red : AppColor.grey)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusColumn(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: AppColor.subHeading, fontSize: 12)),
        Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
      ],
    );
  }
}