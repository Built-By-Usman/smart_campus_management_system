class AssignmentResponse {
  final int id;
  final String title;
  final String description;
  final DateTime dueDate;
  final int courseId;
  final int teacherId;

  AssignmentResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.courseId,
    required this.teacherId,
  });

  factory AssignmentResponse.fromJson(Map<String, dynamic> json) {
    return AssignmentResponse(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      dueDate: DateTime.parse(json['due_date']),
      courseId: json['course_id'],
      teacherId: json['teacher_id'],
    );
  }
}

class SubmissionResponse {
  final int id;
  final int assignmentId;
  final int studentId;
  final String fileUrl;
  final double? grade;

  SubmissionResponse({
    required this.id,
    required this.assignmentId,
    required this.studentId,
    required this.fileUrl,
    this.grade,
  });

  factory SubmissionResponse.fromJson(Map<String, dynamic> json) {
    return SubmissionResponse(
      id: json['id'],
      assignmentId: json['assignment_id'],
      studentId: json['student_id'],
      fileUrl: json['file_url'].toString(),
      grade: json['grade'] != null ? (json['grade'] as num).toDouble() : null,
    );
  }
}