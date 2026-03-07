import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smar_campus_management_system/core/constant/app_color.dart';

class DashboardScreenController extends GetxController {
  final List<Map<String, dynamic>> overview = [
    {
      'heading': 'Total Students',
      'backgroundColor': AppColor.lightBlue,
      'strength': '2000',
      'track':19,
      'icon':Icon(Icons.group_outlined,color: AppColor.blue,)
    },
    {
      'heading': 'Total Teachers',
      'backgroundColor': AppColor.lightPurple,
      'strength': '200',
      'track':-12,
      'icon':Icon(Icons.person_outline,color: AppColor.purple,)
    },
    {
      'heading': 'Active Courses',
      'backgroundColor': AppColor.lightOrange,
      'strength': '20',
      'track':9,
      'icon':Icon(Icons.book_outlined,color: AppColor.orange,)
    },
    {
      'heading': 'Pending Complaints',
      'backgroundColor': AppColor.lightRed,
      'strength': '07',
      'track':-15,
      'icon':Icon(Icons.warning_amber_outlined,color: AppColor.red,)
    },
  ];

  final List<Map<String, dynamic>> recentUsers = [
    {
      'userName': 'Ali Raza',
      'role': 'Student',
      'status': 'online',
    },
    {
      'userName': 'Dr. Sarah Khan',
      'role': 'Teacher',
      'status': 'online',
    },
    {
      'userName': 'Ahmed Hassan',
      'role': 'Student',
      'status': 'offline',
    },
    {
      'userName': 'Fatima Noor',
      'role': 'Admin',
      'status': 'online',
    },
  ];
  final List<Map<String, dynamic>> recentComplaints = [
    {
      'id': 'CMP-001',
      'subject': 'WiFi not working in Block A',
      'priority': 'High',
    },
    {
      'id': 'CMP-002',
      'subject': 'Projector issue in Room 204',
      'priority': 'Medium',
    },
    {
      'id': 'CMP-003',
      'subject': 'Water leakage in washroom',
      'priority': 'High',
    },
    {
      'id': 'CMP-004',
      'subject': 'Library AC maintenance required',
      'priority': 'Low',
    },
    {
      'id': 'CMP-005',
      'subject': 'Cafeteria hygiene concern',
      'priority': 'Medium',
    },
  ];
}
