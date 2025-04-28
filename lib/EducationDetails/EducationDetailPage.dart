import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EducationDetailPage extends StatelessWidget {
  final List<EducationDetail> educationDetails = [
    EducationDetail(
      institution: 'Harvard University',
      degree: 'Bachelor of Science in Computer Science',
      startDate: DateTime(2015, 9),
      endDate: DateTime(2019, 6),
    ),
    EducationDetail(
      institution: 'Stanford University',
      degree: 'Master of Science in Artificial Intelligence',
      startDate: DateTime(2020, 9),
      endDate: DateTime(2022, 6),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Education Details'),
        backgroundColor: Colors.green[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: educationDetails.length,
          itemBuilder: (context, index) {
            final detail = educationDetails[index];
            return EducationDetailCard(detail: detail);
          },
        ),
      ),
    );
  }
}

class EducationDetailCard extends StatelessWidget {
  final EducationDetail detail;

  EducationDetailCard({required this.detail});

  String formatDate(DateTime date) {
    return DateFormat('MMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.green, width: 1.5),
      ),
      color: Colors.white,
      elevation: 2,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon in the left column inside a round shape
                Container(
                  padding: EdgeInsets.all(8),  // Padding inside the circle
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green[900],  // Background color of the circle
                  ),
                  child: Icon(Icons.account_balance, color: Colors.green[100], size: 30),  // Increased icon size
                ),
                SizedBox(width: 12),  // Space between the icon and the text
                // Text in the right column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        detail.institution,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[900],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        detail.degree,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${formatDate(detail.startDate)} to ${formatDate(detail.endDate)}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 8,
            top: 8,
            child: IconButton(
              icon: Icon(Icons.edit, color: Colors.green[900]),
              onPressed: () {
                // Handle the edit button press
                print('Edit button pressed for ${detail.institution}');
              },
            ),
          ),
        ],
      ),
    );
  }
}
class EducationDetail {
  final String institution;
  final String degree;
  final DateTime startDate;
  final DateTime endDate;

  EducationDetail({
    required this.institution,
    required this.degree,
    required this.startDate,
    required this.endDate,
  });
}