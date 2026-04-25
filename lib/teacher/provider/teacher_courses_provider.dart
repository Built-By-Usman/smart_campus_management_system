import 'package:flutter/material.dart';
import '../../core/function/api_client.dart';
import '../../core/function/utilities.dart';
import '../../models/course_model.dart';
import '../../models/user_model.dart';

class TeacherCoursesProvider extends ChangeNotifier {
  final ApiClient apiClient = ApiClient();
  bool isLoading = false;

  List<CourseModel> allCourses = [];
  List<CourseModel> filteredCourses = [];


  Future<void> fetchCourses() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await apiClient.dio.get('/course/get-teacher-courses/');
      allCourses = (response.data as List)
          .map((json) => CourseModel.fromJson(json))
          .toList();
      filteredCourses = List.from(allCourses);
    } catch (e) {
      showSnackBarGlobal('Error', 'Failed to load courses');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void searchCourses(String query) {
    if (query.isEmpty) {
      filteredCourses = List.from(allCourses);
    } else {
      filteredCourses = allCourses
          .where((course) =>
      course.name.toLowerCase().contains(query.toLowerCase()) ||
          course.courseCode.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}