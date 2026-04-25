import 'package:CampusX/teacher/view/teacher_assignment_screen.dart';
import 'package:CampusX/teacher/view/teacher_courses_screen.dart';
import 'package:CampusX/teacher/view/teacher_dashboard_screen.dart';
import 'package:CampusX/teacher/view/teacher_profile_screen.dart';
import 'package:flutter/cupertino.dart';

class TeacherHomeProvider with ChangeNotifier{

  int _index = 0 ;

  int get index => _index;

  void changeIndex(int newIndex){

    _index=newIndex;
    notifyListeners();

  }


  final List<Widget> screens = [
    TeacherDashboardScreen(),
    TeacherCoursesScreen(),
    TeacherAssignmentScreen(),
    TeacherProfileScreen(),

  ];

}