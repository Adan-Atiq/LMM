import 'package:flutter/material.dart';
import 'AppColor.dart'; // Import the AppColors file
import 'EmployeeLeaves/HomePage.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leave Management System',
      home: LeaveManagementScreen(),
    );
  }
}



