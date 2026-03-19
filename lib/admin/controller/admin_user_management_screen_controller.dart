import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:CampusX/core/constant/app_routes.dart';
import 'package:CampusX/core/function/api_client.dart';
import 'package:CampusX/core/function/utilities.dart';
import 'package:CampusX/models/user_model.dart';

import '../../core/constant/app_color.dart';

class AdminUserManagementScreenController extends GetxController {
  var selectedRole = 'All Roles'.obs;
  var selectedStatus = "All".obs;
  var isLoading = false.obs;
  RxList<UserModel> allUsers = <UserModel>[].obs;
  RxList<UserModel> filteredUsers = <UserModel>[].obs;
  final ApiClient apiClient = ApiClient();
  var searchQuery = ''.obs;

  final List<String> roles = ['All Roles', 'Teachers', 'Students'];

  final List<String> statuses = ["All", "Active", "Inactive"];

  @override
  void onInit() {
    fetchAllUsers();
    super.onInit();
  }

  void searchUsers(String query) {
    searchQuery.value = query;
    applyFilters();
  }

  void changeStatus(String? value) {
    if (value != null) {
      selectedStatus.value = value;
     applyFilters();
    }
  }


  void changeRole(String? value) {
    if (value != null) {
      selectedRole.value = value;
      applyFilters();
    }
  }

  void applyFilters() {
    List<UserModel> users = allUsers.toList();

    if (selectedRole.value == 'Teachers') {
      users = users.where((u) => u.role == 'teacher').toList();
    } else if (selectedRole.value == 'Students') {
      users = users.where((u) => u.role == 'student').toList();
    }

    if (selectedStatus.value == 'Active') {
      users = users.where((u) => u.isActive == true).toList();
    } else if (selectedStatus.value == 'Inactive') {
      users = users.where((u) => u.isActive == false).toList();
    }

    if (searchQuery.value.isNotEmpty) {
      String query = searchQuery.value.toLowerCase();

      users = users.where((u) {
        return u.name.toLowerCase().contains(query) ||
            u.email.toLowerCase().contains(query) ||
            u.id.toString().contains(query);
      }).toList();
    }

    filteredUsers.value = users;
  }

  Future<void> fetchAllUsers() async {
    isLoading.value = true;
    try {
      final response = await apiClient.dio.get('/user/');

      final data = response.data;

      List<UserModel> fetchedUsers = (data as List)
          .map((json) => UserModel.fromJson(json))
          .toList();
      allUsers.value=fetchedUsers;
      filteredUsers.value=allUsers;
    } on DioException catch (e) {
      if(e.response!=null && e.response!.data!=null){
        String errorMessage= e.response!.data['detail']??"Unknown Error";
        showSnackBar('Failed', errorMessage);
      }
      else{
        showSnackBar('Failed', 'Unknown Error Occurred');

      }
    } finally {
      isLoading.value = false;
    }
  }

  void goToApproveUser(String user){
    Get.toNamed(AppRoutes.adminApproveUsers,arguments: user);
  }


  Future<void> disableUser(int id) async {
    isLoading.value = true;
    try {
      await apiClient.dio.put(
        '/user/decline-unauthenticated-user/',
        options: Options(contentType: Headers.jsonContentType),
        data: {
          'id': [id],
        },
      );
      int index = filteredUsers.indexWhere((u) => u.id == id);

      if (index != -1) {
        filteredUsers[index] = filteredUsers[index].copyWith(

          isActive: false,
        );

        filteredUsers.refresh();
      }


    } on DioException catch (e) {
      if(e.response!=null && e.response!.data!=null){
        final errorMessage = e.response!.data['detail']??'Unknown Error';
        showSnackBar('Failed', errorMessage);
      }
      else{
        showSnackBar('Failed', 'Unknown Error');
      }
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> showEditUserDialog(BuildContext context, int id,) {
    UserModel user = filteredUsers.firstWhere((user)=>user.id==id);
    final nameController = TextEditingController(text: user.name);
    final emailController = TextEditingController(text: user.email);
    final roleController = TextEditingController(text: user.role);

    bool isActive = user.isActive;
    bool isAuthenticated = user.isAuthenticated;
    bool isVerifiedEmail = user.isVerifiedEmail;

    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 500,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      /// HEADER
                      Row(
                        children: [
                          Icon(Icons.edit, color: AppColor.blue),
                          const SizedBox(width: 8),
                          Text(
                            "Edit User",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColor.black,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      /// NAME
                      buildTextField(
                        controller: nameController,
                        label: "Full Name",
                      ),

                      const SizedBox(height: 16),

                      /// EMAIL
                      buildTextField(
                        controller: emailController,
                        label: "Email Address",
                      ),

                      const SizedBox(height: 16),

                      /// ROLE
                      buildTextField(
                        controller: roleController,
                        label: "Role",
                      ),

                      const SizedBox(height: 20),

                      /// STATUS SECTION
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColor.background,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          children: [
                            buildSwitchTile(
                              title: "Active Account",
                              value: isActive,
                              activeColor: AppColor.green,
                              onChanged: (val) =>
                                  setState(() => isActive = val),
                            ),
                            buildSwitchTile(
                              title: "Authenticated",
                              value: isAuthenticated,
                              activeColor: AppColor.purple,
                              onChanged: (val) =>
                                  setState(() => isAuthenticated = val),
                            ),
                            buildSwitchTile(
                              title: "Email Verified",
                              value: isVerifiedEmail,
                              activeColor: AppColor.orange,
                              onChanged: (val) =>
                                  setState(() => isVerifiedEmail = val),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// READ ONLY INFO
                      Text(
                        "User ID: ${user.id}",
                        style: TextStyle(
                          color: AppColor.subHeading,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "Created At: ${user.createdAt}",
                        style: TextStyle(
                          color: AppColor.subHeading,
                          fontSize: 12,
                        ),
                      ),

                      const SizedBox(height: 28),

                      /// ACTION BUTTONS
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: AppColor.grey),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.blue,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
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

                              Get.back();
                            },
                            child: const Text(
                              "Save Changes",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
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
    isLoading.value = true;

    try {
      await apiClient.dio.put(
        '/user/$id/',
        options: Options(contentType: Headers.jsonContentType),
        data: {
          "name": name,
          "email": email,
          "role": role,
          "is_active": isActive,
          "is_authenticated": isAuthenticated,
          "is_verified_email": isVerifiedEmail,
        },
      );

      /// 🔥 Update local list after success
      int index = filteredUsers.indexWhere((u) => u.id == id);

      if (index != -1) {
        filteredUsers[index] = filteredUsers[index].copyWith(
          name: name,
          email: email,
          role: role,
          isActive: isActive,
          isAuthenticated: isAuthenticated,
          isVerifiedEmail: isVerifiedEmail,
        );

        filteredUsers.refresh();
      }

    } on DioException catch (e) {
      print(e.response?.data);
    } finally {
      isLoading.value = false;
    }
  }


  Widget buildTextField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: AppColor.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColor.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColor.blue),
        ),
      ),
    );
  }


  Widget buildSwitchTile({
    required String title,
    required bool value,
    required Color activeColor,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      activeColor: activeColor,
      value: value,
      onChanged: onChanged,
    );
  }
}
