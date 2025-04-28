import 'package:flutter/material.dart';
import 'package:lms/EmployeeLeaves/LeaveRequestItem.dart';
import 'package:lms/model/leaveRequestModel.dart';


class LeaveRequestsBox extends StatelessWidget {
  final List<LeaveRequest> leaveRequests;
  final String leaveType;

  LeaveRequestsBox({required this.leaveRequests, required this.leaveType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: leaveRequests.reversed.map((leaveRequest) {
        return LeaveRequestItem(leaveRequest: leaveRequest);
      }).toList(),
    );
  }
}