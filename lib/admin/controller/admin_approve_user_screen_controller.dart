import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../core/function/api_client.dart';
import '../../core/function/utilities.dart';
import '../../models/user_model.dart';

class AdminApproveUserScreenController extends GetxController {
  String user = '';

  AdminApproveUserScreenController({required this.user});

  final ApiClient apiClient = ApiClient();

  var isLoading = false.obs;
  RxList<UserModel> unauthenticatedUsers = <UserModel>[].obs;
  RxList<UserModel> filteredUsers = <UserModel>[].obs;

  var searchQuery = ''.obs;

  @override
  void onInit() {
    fetchUnauthenticatedUsers();
    super.onInit();
  }

  void searchUser(String query) {
    searchQuery.value = query;
    List<UserModel> users = unauthenticatedUsers.toList();
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

  Future<void> fetchUnauthenticatedUsers() async {
    isLoading.value = true;
    try {
      final response = await apiClient.dio.get(
        '/user/all-unauthenticated-$user/',
      );

      final data = response.data;

      List<UserModel> fetchedUsers = (data as List)
          .map((json) => UserModel.fromJson(json))
          .toList();

      unauthenticatedUsers.value = fetchedUsers;
      filteredUsers.value = unauthenticatedUsers;
    } on DioException catch (e) {
      print(e.response!.data);
      if (e.response != null && e.response!.data != null) {
        String errorMessage = e.response!.data['detail'] ?? 'Unknown Error';
        showSnackBar('Failed', errorMessage);
      } else {
        showSnackBar('Failed', 'Unknown Error occurred');
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> approveUnauthenticatedUser(int id) async {
    isLoading.value = true;
    try {
      await apiClient.dio.put(
        '/user/approve-unauthenticated-user/',
        options: Options(contentType: Headers.jsonContentType),
        data: {
          'id': [id],
        },
      );
  filteredUsers.removeWhere((user)=>user.id==id);
  unauthenticatedUsers.removeWhere((user)=>user.id==id);
  filteredUsers.refresh();
  unauthenticatedUsers.refresh();


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

  Future<void> declineUnauthenticatedUser(int id) async {
    isLoading.value = true;
    try {
      await apiClient.dio.put(
        '/user/decline-unauthenticated-user/',
        options: Options(contentType: Headers.jsonContentType),
        data: {
          'id': [id],
        },
      );
      filteredUsers.removeWhere((user)=>user.id==id);
      unauthenticatedUsers.removeWhere((user)=>user.id==id);
      filteredUsers.refresh();
      unauthenticatedUsers.refresh();


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


}
