class ComplaintModel {
  int id;
  int studentId;
  String title;
  String description;
  String status;

  ComplaintModel({
    required this.id,
    required this.studentId,
    required this.title,
    required this.description,
    required this.status,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['id'] ?? 0,
      studentId: json['student_id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? 'pending',
    );
  }

  // To JSON (Map)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'title': title,
      'description': description,
      'status': status,
    };
  }

}