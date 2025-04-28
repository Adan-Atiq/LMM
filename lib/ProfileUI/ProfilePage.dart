import 'package:flutter/material.dart';
import 'package:lms/AppColor.dart';
import 'package:lms/AppColor.dart';
import 'package:lms/ProfileUI/BasicInfoPage.dart';

import '../AppColor.dart';

class ProfilePage extends StatelessWidget {

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
              color: AppColors.backgroundColor,
              // Card background color
              shape: RoundedRectangleBorder(
                side: BorderSide(color: AppColors.lightGray, width: 1),
                // Card border color
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  // AppBar content inside the Card
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Back Button
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.of(context)
                                .pop(); // Go back to the previous screen
                          },
                        ),
                        // Title
                        Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        // Edit Button (optional)
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.white),
                          onPressed: () {
                            // Handle the edit action
                          },
                        ),
                      ],
                    ),
                  ),
                  // Profile Image
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                        'assets/images/profile_image.png'), // Replace with your image asset
                  ),
                  SizedBox(height: 8),

                  // Name
                  Text(
                    'Ahmed Ali',
                    style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 2),

                  // Designation
                  Text(
                    'Software Engineer',
                    style: TextStyle(fontSize: 16, color: Colors.grey[300]),
                  ),
                  SizedBox(height: 8),

                  // CNIC and Phone Number with Padding
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         flex: 1,
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(right: 8.0),
                  //           child: Text(
                  //             '39203-4070467-7',
                  //             style: TextStyle(fontSize: 16, color: Colors.white),
                  //             textAlign: TextAlign.center,
                  //           ),
                  //         ),
                  //       ),
                  //       Container(
                  //         width: 2,
                  //         height: 24, // Adjust height as needed
                  //         color: lightGray, // Border color between CNIC and Phone Number
                  //       ),
                  //       Expanded(
                  //         flex: 1,
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(left: 8.0),
                  //           child: Text(
                  //             '03011879430',
                  //             style: TextStyle(fontSize: 16, color: Colors.white),
                  //             textAlign: TextAlign.center,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Information Boxes
            // Information Boxes
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _infoBox(Icons.info, 'Basic Information',
                      'See your information here', context),
                  SizedBox(height: 16),
                  _infoBox(Icons.school, 'Education Details',
                      'See your details here', context),
                  SizedBox(height: 16),
                  _infoBox(
                      Icons.work, 'Past Experience', 'See your details here',
                      context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoBox(IconData icon, String title, String description,
      BuildContext context) {
    return InkWell(
      onTap: () {
        if (title == 'Basic Information') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>
                BasicInfo()), // Navigate to the BasicInfoPage
          );
        }
        // Add more navigation options for other boxes if needed
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.lightGray, width: 1),
          // Box border color
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon Column
            Container(
              width: 30, // Adjust width to move the icon left
              child: Icon(
                icon,
                size: 30, // Icon size
                color: AppColors.backgroundColor, // Icon color
              ),
            ),
            SizedBox(width: 8), // Adjust spacing between icon and text
            // Text Column
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            // Arrow Column
            Container(
              width: 40, // Adjust width as needed
              child: Icon(
                Icons.arrow_forward_ios,
                size: 20, // Increase icon size here
                color: AppColors.backgroundColor, // Icon color
              ),
            ),
          ],
        ),
      ),
    );
  }
}