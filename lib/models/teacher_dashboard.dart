import 'package:CampusX/models/submission_model.dart';

class TeacherDashboardModel {
  final int totalCourses;
  final int totalAssignments;
  final int totalSubmissions;
  final List<SubmissionModel> recentSubmissions;

  TeacherDashboardModel({
    required this.totalCourses,
    required this.totalAssignments,
    required this.totalSubmissions,
    required this.recentSubmissions,
  });

  factory TeacherDashboardModel.fromJson(Map<String, dynamic> json) {
    return TeacherDashboardModel(
      totalCourses: json['total_courses'] ?? 0,
      totalAssignments: json['total_assignments'] ?? 0,
      totalSubmissions: json['total_submissions'] ?? 0,
      recentSubmissions: (json['recent_submissions'] as List?)
          ?.map((item) => SubmissionModel.fromJson(item))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_courses': totalCourses,
      'total_assignments': totalAssignments,
      'total_submissions': totalSubmissions,
      'recent_submissions': recentSubmissions.map((e) => e.toJson()).toList(),
    };
  }
}

class Submission{
  final int id;
  final int assignmentId;
  final int studentId;
  final String fileUrl;
  final double? grade;

  Submission({
    required this.id,
    required this.assignmentId,
    required this.studentId,
    required this.fileUrl,
    this.grade,
  });

  factory Submission.fromJson(Map<String, dynamic> json) {
    return Submission(
      id: json['id'],
      assignmentId: json['assignment_id'],
      studentId: json['student_id'],
      fileUrl: json['file_url'].toString(),
      grade: json['grade'] != null ? (json['grade'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'assignment_id': assignmentId,
      'student_id': studentId,
      'file_url': fileUrl,
      'grade': grade,
    };
  }
}