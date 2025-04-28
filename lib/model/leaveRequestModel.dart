class LeaveRequest {
  final int id;
  final int type;
  final String name;
  final int totalLeaves;
  final int availLeaves;
  final DateTime startDate;
  final DateTime endDate;
  late final String reason;
  late final String status;
  String? rejectionReason;
  final List<String> members;
  final List<String>? imagePaths;  // Add this line to store the image path

  LeaveRequest({
    required this.id,
    required this.type,
    required this.name,
    required this.totalLeaves,
    required this.availLeaves,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.status,
    required this.members,
    this.imagePaths,
    this.rejectionReason,// Add this field
  });
}
