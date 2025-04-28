import 'package:flutter/material.dart';
import 'package:lms/AppColor.dart';

class BasicInfo extends StatelessWidget {
  static const Color backgroundColor = Color(0xFF008080);
  static const Color lightGray = Color(0xFFCED4DA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Card with AppBar content
            Card(
              margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              elevation: 4,
              color: backgroundColor, // Card background color
              shape: RoundedRectangleBorder(
                side: BorderSide(color: lightGray, width: 1), // Card border color
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  // AppBar content inside the Card
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () {
                              Navigator.of(context).pop(); // Go back to the previous screen
                            },
                          ),
                        ),
                        // Title
                        Center(
                          child: Text(
                            'Basic Info',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Profile Image
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/profile_image.png'), // Replace with your image asset
                  ),
                  SizedBox(height: 8),

                  // Name
                  Text(
                    'Ahmed Ali',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 2),

                  // Designation
                  Text(
                    'Software Engineer',
                    style: TextStyle(fontSize: 16, color: Colors.grey[300]),
                  ),
                  SizedBox(height: 8),
                  // CNIC and Phone Number with Padding
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              '39203-4070467-7',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Container(
                          width: 2,
                          height: 24, // Adjust height as needed
                          color: lightGray, // Border color between CNIC and Phone Number
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '03011879430',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Four additional information boxes
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  // Email Box
                  _buildInfoBox(
                    icon: Icons.email,
                    label: 'Email',
                    value: 'ahmed.ali@example.com',
                  ),
                  // Department Box
                  _buildInfoBox(
                    icon: Icons.work,
                    label: 'Department',
                    value: 'IT',
                  ),
                  // Father/Husband Name Box
                  _buildInfoBox(
                    icon: Icons.person,
                    label: 'Father / Husband Name',
                    value: 'Ali Ahmed',
                  ),
                  // Disability Box
                  _buildInfoBox(
                    icon: Icons.accessibility,
                    label: 'Disability',
                    value: 'None',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build an information box with label and value in different rows
  Widget _buildInfoBox({required IconData icon, required String label, required String value}) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: lightGray),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: backgroundColor),
          SizedBox(width: 10), // Space between icon and text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}