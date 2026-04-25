import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../core/function/api_client.dart';
import '../../core/function/utilities.dart';
import '../../models/assignment_model.dart';

class TeacherSubmissionProvider with ChangeNotifier {
  final ApiClient apiClient = ApiClient();
  bool isLoading = false;
  bool isGrading = false;

  // List to hold the fetched submissions
  List<SubmissionResponse> submissions = [];

  Future<void> fetchSubmissionsByAssignment(int assignmentId) async {
    isLoading = true;
    submissions = []; // Clear old data
    notifyListeners();

    try {
      // Matching your backend route: /assignment{id}/
      final response = await apiClient.dio.get('/submission/assignment$assignmentId/');

      if (response.statusCode == 200) {
        submissions = (response.data as List)
            .map((e) => SubmissionResponse.fromJson(e))
            .toList();
      }
    } on DioException catch (e) {
      showSnackBarGlobal("Error", e.response?.data['detail'] ?? "Failed to fetch submissions");
    } catch (e) {
      showSnackBarGlobal("Error", "An unexpected error occurred");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> gradeSubmission(int submissionId, double grade) async {
    isGrading = true;
    notifyListeners();
    try {
      await apiClient.dio.put('/submission/grade/$submissionId/', data: {"grade": grade});
      showSnackBarGlobal("Success", "Grade updated successfully");
      // Optionally refresh the list after grading
    } on DioException catch (e) {
      showSnackBarGlobal("Error", "Failed to update grade");
    } finally {
      isGrading = false;
      notifyListeners();
    }
  }
}