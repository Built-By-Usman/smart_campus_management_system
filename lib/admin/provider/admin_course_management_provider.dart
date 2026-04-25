import 'package:flutter/material.dart';
import '../../core/function/api_client.dart';
import '../../core/function/utilities.dart';
import '../../models/course_model.dart';
import '../../models/user_model.dart';

class AdminCourseManagementProvider extends ChangeNotifier {
  final ApiClient apiClient = ApiClient();
  bool isLoading = false;

  late TabController tabController;
  final List<Tab> coursesTab = [
    const Tab(text: 'All Courses'),
    const Tab(text: 'Active'),
    const Tab(text: 'Archived'),
  ];

  List<CourseModel> allCourses = [];
  List<CourseModel> filteredCourses = [];

  // Logic for Teachers Dropdown
  List<UserModel> teachersList = [];
  UserModel? selectedTeacher;

  void initTabController(TickerProvider vsync) {
    tabController = TabController(length: coursesTab.length, vsync: vsync);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) notifyListeners();
    });
    fetchCourses();
    fetchTeachers(); // Fetch teachers list on init
  }

  Future<void> fetchTeachers() async {
    try {
      final response = await apiClient.dio.get('/user/all-teachers/'); // Adjust URL if needed
      if (response.data != null) {
        teachersList = (response.data as List)
            .map((json) => UserModel.fromJson(json))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Fetch Teachers Error: $e");
    }
  }

  // Update selected teacher in dropdown
  void setSelectedTeacher(UserModel? teacher) {
    selectedTeacher = teacher;
    notifyListeners();
  }

  Future<void> fetchCourses() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await apiClient.dio.get('/course/');
      allCourses = (response.data as List)
          .map((json) => CourseModel.fromJson(json))
          .toList();
      filteredCourses = List.from(allCourses);
    } catch (e) {
      showSnackBarGlobal('Error', 'Failed to load courses');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createNewCourse(CourseModel newCourse) async {
    isLoading = true;
    notifyListeners();
    try {
      await apiClient.dio.post('/course/', data: newCourse.toJson());
      showSnackBarGlobal('Success', 'Course created successfully');
      selectedTeacher = null; // Reset selection
      await fetchCourses();
    } catch (e) {
      showSnackBarGlobal('Failed', 'API Error: Could not create course');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  void searchCourses(String query) {
    if (query.isEmpty) {
      filteredCourses = List.from(allCourses);
    } else {
      filteredCourses = allCourses
          .where((course) =>
      course.name.toLowerCase().contains(query.toLowerCase()) ||
          course.courseCode.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}