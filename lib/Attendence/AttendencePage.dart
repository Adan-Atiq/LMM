import 'package:flutter/material.dart';

import '../AppColor.dart';

class AttendancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // Card containing AppBar with increased height
              SizedBox(
                height: 240, // Set desired height for the top card
                child: Card(
                  elevation: 4,
                  color: AppColors.backgroundColor,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      // AppBar inside Card with Back Arrow
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        width: double.infinity, // Ensures the width covers the full screen
                        child: AppBar(
                          leading: IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.black),
                            onPressed: () {
                              Navigator.pop(context); // Navigate back to the previous page
                            },
                          ),
                          title: Text(
                            'Attendance',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          centerTitle: true,
                          automaticallyImplyLeading: false,
                        ),
                      ),
                      // Name and Designation
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch, // Align text to the left
                          children: [
                            Text(
                              'Ahmad Ali',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Software Engineer',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Padding to move GridView downward
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 90), // Adjust this value to move the grid down
                  child: GridView.builder(
                    padding: EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Two columns
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.5, // Adjust for icon size and text
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      final items = [
                        {'icon': Icons.access_time_filled_rounded, 'text': 'Attendance', 'color': AppColors.backgroundColor},
                        {'icon': Icons.inventory, 'text': 'Inventory', 'color':AppColors.backgroundColor},
                        {'icon': Icons.directions_car, 'text': 'Vehicle', 'color': AppColors.backgroundColor},
                        {'icon': Icons.people_alt, 'text': 'Meetings', 'color': AppColors.backgroundColor},
                      ];
                      final item = items[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            item['icon'] as IconData, // Cast to IconData
                            size: 40,
                            color: item['color'] as Color, // Cast to Color
                          ),
                          SizedBox(height: 8),
                          Text(
                            item['text'] as String, // Cast to String
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 170, // Adjust the value to control the overlap
            left: 10,
            right: 10,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Time In:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '09:00:00 AM', // Time format with hours, minutes, and seconds
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Time Out:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '06:00:00 PM', // Time format with hours, minutes, and seconds
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Adjust padding if needed
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Punch',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12, // Adjust font size if needed
                              ),
                              textAlign: TextAlign.center, // Ensure text is centered
                            ),
                            Text(
                              'Out',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12, // Adjust font size if needed
                              ),
                              textAlign: TextAlign.center, // Ensure text is centered
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
