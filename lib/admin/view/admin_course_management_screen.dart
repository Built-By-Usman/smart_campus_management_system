import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../core/constant/app_color.dart';
import '../../core/function/utilities.dart';
import '../../models/course_model.dart';
import '../../models/user_model.dart';
import '../provider/admin_course_management_provider.dart';

class AdminCourseManagementScreen extends StatefulWidget {
  const AdminCourseManagementScreen({super.key});

  @override
  State<AdminCourseManagementScreen> createState() => _AdminCourseManagementScreenState();
}

class _AdminCourseManagementScreenState extends State<AdminCourseManagementScreen> {
  late AdminCourseManagementProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = AdminCourseManagementProvider();
    _provider.fetchCourses();
    _provider.fetchTeachers();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Consumer<AdminCourseManagementProvider>(
        builder: (context, controller, child) {
          return Scaffold(
            backgroundColor: AppColor.background,
            appBar: AppBar(
              backgroundColor: AppColor.white,
              elevation: 0,
              centerTitle: false,
              title: _buildAppBarTitle(),
            ),
            body: controller.isLoading
                ?  Center(child: CircularProgressIndicator(color: AppColor.blue,))
                : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Courses Management',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    _buildSearchBar(controller),
                    const SizedBox(height: 12),
                    _buildCreateButton(),
                    const SizedBox(height: 10),

                    Expanded(
                      child: RefreshIndicator(
                        color: AppColor.blue,
                        onRefresh: controller.fetchCourses,
                        child: _buildCourseList(controller.filteredCourses),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBarTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(color: AppColor.blue, borderRadius: BorderRadius.circular(12)),
              width: 35, height: 35,
              child: SvgPicture.asset('assets/icons/logo.svg'),
            ),
            const SizedBox(width: 10),
            Text('Smart Campus', style: TextStyle(color: AppColor.blue, fontWeight: FontWeight.bold)),
          ],
        ),
        const CircleAvatar(radius: 15, backgroundImage: AssetImage('assets/images/avatar.png')),
      ],
    );
  }

  Widget _buildSearchBar(AdminCourseManagementProvider controller) {
    return TextField(
      onChanged: (val) => controller.searchCourses(val),
      decoration: InputDecoration(
        hintText: 'Search courses by code or name',
        prefixIcon: Icon(Icons.search, color: AppColor.subHeading),
        isDense: true,
        filled: true,
        fillColor: AppColor.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildCreateButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.blue,
          padding: const EdgeInsets.symmetric(vertical: 13),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: _showAddCourseDialog,
        label: const Text('Create New Course', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildCourseList(List<CourseModel> list) {
    if (list.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(), // Important for RefreshIndicator
        children: const [
          SizedBox(height: 100),
          Center(child: Text("No courses found", style: TextStyle(color: Colors.grey))),
        ],
      );
    }
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: list.length,
      itemBuilder: (context, index) => _buildCourseCard(list[index]),
    );
  }

  Widget _buildCourseCard(CourseModel course) {
    return Card(
      color: AppColor.white,
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.outline.withOpacity(0.2),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
              ),
              child: Icon(Icons.menu_book_rounded, size: 50, color: AppColor.blue.withOpacity(0.5)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(course.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                    Icon(Icons.edit_outlined, color: AppColor.blue, size: 22),
                  ],
                ),
                const SizedBox(height: 4),
                Text("Code: ${course.courseCode}", style: TextStyle(color: AppColor.subHeading)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.person_pin, size: 18, color: AppColor.blue),
                    const SizedBox(width: 8),
                    Text(
                      course.teacherName ?? 'Not Assigned',
                      style: TextStyle(color: AppColor.blue, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// ... (Keep your _showAddCourseDialog and _buildDialogTextField here)


  void _showAddCourseDialog() {
    final nameController = TextEditingController();
    final codeController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return ChangeNotifierProvider.value(
          value: _provider,
          child: Consumer<AdminCourseManagementProvider>(
            builder: (context, provider, child) {
              return AlertDialog(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create New Course",
                      style: TextStyle(
                        color: AppColor.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Fill in the details to add a new curriculum",
                      style: TextStyle(color: AppColor.subHeading, fontSize: 13),
                    ),
                  ],
                ),
                content: SizedBox(
                  width: MediaQuery.of(context).size.width, // Ensures proper width on mobile
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 16),

                        /// COURSE NAME FIELD
                        _buildDialogTextField(
                          controller: nameController,
                          label: "Course Name",
                          hint: "e.g. Advanced Mathematics",
                          icon: Icons.book_outlined,
                        ),
                        const SizedBox(height: 20),

                        /// COURSE CODE FIELD
                        _buildDialogTextField(
                          controller: codeController,
                          label: "Course Code",
                          hint: "e.g. MATH-101",
                          icon: Icons.qr_code_scanner,
                        ),
                        const SizedBox(height: 20),

                        /// TEACHER DROPDOWN
                        DropdownButtonFormField<UserModel>(
                          isExpanded: true, // Prevents overflow if names are long
                          dropdownColor: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          icon: Icon(Icons.keyboard_arrow_down_rounded, color: AppColor.blue),
                          style: const TextStyle(color: Colors.black, fontSize: 15),
                          decoration: InputDecoration(
                            labelText: "Assigned Teacher",
                            labelStyle: TextStyle(color: AppColor.blue, fontWeight: FontWeight.w600),
                            prefixIcon: Icon(Icons.person_outline, color: AppColor.blue),
                            filled: true,
                            fillColor: AppColor.background,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: AppColor.outline.withOpacity(0.5)),
                            ),
                          ),
                          value: provider.selectedTeacher,
                          items: provider.teachersList.map((teacher) {
                            return DropdownMenuItem<UserModel>(
                              value: teacher,
                              child: Row(
                                children: [
                                  // Small circle with initials or icon
                                  CircleAvatar(
                                    radius: 14,
                                    backgroundColor: AppColor.blue.withOpacity(0.1),
                                    child: Text(
                                      teacher.name.isNotEmpty ? teacher.name[0].toUpperCase() : "?",
                                      style: TextStyle(color: AppColor.blue, fontSize: 12, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  // Name and Email column
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          teacher.name,
                                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                                        ),
                                        Text(
                                          teacher.email,
                                          style: TextStyle(color: AppColor.subHeading, fontSize: 11),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) => provider.setSelectedTeacher(value),
                          hint: const Text("Choose a Teacher"),
                          selectedItemBuilder: (BuildContext context) {
                            return provider.teachersList.map<Widget>((teacher) {
                              return Text(
                                teacher.name,
                                style: const TextStyle(fontWeight: FontWeight.w500),
                              );
                            }).toList();
                          },
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                actions: [
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () => Navigator.pop(dialogContext),
                          child: Text("Cancel", style: TextStyle(color: AppColor.subHeading)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.blue,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () {
                            if (nameController.text.isNotEmpty &&
                                codeController.text.isNotEmpty &&
                                provider.selectedTeacher != null) {
                              final newCourse = CourseModel(
                                name: nameController.text,
                                courseCode: codeController.text,
                                teacherId: provider.selectedTeacher!.id,
                              );
                              provider.createNewCourse(newCourse);
                              Navigator.pop(dialogContext);
                            } else {
                              showSnackBarGlobal('Error', 'Please fill all fields');
                            }
                          },
                          child: const Text(
                            "Create",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  /// Helper method to keep dialog code clean
  Widget _buildDialogTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: TextStyle(color: AppColor.blue, fontWeight: FontWeight.w600),
        hintStyle: TextStyle(color: AppColor.subHeading.withOpacity(0.5), fontSize: 13),
        prefixIcon: Icon(icon, color: AppColor.blue),
        filled: true,
        fillColor: AppColor.background,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColor.outline.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColor.blue, width: 1.5),
        ),
      ),
    );
  }
}

