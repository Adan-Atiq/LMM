import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../AppColor.dart';
import '../Attendence/AttendencePage.dart';
import '../ProfileUI/ProfilePage.dart';
import 'LeaveForm.dart';
import 'LeaveRequestsBox.dart';
import 'LeaveType.dart';
import '../model/leaveRequestModel.dart';
import '../HODleaveRequest/LeaveRequestsItemPage.dart'; // Import the new page
import '../EducationDetails/EducationDetailPage.dart'; // Import the EducationDetailPage


class LeaveManagementScreen extends StatefulWidget {
  @override
  _LeaveManagementScreenState createState() => _LeaveManagementScreenState();
}

class _LeaveManagementScreenState extends State<LeaveManagementScreen> {
  List<LeaveRequest> leaveRequests = [];

  @override
  void initState() {
    super.initState();
    // Initialize with some dummy data
    leaveRequests = [
      LeaveRequest(
        id: 1,
        type: 1,
        name: 'Annual Leave',
        totalLeaves: 10,
        availLeaves: 3,
        startDate: DateTime(2023, 12, 5),
        endDate: DateTime(2023, 12, 8),
        reason: 'Vacation',
        status: 'Pending',
        members: ['Omar Farouk', 'Aisha Khalid', 'Yusuf Mansoor'],
      ),
      LeaveRequest(
        id: 2,
        type: 2,
        name: 'Casual Leave',
        totalLeaves: 10,
        availLeaves: 4,
        startDate: DateTime(2023, 1, 16),
        endDate: DateTime(2023, 1, 18),
        reason: 'Personal',
        status: 'Approved',
        members: ['Ahmed Ali', 'Fatima Zahra', 'Hassan Ibrahim'],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leave Management System'),
        backgroundColor: AppColors.backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.school),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EducationDetailPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.access_time), // Icon for AttendancePage
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AttendancePage(),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            children: [
              // Total Leaves box at the top, spanning full width
              Container(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LeaveRequestsPage(
                          leaveType: 'Total',
                          leaveRequests: leaveRequests,
                        ),
                      ),
                    );
                  },
                  child: LeaveBox(
                    title: 'Total Leaves',
                    totalLeaves: 35,
                    availedLeaves: leaveRequests.length,
                    color: AppColors.totalLeaveBackgroundColor,
                    backgroundColor: AppColors.totalLeaveColor,
                    icon: Icons.assessment,
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Leave type boxes
              LayoutBuilder(
                builder: (context, constraints) {
                  final boxWidth = (constraints.maxWidth - 32) / 2;
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: boxWidth,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LeaveRequestsPage(
                                      leaveType: 'Annual',
                                      leaveRequests: leaveRequests.where((request) => request.type == 1).toList(),
                                    ),
                                  ),
                                );
                              },
                              child: LeaveBox(
                                title: 'Annual Leaves',
                                totalLeaves: 10,
                                availedLeaves: leaveRequests.where((request) => request.type == 1).length,
                                color: AppColors.annualLeaveBackgroundColor,
                                backgroundColor: AppColors.annualLeaveColor,
                                icon: Icons.calendar_month,
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Container(
                            width: boxWidth,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LeaveRequestsPage(
                                      leaveType: 'Casual',
                                      leaveRequests: leaveRequests.where((request) => request.type == 2).toList(),
                                    ),
                                  ),
                                );
                              },
                              child: LeaveBox(
                                title: 'Casual Leaves',
                                totalLeaves: 10,
                                availedLeaves: leaveRequests.where((request) => request.type == 2).length,
                                color: AppColors.casualLeavebckgroundColor,
                                backgroundColor: AppColors.casualLeaveColor,
                                icon: Icons.airline_seat_recline_extra,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: boxWidth,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LeaveRequestsPage(
                                      leaveType: 'Sick',
                                      leaveRequests: leaveRequests.where((request) => request.type == 3).toList(),
                                    ),
                                  ),
                                );
                              },
                              child: LeaveBox(
                                title: 'Sick Leaves',
                                totalLeaves: 10,
                                availedLeaves: leaveRequests.where((request) => request.type == 3).length,
                                color: AppColors.sickLeaveBackgroundColor,
                                backgroundColor: AppColors.sickLeaveColor,
                                icon: Icons.local_hospital,
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Container(
                            width: boxWidth,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LeaveRequestsPage(
                                      leaveType: 'Maternity',
                                      leaveRequests: leaveRequests.where((request) => request.type == 4).toList(),
                                    ),
                                  ),
                                );
                              },
                              child: LeaveBox(
                                title: 'Maternity Leaves',
                                totalLeaves: 5,
                                availedLeaves: leaveRequests.where((request) => request.type == 4).length,
                                color: AppColors.maternityLeaveBackgroundColor,
                                backgroundColor: AppColors.maternityLeaveColor,
                                icon: Icons.woman,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      // Leave Requests box
                      Container(
                        width: double.infinity,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LeaveRequestsStatusPage(
                                  leaveRequests: leaveRequests,
                                ),
                              ),
                            );
                          },
                          child: LeaveRequestBox(
                            title: 'Leave Requests',
                            icon: Icons.view_list_outlined,
                            color: AppColors.LeaveRequestsbckgroundColor,
                            backgroundColor: AppColors.LeaveRequestsColor,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LeaveFormPage(),
            ),
          );
          if (result != null && result is LeaveRequest) {
            setState(() {
              leaveRequests.add(result);
            });
          }
        },
        backgroundColor: AppColors.backgroundColor,
        child: Icon(Icons.add),
      ),
    );
  }
}

class LeaveRequestsPage extends StatefulWidget {
  final String leaveType;
  final List<LeaveRequest> leaveRequests;

  LeaveRequestsPage({required this.leaveType, required this.leaveRequests});

  @override
  _LeaveRequestsPageState createState() => _LeaveRequestsPageState();
}

class _LeaveRequestsPageState extends State<LeaveRequestsPage> {
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    // Extract the year from the search query if possible
    int? searchYear;
    try {
      searchYear = int.parse(_searchQuery);
    } catch (e) {
      searchYear = null; // If parsing fails, set to null
    }

    // Filter the leave requests based on the search year
    final filteredRequests = widget.leaveRequests.where((request) {
      if (searchYear == null) {
        return true; // No filtering if search query is not a valid year
      }

      // Extract the year from startDate and endDate
      int startYear = request.startDate.year;
      int endYear = request.endDate.year;

      // Check if the search year is within the range of startYear and endYear
      return searchYear >= startYear && searchYear <= endYear;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.leaveType} Leave Requests'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search by Year',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: LeaveRequestsBox(
                leaveRequests: filteredRequests,
                leaveType: widget.leaveType,
              ),
            ),
          ),
        ],
      ),
    );
  }
}