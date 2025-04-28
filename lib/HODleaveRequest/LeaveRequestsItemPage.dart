import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../AppColor.dart';
import '../model/leaveRequestModel.dart';
import 'LeaveRequestDetailPage.dart';

class LeaveRequestsStatusPage extends StatefulWidget {
  final List<LeaveRequest> leaveRequests;

  const LeaveRequestsStatusPage({Key? key, required this.leaveRequests}) : super(key: key);

  @override
  _LeaveRequestsStatusPageState createState() => _LeaveRequestsStatusPageState();
}

class _LeaveRequestsStatusPageState extends State<LeaveRequestsStatusPage> {
  @override
  Widget build(BuildContext context) {
    List<LeaveRequest> sortedRequests = widget.leaveRequests
        .toList()
      ..sort((a, b) => b.startDate.compareTo(a.startDate));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Requests'),
      ),
      body: ListView.builder(
        itemCount: sortedRequests.length,
        itemBuilder: (context, index) {
          LeaveRequest request = sortedRequests[index];

          Color borderColor;
          Color backgroundColor;
          Color iconColor;
          Color dateColor;
          Color textColor;
          String buttonText;
          IconData statusIcon;

          switch (request.status) {
            case 'Pending':
              borderColor = AppColors.pendingLeaveColor;
              backgroundColor = AppColors.pendingLeaveBackgroundColor;
              iconColor = AppColors.pendingLeaveColor;
              dateColor = Colors.black;
              textColor = Colors.black;
              buttonText = 'Pending';
              statusIcon = Icons.pending; // Use appropriate icon
              break;
            case 'Approved':
              borderColor = AppColors.approvedLeaveColor;
              backgroundColor = AppColors.approvedLeaveBackgroundColor;
              iconColor = AppColors.approvedLeaveColor;
              dateColor = Colors.black;
              textColor = Colors.black;
              buttonText = 'Approved';
              statusIcon = Icons.check_circle; // Approved icon
              break;
            case 'Rejected':
              borderColor = AppColors.rejectedLeaveColor;
              backgroundColor = AppColors.rejectedLeaveBackgroundColor;
              iconColor = AppColors.rejectedLeaveColor;
              dateColor = Colors.black;
              textColor = Colors.black;
              buttonText = 'Rejected';
              statusIcon = Icons.cancel; // Rejected icon
              break;
            default:
              borderColor = Colors.grey;
              backgroundColor = Colors.white;
              iconColor = Colors.grey;
              dateColor = Colors.black;
              textColor = Colors.black;
              buttonText = 'Unknown';
              statusIcon = Icons.help; // Default icon
          }

          // Calculate the number of days
          final int days = request.endDate.difference(request.startDate).inDays + 1;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      LeaveRequestDetailPage(request: request),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                margin: EdgeInsets.zero,
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: borderColor, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                        color: backgroundColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Ahmad Ali',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: textColor,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      '$days Days Application',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: textColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            '${DateFormat('dd MMM yyyy').format(request.startDate)} - ${DateFormat('dd MMM yyyy').format(request.endDate)}',
                            style: TextStyle(
                              fontSize: 16,
                              color: dateColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            _getLeaveName(request.name),
                            style: TextStyle(
                              fontSize: 14,
                              color: borderColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 8.0,
                      right: 8.0,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (request.status == 'Pending') ...[
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  request.status = 'Approved';
                                  _updateRequestStatus(request);
                                });
                              },
                              child: CircleAvatar(
                                backgroundColor: AppColors.approvedLeaveColor,
                                radius: 15, // Reduced circle size
                                child: Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                  size: 20, // Reduced icon size
                                ),
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            GestureDetector(
                              onTap: () {
                                _showRejectionDialog(request);
                              },
                              child: CircleAvatar(
                                backgroundColor: AppColors.rejectedLeaveColor,
                                radius: 15, // Reduced circle size
                                child: Icon(
                                  Icons.cancel,
                                  color: Colors.white,
                                  size: 20, // Reduced icon size
                                ),
                              ),
                            ),
                          ] else ...[
                            CircleAvatar(
                              backgroundColor: iconColor,
                              radius: 15, // Reduced circle size
                              child: Icon(
                                statusIcon,
                                color: Colors.white,
                                size: 20, // Reduced icon size
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _truncateReason(String reason, int wordLimit) {
    List<String> words = reason.split(' ');
    if (words.length <= wordLimit) {
      return reason;
    } else {
      return words.sublist(0, wordLimit).join(' ') + '...';
    }
  }

  String _getLeaveName(String type) {
    return type;
  }

  void _showRejectionDialog(LeaveRequest request) {
    final _reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reason for Reject Leave Request'),
          content: TextField(
            controller: _reasonController,
            decoration: const InputDecoration(
              hintText: 'Enter reason for rejection',
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  request.status = 'Rejected';
                  _updateRequestStatus(request);
                });
              },
              child: const Text('Reject'),
            ),
          ],
        );
      },
    );
  }

  void _updateRequestStatus(LeaveRequest request) {
    // Update request status logic here
  }
}
