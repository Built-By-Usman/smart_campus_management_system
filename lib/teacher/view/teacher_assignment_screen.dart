import 'package:CampusX/teacher/view/teacher_submission_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../core/constant/app_color.dart';
import '../../core/function/utilities.dart';
import '../../models/course_model.dart';
import '../provider/teacher_assignment_provider.dart';

class TeacherAssignmentScreen extends StatefulWidget {
  const TeacherAssignmentScreen({super.key});

  @override
  State<TeacherAssignmentScreen> createState() => _TeacherAssignmentScreenState();
}

class _TeacherAssignmentScreenState extends State<TeacherAssignmentScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  DateTime? _selectedDate;
  CourseModel? _selectedCourse;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final p = context.read<TeacherAssignmentProvider>();
      p.fetchTeacherAssignments();
      p.fetchTeacherCourses();
    });
  }

  // --- 1. MODERN ASSIGNMENT DETAILS DIALOG ---
  void _showAssignmentDetails(dynamic assignment) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: AppColor.white,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: AppColor.lightBlue, borderRadius: BorderRadius.circular(12)),
                    child: Text("Details", style: TextStyle(color: AppColor.blue, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, size: 20))
                ],
              ),
              const SizedBox(height: 16),
              Text(assignment.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColor.black)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.calendar_month, size: 16, color: AppColor.subHeading),
                  const SizedBox(width: 8),
                  Text("Due: ${DateFormat('MMMM dd, yyyy').format(assignment.dueDate)}",
                      style: TextStyle(color: AppColor.subHeading, fontSize: 14)),
                ],
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Divider()),
              Text("Description", style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.blue)),
              const SizedBox(height: 8),
              Text(
                assignment.description.isEmpty ? "No description provided." : assignment.description,
                style: TextStyle(color: AppColor.black.withOpacity(0.7), height: 1.5),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 14)
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    _navigateToSubmissions(assignment);
                  },
                  child: const Text("Go to Submissions", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToSubmissions(dynamic assignment) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubmissionsScreen(
          assignmentId: assignment.id,
          title: assignment.title,
        ),
      ),
    );
  }

  void _showCreateAssignmentSheet(BuildContext context) {
    _selectedCourse = null;
    _selectedDate = null;
    _titleController.clear();
    _descController.clear();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) {
          final provider = context.watch<TeacherAssignmentProvider>();

          return Container(
            decoration: BoxDecoration(
              color: AppColor.background,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            ),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              left: 24, right: 24, top: 12,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColor.lightGrey, borderRadius: BorderRadius.circular(10)))),
                const SizedBox(height: 20),
                Text("New Assignment", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.blue)),
                const SizedBox(height: 24),

                // --- IMPROVED DROPDOWN ---
                _buildInputLabel("Target Course"),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColor.outline),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<CourseModel>(
                      isExpanded: true,
                      hint: Text("Select Course", style: TextStyle(color: AppColor.subHeading)),
                      value: _selectedCourse,
                      icon: Icon(Icons.keyboard_arrow_down_rounded, color: AppColor.blue),
                      borderRadius: BorderRadius.circular(16), // Rounded dropdown menu
                      dropdownColor: AppColor.white,
                      elevation: 8,
                      items: provider.teacherCourses.map((course) {
                        return DropdownMenuItem(
                          value: course,
                          child: Row(
                            children: [
                              Icon(Icons.book_outlined, size: 18, color: AppColor.blue),
                              const SizedBox(width: 12),
                              Text("${course.name} (${course.courseCode})", style: const TextStyle(fontWeight: FontWeight.w500)),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (val) => setSheetState(() => _selectedCourse = val),
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                _buildInputLabel("Title"),
                _buildModernTextField(_titleController, "Assignment title", Icons.edit_note_rounded),

                const SizedBox(height: 16),
                _buildInputLabel("Description (Optional)"),
                _buildModernTextField(_descController, "Add requirements...", Icons.description_outlined, maxLines: 3),

                const SizedBox(height: 16),
                _buildInputLabel("Deadline"),
                InkWell(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now().add(const Duration(days: 1)),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                      builder: (context, child) => Theme(
                        data: Theme.of(context).copyWith(colorScheme: ColorScheme.light(primary: AppColor.blue)),
                        child: child!,
                      ),
                    );
                    if (date != null) setSheetState(() => _selectedDate = date);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: AppColor.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColor.outline)),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today_rounded, size: 20, color: AppColor.blue),
                        const SizedBox(width: 12),
                        Text(_selectedDate == null ? "Set deadline" : DateFormat('EEEE, d MMMM').format(_selectedDate!),
                            style: TextStyle(color: _selectedDate == null ? AppColor.subHeading : AppColor.black, fontWeight: FontWeight.w500)),
                        const Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColor.subHeading),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColor.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 0),
                    onPressed: provider.isLoading ? null : () async {
                      if (_titleController.text.isEmpty || _selectedDate == null || _selectedCourse == null) {
                        showSnackBarGlobal("Error", "Missing required fields");
                        return;
                      }
                      final success = await provider.createAssignment({
                        "title": _titleController.text,
                        "description": _descController.text,
                        "due_date": _selectedDate!.toIso8601String(),
                        "course_id": _selectedCourse!.id,
                      });
                      if (success) Navigator.pop(context);
                    },
                    child: provider.isLoading
                        ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : const Text("Publish", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(padding: const EdgeInsets.only(left: 4, bottom: 8), child: Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColor.subHeading)));
  }

  Widget _buildModernTextField(TextEditingController controller, String hint, IconData icon, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AppColor.subHeading.withOpacity(0.5)),
        prefixIcon: Icon(icon, color: AppColor.blue, size: 22),
        filled: true,
        fillColor: AppColor.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: AppColor.outline)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: AppColor.blue, width: 1.5)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TeacherAssignmentProvider>();
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        elevation: 0,
        title: Text("Assignments", style: TextStyle(color: AppColor.blue, fontWeight: FontWeight.bold, fontSize: 24)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton.filled(
              onPressed: () => _showCreateAssignmentSheet(context),
              style: IconButton.styleFrom(backgroundColor: AppColor.blue, foregroundColor: Colors.white),
              icon: const Icon(Icons.add),
            ),
          )
        ],
      ),
      body: provider.isLoading && provider.assignments.isEmpty
          ?  Center(child: CircularProgressIndicator(color: AppColor.blue,))
          : RefreshIndicator(
        onRefresh: provider.fetchTeacherAssignments,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: provider.assignments.length,
          itemBuilder: (context, index) => _buildAssignmentCard(provider.assignments[index]),
        ),
      ),
    );
  }

  Widget _buildAssignmentCard(dynamic assignment) {
    final bool isOverdue = assignment.dueDate.isBefore(DateTime.now());

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColor.outline),
        boxShadow: [BoxShadow(color: AppColor.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: InkWell(
        onTap: () => _showAssignmentDetails(assignment), // TAP CARD SHOWS DIALOG
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 48, width: 48,
                    decoration: BoxDecoration(color: AppColor.lightBlue, borderRadius: BorderRadius.circular(14)),
                    child: Icon(Icons.assignment_rounded, color: AppColor.blue),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(assignment.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                        const SizedBox(height: 2),
                        Text("Course ID: ${assignment.courseId}", style: TextStyle(color: AppColor.subHeading, fontSize: 13)),
                      ],
                    ),
                  ),
                  _buildStatusBadge(isOverdue),
                ],
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(height: 1)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_today_outlined, size: 14, color: AppColor.subHeading),
                      const SizedBox(width: 6),
                      Text("Due ${DateFormat('MMM dd').format(assignment.dueDate)}",
                          style: TextStyle(color: AppColor.subHeading, fontSize: 13, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => _navigateToSubmissions(assignment), // TAP TEXT NAVIGATES
                    child: Text("View Submissions", style: TextStyle(color: AppColor.blue, fontSize: 13, fontWeight: FontWeight.bold)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(bool isOverdue) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: isOverdue ? AppColor.lightRed : AppColor.lightGreen, borderRadius: BorderRadius.circular(20)),
      child: Text(isOverdue ? "Closed" : "Active", style: TextStyle(color: isOverdue ? AppColor.red : AppColor.green, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }
}