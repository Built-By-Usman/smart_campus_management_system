import 'package:get/get.dart';

class UserManagementScreenController extends GetxController{

  var selectedRole = 'All Roles'.obs;
  var selectedStatus = "Active".obs;


  final List<String> roles = [
    'All Roles',
    'Teachers',
    'Students',
    'Admins'
  ];

  final List<String> statuses = [
    "Active",
    "Online",
    "Offline"
  ];

  final List<Map<String,dynamic>> users = [
    {
      'image':'assets/images/users/1.png',
      'name': 'Sara johnson',
      'email':'sarah.j@uos.edu.pk',
      'role':'Student',
      'status':'Active',
      'last_login':'2 hours ago'
    },
    {
      'image': 'assets/images/users/2.png',
      'name': 'Ali Khan',
      'email': 'ali.khan@uos.edu.pk',
      'role': 'Teacher',
      'status': 'Active',
      'last_login': '45 minutes ago'
    },
    {
      'image': 'assets/images/users/3.png',
      'name': 'Fatima Ahmed',
      'email': 'fatima.ahmed@uos.edu.pk',
      'role': 'Admin',
      'status': 'Inactive',
      'last_login': '1 day ago'
    },
  ];

  void changeStatus(String? value){
    if(value!=null){
      selectedStatus.value=value;
    }
  }

  void changeRole(String? value){
    if(value!=null){
      selectedRole.value=value;
    }
  }



}