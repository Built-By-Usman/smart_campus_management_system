class CourseModel {
  final int? id;
  final String courseCode;
  final String name;
  final String? teacherName;
  final int teacherId;

  CourseModel({
    this.id,
    required this.courseCode,
    required this.name,
    this.teacherName,
    required this.teacherId,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      courseCode: json['course_code'] ?? '',
      name: json['name'] ?? '',
      teacherName: json['teacher_name'],
      teacherId: json['teacher_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "course_code": courseCode,
      "teacher_id": teacherId,
    };
  }
}