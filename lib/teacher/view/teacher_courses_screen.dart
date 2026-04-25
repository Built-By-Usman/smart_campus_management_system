import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../core/constant/app_color.dart';
import '../../models/course_model.dart';
import '../provider/teacher_courses_provider.dart';

class TeacherCoursesScreen extends StatefulWidget {
  const TeacherCoursesScreen({super.key});

  @override
  State<TeacherCoursesScreen> createState() => _TeacherCoursesScreenState();
}

class _TeacherCoursesScreenState extends State<TeacherCoursesScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask((){
      Provider.of<TeacherCoursesProvider>(context, listen: false).fetchCourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TeacherCoursesProvider>(
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
              ? Center(child: CircularProgressIndicator(color: AppColor.blue))
              : SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'My Courses',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  _buildSearchBar(controller),
                  const SizedBox(height: 12),
                  Expanded(
                    child: RefreshIndicator(
                      color: AppColor.blue,
                      onRefresh: () => controller.fetchCourses(),
                      child: _buildCourseList(controller.filteredCourses),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
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

  Widget _buildSearchBar(TeacherCoursesProvider controller) {
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

}

