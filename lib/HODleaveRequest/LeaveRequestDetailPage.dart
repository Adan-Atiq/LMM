import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import '../model/leaveRequestModel.dart';
import '../AppColor.dart';

class LeaveRequestDetailPage extends StatelessWidget {
  final LeaveRequest request;

  const LeaveRequestDetailPage({Key? key, required this.request})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int totalDays = request.endDate
        .difference(request.startDate)
        .inDays + 1;
    int availableLeaves = request.totalLeaves - request.availLeaves;

    // Define light grey color
    final Color lightGrey = Colors.grey[200]!;

    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      appBar: AppBar(
        title: const Text('Leave Request Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Employee Name:'),
            SizedBox(height: 4), // Space between label and value
            _buildRichText('Ahmad Ali', lightGrey),
            const SizedBox(height: 10),
            Text('Leave Type:'),
            SizedBox(height: 4), // Space between label and value
            _buildRichText(request.name, lightGrey),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start Date:', // Label above container
                        style: TextStyle(fontSize: 14, color: Colors.black), // Customize label style
                      ),
                      SizedBox(height: 4), // Space between label and value
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                        constraints: BoxConstraints(minWidth: 150), // Set minimum width
                        decoration: BoxDecoration(
                          color: lightGrey, // Light grey background color
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          DateFormat('dd MMM yyyy').format(request.startDate), // Formatted Start Date value
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal), // Customize value style
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16), // Space between the two columns
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'End Date:', // Label above container
                        style: TextStyle(fontSize: 14, color: Colors.black), // Customize label style
                      ),
                      SizedBox(height: 4), // Space between label and value
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                        constraints: BoxConstraints(minWidth: 150), // Set minimum width
                        decoration: BoxDecoration(
                          color: lightGrey, // Light grey background color
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          DateFormat('dd MMM yyyy').format(request.endDate), // Formatted End Date value
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal), // Customize value style
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Days:', // Label above container
                        style: TextStyle(fontSize: 14, color: Colors.black), // Customize label style
                      ),
                      SizedBox(height: 4), // Space between label and container
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                        constraints: BoxConstraints(minWidth: 150), // Set minimum width
                        decoration: BoxDecoration(
                          color: lightGrey, // Light grey background color
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          '$totalDays', // Value
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal), // Customize value style
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16), // Space between the two columns
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Available Leaves:', // Label above container
                        style: TextStyle(fontSize: 14, color: Colors.black), // Customize label style
                      ),
                      SizedBox(height: 4), // Space between label and container
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                        constraints: BoxConstraints(minWidth: 150), // Set minimum width
                        decoration: BoxDecoration(
                          color: lightGrey, // Light grey background color
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          '$availableLeaves', // Value
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal), // Customize value style
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text('Reason:'),
            SizedBox(height: 4), // Space between label and value
            _buildRichText(request.reason, lightGrey),
            const SizedBox(height: 10),
            if (request.imagePaths != null && request.imagePaths!.isNotEmpty)
              _buildImageSection(context, request.imagePaths!),
            const SizedBox(height: 20),
            _buildActionSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildRichText(String content, Color backgroundColor) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: backgroundColor, // Apply light grey background color
        border: Border.all(color: Colors.grey), // Border color for the text fields
        borderRadius: BorderRadius.circular(8.0), // Border radius
      ),
      child: Text(content),
    );
  }

  Widget _buildImageSection(BuildContext context, List<String> imagePaths) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Attached Images:'),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: imagePaths.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FullImagePage(imagePath: imagePaths[index]),
                      ),
                    );
                  },
                  child: Image.file(
                    File(imagePaths[index]),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionSection() {
    Color backgroundColor;
    Color borderColor;
    Color textColor;
    String buttonText;

    switch (request.status) {
      case 'Pending':
        backgroundColor = AppColors.pendingLeaveColor;
        borderColor = AppColors.pendingLeaveColor;
        textColor = AppColors.buttonTextColor;
        buttonText = 'Accept'; // Button text for Pending status
        break;
      case 'Approved':
        backgroundColor = AppColors.approvedLeaveColor; // Color for approved
        borderColor = AppColors.approvedLeaveColor;
        textColor = Colors.white;
        buttonText = 'Approved'; // Button text for Approved status
        break;
      case 'Rejected':
        backgroundColor = AppColors.rejectedLeaveColor; // Color for rejected
        borderColor = AppColors.rejectedLeaveColor;
        textColor = Colors.white;
        buttonText = 'Rejected'; // Button text for Rejected status
        break;
      default:
        return SizedBox.shrink();
    }

    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (request.status == 'Pending') ...[
              ElevatedButton(
                onPressed: () {
                  // Handle Accept action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.approvedLeaveColor, // Green background
                  foregroundColor: Colors.white, // White text
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Border radius of 8
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                ),
                child: Text(buttonText), // Use buttonText variable
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  // Handle Reject action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.rejectedLeaveColor, // Red background
                  foregroundColor: Colors.white, // White text
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Border radius of 8
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                ),
                child: Text('Reject'),
              ),
            ] else ...[
              ElevatedButton(
                onPressed: () {
                  // Handle Edit action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor, // Status-specific color
                  foregroundColor: textColor, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Border radius of 8
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                ),
                child: Text(buttonText), // Use buttonText variable
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class FullImagePage extends StatelessWidget {
  final String imagePath;

  const FullImagePage({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Preview'),
      ),
      body: Center(
        child: Image.file(
          File(imagePath),
        ),
      ),
    );
  }
}
