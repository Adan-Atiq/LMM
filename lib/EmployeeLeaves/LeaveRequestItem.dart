import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import '../AppColor.dart'; // Your color definitions
import '../model/leaveRequestModel.dart'; // Your model for LeaveRequest


class LeaveRequestItem extends StatelessWidget {
  final LeaveRequest leaveRequest;

  LeaveRequestItem({required this.leaveRequest});

  int _calculateDaysBetween(DateTime startDate, DateTime endDate) {
    return endDate.difference(startDate).inDays + 1;
  }

  Color _getLeaveTypeColor() {
    switch (leaveRequest.name) {
      case 'Annual Leave':
        return AppColors.annualLeaveColor;
      case 'Casual Leave':
        return AppColors.casualLeaveColor;
      case 'Sick Leave':
        return AppColors.sickLeaveColor;
      case 'Maternity Leave':
        return AppColors.maternityLeaveColor;
      default:
        return Colors.white;
    }
  }

  Color _getLeaveTypeBackgroundColor() {
    switch (leaveRequest.name) {
      case 'Annual Leave':
        return AppColors.annualLeaveBackgroundColor;
      case 'Casual Leave':
        return AppColors.casualLeavebckgroundColor;
      case 'Sick Leave':
        return AppColors.sickLeaveBackgroundColor;
      case 'Maternity Leave':
        return AppColors.maternityLeaveBackgroundColor;
      default:
        return Colors.white;
    }
  }

  Color _getLeaveTypeBorderColor() {
    switch (leaveRequest.name) {
      case 'Annual Leave':
        return AppColors.annualLeaveColor;
      case 'Casual Leave':
        return AppColors.casualLeaveColor;
      case 'Sick Leave':
        return AppColors.sickLeaveColor;
      case 'Maternity Leave':
        return AppColors.maternityLeaveColor;
      default:
        return Colors.grey; // Default border color
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd MMM yyyy');

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReasonImageScreen(
              reason: leaveRequest.reason,
              imagePaths: leaveRequest.imagePaths,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Space on left and right
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _getLeaveTypeBackgroundColor(),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _getLeaveTypeBorderColor(), // Apply border color based on leave type
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side with leave details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Number of days
                  Text(
                    '${_calculateDaysBetween(leaveRequest.startDate, leaveRequest.endDate)} Days Application',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 4),
                  // Start Date - End Date
                  Text(
                    '${formatter.format(leaveRequest.startDate)} - ${formatter.format(leaveRequest.endDate)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  // Leave Type
                  Text(
                    leaveRequest.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _getLeaveTypeColor(),
                    ),
                  ),
                ],
              ),
              // Right side with status
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Status Box
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getLeaveTypeColor(),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      leaveRequest.status,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class ReasonImageScreen extends StatelessWidget {
  final String reason;
  final List<String>? imagePaths;

  ReasonImageScreen({required this.reason, this.imagePaths});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            width: screenWidth * 0.9,  // 90% of screen width
            height: screenHeight * 0.8, // 90% of screen height
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reason:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  reason,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                if (imagePaths != null && imagePaths!.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Attached Image:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        height: (screenHeight * 0.9) * 0.6, // 60% of the container height for the image
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: InteractiveViewer(
                          child: Image.file(
                            File(imagePaths![0]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}