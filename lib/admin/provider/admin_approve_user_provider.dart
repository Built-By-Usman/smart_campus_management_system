import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../core/function/api_client.dart';
import '../../core/function/utilities.dart';
import '../../models/user_model.dart';

class AdminApproveUserProvider extends ChangeNotifier {
  final String user;
  final ApiClient apiClient = ApiClient();

  AdminApproveUserProvider({required this.user});

  bool isLoading = false;
  List<UserModel> unauthenticatedUsers = [];
  List<UserModel> filteredUsers = [];
  String searchQuery = '';

  Future<void> init() async {
    await fetchUnauthenticatedUsers();
  }

  void searchUser(String query) {
    searchQuery = query;
    applySearch();
  }

  void applySearch() {
    if (searchQuery.isEmpty) {
      filteredUsers = List.from(unauthenticatedUsers);
    } else {
      final q = searchQuery.toLowerCase();
      filteredUsers = unauthenticatedUsers.where((u) {
        return u.name.toLowerCase().contains(q) ||
            u.email.toLowerCase().contains(q) ||
            u.id.toString().contains(q);
      }).toList();
    }
    notifyListeners();
  }

  Future<void> fetchUnauthenticatedUsers() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await apiClient.dio.get('/user/all-unauthenticated-$user/');

      if (response.data != null) {
        unauthenticatedUsers = (response.data as List)
            .map((json) => UserModel.fromJson(json))
            .toList();
        filteredUsers = List.from(unauthenticatedUsers);
      }
    } catch (e) {
      debugPrint("Fetch Error: $e");
      showSnackBarGlobal('Failed', 'Could not load users');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> approveUnauthenticatedUser(int id) async {
    _performAction('/user/approve-unauthenticated-user/', id);
  }

  Future<void> declineUnauthenticatedUser(int id) async {
    _performAction('/user/decline-unauthenticated-user/', id);
  }

  // Private helper to avoid code duplication for Approve/Decline
  Future<void> _performAction(String url, int id) async {
    isLoading = true;
    notifyListeners();

    try {
      await apiClient.dio.put(
        url,
        options: Options(contentType: Headers.jsonContentType),
        data: {'id': [id]},
      );

      unauthenticatedUsers.removeWhere((u) => u.id == id);
      applySearch(); // Updates filtered list based on current search
      showSnackBarGlobal('Success', 'Action performed successfully');
    } catch (e) {
      showSnackBarGlobal('Failed', 'Transaction failed');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}