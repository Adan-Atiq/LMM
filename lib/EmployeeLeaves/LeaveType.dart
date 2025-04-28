
import 'package:flutter/material.dart';
class LeaveBox extends StatelessWidget {
  final String title;
  final int totalLeaves;
  final int availedLeaves;
  final Color color;
  final Color backgroundColor;
  final IconData icon;

  LeaveBox({
    required this.title,
    required this.totalLeaves,
    required this.availedLeaves,
    required this.color,
    required this.backgroundColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1),
      height: 135, // Adjusted height for smaller boxes
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Center content horizontally
        children: [
          Icon(icon, size: 32, color: color), // Display the icon
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 45, // Adjusted height for the circle
                  width: 45, // Adjusted width for the circle
                  child: CircularProgressIndicator(
                    value: availedLeaves / totalLeaves,
                    backgroundColor: color.withOpacity(0.25),
                    color: color,
                    strokeWidth: 8, // Adjusted stroke width
                  ),
                ),
                Text(
                  '$availedLeaves/$totalLeaves',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class LeaveRequestBox extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Color backgroundColor;

  const LeaveRequestBox({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          SizedBox(width: 8.0),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
