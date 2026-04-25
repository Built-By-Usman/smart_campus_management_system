class SubmissionModel{
  final int id;
  final int assignmentId;
  final int studentId;
  final String fileUrl;
  final double? grade;

  SubmissionModel({
    required this.id,
    required this.assignmentId,
    required this.studentId,
    required this.fileUrl,
    this.grade,
  });

  factory SubmissionModel.fromJson(Map<String, dynamic> json) {
    return SubmissionModel(
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