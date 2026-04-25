import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../core/function/api_client.dart';
import '../../core/function/utilities.dart';
import '../../models/assignment_model.dart';
import '../../models/course_model.dart'; // Ensure this is imported

class TeacherAssignmentProvider with ChangeNotifier {
  final ApiClient apiClient = ApiClient();
  bool isLoading = false;

  List<AssignmentResponse> assignments = [];
  List<SubmissionResponse> currentSubmissions = [];
  List<CourseModel> teacherCourses = []; // Store teacher's courses

  Future<void> fetchTeacherAssignments() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await apiClient.dio.get('/assignments/teacher-assignments/');
      assignments = (response.data as List)
          .map((e) => AssignmentResponse.fromJson(e))
          .toList();
    } on DioException catch (e) {
      showSnackBarGlobal('Error', e.response?.data['detail'] ?? 'Failed to load assignments');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // New method to fetch courses for the dropdown
  Future<void> fetchTeacherCourses() async {
    try {
      final response = await apiClient.dio.get('/course/get-teacher-courses/');
      teacherCourses = (response.data as List)
          .map((json) => CourseModel.fromJson(json))
          .toList();
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching courses: $e");
    }
  }

  Future<bool> createAssignment(Map<String, dynamic> data) async {
    isLoading = true;
    notifyListeners();
    try {
      // Data passed here now only contains title, description, due_date, and course_id
      await apiClient.dio.post('/assignments/', data: data);
      await fetchTeacherAssignments();
      showSnackBarGlobal('Success', 'Assignment created successfully');
      return true;
    } on DioException catch (e) {
      showSnackBarGlobal('Error', e.response?.data['detail'] ?? 'Creation failed');
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchSubmissions(int assignmentId) async {
    isLoading = true;
    currentSubmissions = [];
    notifyListeners();
    try {
      final response = await apiClient.dio.get('/submission/all/$assignmentId/');
      currentSubmissions = (response.data as List)
          .map((e) => SubmissionResponse.fromJson(e))
          .toList();
    } on DioException catch (e) {
      showSnackBarGlobal('Error', 'Could not load submissions');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}