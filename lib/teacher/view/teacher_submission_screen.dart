import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constant/app_color.dart';
import '../provider/teacher_submission_provider.dart';

class SubmissionsScreen extends StatefulWidget {
  final int assignmentId;
  final String title;
  const SubmissionsScreen({super.key, required this.assignmentId, required this.title});

  @override
  State<SubmissionsScreen> createState() => _SubmissionsScreenState();
}

class _SubmissionsScreenState extends State<SubmissionsScreen> {
  @override
  void initState() {
    super.initState();
    // Use the new Provider here
    Future.microtask(() =>
        context.read<TeacherSubmissionProvider>().fetchSubmissionsByAssignment(widget.assignmentId)
    );
  }

  @override
  Widget build(BuildContext context) {
    // Watch the Submission provider
    final provider = context.watch<TeacherSubmissionProvider>();


    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.black, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.submissions.isEmpty // Using the list from the new provider
          ? _buildEmptyState()
          : RefreshIndicator(
        onRefresh: () => provider.fetchSubmissionsByAssignment(widget.assignmentId),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: provider.submissions.length,
          itemBuilder: (context, index) {
            final sub = provider.submissions[index];
            return _buildSubmissionItem(sub);
          },
        ),
      ),
    );
  }
  Widget _buildSubmissionItem(dynamic sub) {
    bool isGraded = sub.grade != null;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: isGraded ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
            child: Icon(Icons.person, color: isGraded ? Colors.green : Colors.orange),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Student ID: ${sub.studentId}", style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(isGraded ? "Score: ${sub.grade}/100" : "Pending Review", style: TextStyle(fontSize: 12, color: isGraded ? Colors.green : Colors.orange)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.file_download_outlined, color: Colors.blue),
            onPressed: () { /* URL Launch Logic */ },
          ),
          const Icon(Icons.more_vert, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.folder_open, size: 80, color: Colors.grey.withOpacity(0.5)),
          const SizedBox(height: 10),
          const Text("No submissions yet", style: TextStyle(color: Colors.grey, fontSize: 16)),
        ],
      ),
    );
  }
}