import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:CampusX/core/function/api_client.dart';
import 'package:CampusX/models/user_model.dart';
import 'package:CampusX/core/constant/app_routes.dart';
import 'package:CampusX/core/function/utilities.dart';

class AdminUserManagementProvider extends ChangeNotifier {
  final ApiClient apiClient = ApiClient();

  bool isLoading = false;

  String selectedRole = 'All Roles';
  String selectedStatus = "All";
  String searchQuery = '';

  List<UserModel> allUsers = [];
  List<UserModel> filteredUsers = [];

  final List<String> roles = ['All Roles', 'Teachers', 'Students'];
  final List<String> statuses = ["All", "Active", "Inactive"];

  // Changed to a method that ensures filters are applied after fetching
  Future<void> fetchAllUsers() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await apiClient.dio.get('/user/');

      if (response.statusCode == 200) {
        allUsers = (response.data as List)
            .map((json) => UserModel.fromJson(json))
            .toList();

        // Crucial: Apply filters immediately so filteredUsers isn't empty
        applyFilters();
      }
    } catch (e) {
      debugPrint("Fetch Error: $e");
      showSnackBarGlobal('Failed', 'Could not load users');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void searchUsers(String query) {
    searchQuery = query;
    applyFilters();
    notifyListeners();
  }

  void changeStatus(String? value) {
    if (value == null) return;
    selectedStatus = value;
    applyFilters();
    notifyListeners();
  }

  void changeRole(String? value) {
    if (value == null) return;
    selectedRole = value;
    applyFilters();
    notifyListeners();
  }

  void applyFilters() {
    List<UserModel> users = List.from(allUsers);

    if (selectedRole == 'Teachers') {
      users = users.where((u) => u.role.toLowerCase() == 'teacher').toList();
    } else if (selectedRole == 'Students') {
      users = users.where((u) => u.role.toLowerCase() == 'student').toList();
    }

    if (selectedStatus == 'Active') {
      users = users.where((u) => u.isActive == true).toList();
    } else if (selectedStatus == 'Inactive') {
      users = users.where((u) => u.isActive == false).toList();
    }

    if (searchQuery.isNotEmpty) {
      final q = searchQuery.toLowerCase();
      users = users.where((u) {
        return u.name.toLowerCase().contains(q) ||
            u.email.toLowerCase().contains(q) ||
            u.id.toString().contains(q);
      }).toList();
    }

    filteredUsers = users;
  }

  // ... (Keep goToApproveUser, disableUser, updateUser, and showEditUserDialog exactly as you had them)

  void goToApproveUser(BuildContext context, String user) {
    Navigator.pushNamed(context, AppRoutes.adminApproveUsers, arguments: user);
  }

  Future<void> disableUser(int id) async {
    try {
      await apiClient.dio.put(
        '/user/decline-unauthenticated-user/',
        options: Options(contentType: Headers.jsonContentType),
        data: {'id': [id]},
      );
      final index = allUsers.indexWhere((u) => u.id == id);
      if (index != -1) {
        allUsers[index] = allUsers[index].copyWith(isActive: false);
        applyFilters();
      }
      notifyListeners();
    } catch (e) {
      showSnackBarGlobal('Failed', 'Action failed');
    }
  }

  Future<void> updateUser({
    required int id,
    required String name,
    required String email,
    required String role,
    required bool isActive,
    required bool isAuthenticated,
    required bool isVerifiedEmail,
  }) async {
    try {
      await apiClient.dio.put(
        '/user/$id/',
        data: {
          "name": name,
          "email": email,
          "role": role,
          "is_active": isActive,
          "is_authenticated": isAuthenticated,
          "is_verified_email": isVerifiedEmail,
        },
      );

      final index = allUsers.indexWhere((u) => u.id == id);
      if (index != -1) {
        allUsers[index] = allUsers[index].copyWith(
          name: name,
          email: email,
          role: role,
          isActive: isActive,
          isAuthenticated: isAuthenticated,
          isVerifiedEmail: isVerifiedEmail,
        );
        applyFilters();
      }
      notifyListeners();
    } catch (e) {
      showSnackBarGlobal('Failed', 'Update failed');
    }
  }

  Future<void> showEditUserDialog(BuildContext context, int id) async {
    UserModel user = allUsers.firstWhere((user) => user.id == id);

    final nameController = TextEditingController(text: user.name);
    final emailController = TextEditingController(text: user.email);
    final roleController = TextEditingController(text: user.role);

    bool isActive = user.isActive;
    bool isAuthenticated = user.isAuthenticated;
    bool isVerifiedEmail = user.isVerifiedEmail;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(
                padding: const EdgeInsets.all(24),
                width: 500,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Edit User", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      TextField(controller: nameController, decoration: const InputDecoration(labelText: "Full Name")),
                      TextField(controller: emailController, decoration: const InputDecoration(labelText: "Email")),
                      TextField(controller: roleController, decoration: const InputDecoration(labelText: "Role")),
                      SwitchListTile(title: const Text("Active"), value: isActive, onChanged: (v) => setState(() => isActive = v)),
                      SwitchListTile(title: const Text("Authenticated"), value: isAuthenticated, onChanged: (v) => setState(() => isAuthenticated = v)),
                      SwitchListTile(title: const Text("Email Verified"), value: isVerifiedEmail, onChanged: (v) => setState(() => isVerifiedEmail = v)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
                          ElevatedButton(
                            onPressed: () async {
                              await updateUser(
                                id: user.id,
                                name: nameController.text,
                                email: emailController.text,
                                role: roleController.text,
                                isActive: isActive,
                                isAuthenticated: isAuthenticated,
                                isVerifiedEmail: isVerifiedEmail,
                              );
                              Navigator.pop(context);
                            },
                            child: const Text("Save"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}