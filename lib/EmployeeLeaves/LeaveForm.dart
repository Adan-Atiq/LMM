import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../AppColor.dart';
import '../model/leaveRequestModel.dart';

class LeaveFormPage extends StatefulWidget {
  @override
  _LeaveFormPageState createState() => _LeaveFormPageState();
}

class _LeaveFormPageState extends State<LeaveFormPage> {
  static const Color backgroundColor = Color(0xFF008080);
  String _selectedLeaveType = 'Annual Leave';
  DateTime _startDate = DateTime.now();
  DateTime? _endDate;
  final _reasonController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<File> _selectedImages = [];

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final initialDate = isStartDate ? _startDate : (_endDate ?? _startDate);
    final firstDate = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = pickedDate;
          _endDate = null; // Clear the end date when start date is selected
        } else {
          if (pickedDate.isBefore(_startDate)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('End date cannot be before start date')),
            );
            return;
          }
          _endDate = pickedDate;
        }
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final fileName = pickedFile.path.split('/').last;
      final savedImage = await File(pickedFile.path).copy('${directory.path}/$fileName');

      setState(() {
        _selectedImages.add(savedImage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_endDate == null) {
      _endDate = DateTime.now();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Leave Request Form',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [backgroundColor, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.6, 0.5],
          ),
        ),

        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 14.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                //side: BorderSide(color: AppColors.lightGray),
              ),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      Text('Leave Type', style: TextStyle(fontSize: 16.0)),
                      DropdownButtonFormField<String>(
                        value: _selectedLeaveType,
                        items: [
                          'Annual Leave',
                          'Casual Leave',
                          'Sick Leave',
                          'Maternity Leave'
                        ].map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(
                            type,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedLeaveType = value!;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text('Reason for Leave', style: TextStyle(fontSize: 16.0)),
                      TextFormField(
                        controller: _reasonController,
                        maxLines: 2,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please provide a reason for leave';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Start Date', style: TextStyle(fontSize: 16.0)),
                                TextFormField(
                                  controller: TextEditingController(
                                    text: DateFormat('yyyy-MM-dd').format(_startDate),
                                  ),
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.calendar_month_outlined),
                                      onPressed: () => _selectDate(context, true),
                                    ),
                                  ),
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                  validator: (value) {
                                    if (_startDate == null) {
                                      return 'Please select a start date';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('End Date', style: TextStyle(fontSize: 16.0)),
                                TextFormField(
                                  controller: TextEditingController(
                                    text: DateFormat('yyyy-MM-dd').format(_endDate!),
                                  ),
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.calendar_month_outlined),
                                      onPressed: () => _selectDate(context, false),
                                    ),
                                  ),
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                  validator: (value) {
                                    if (_endDate == null) {
                                      return 'Please select an end date';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text('Attach Image', style: TextStyle(fontSize: 16.0)),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _selectedImages.isNotEmpty
                                        ? 'Selected Images:'
                                        : 'No image selected',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.photo_library),
                                  onPressed: () => _pickImage(ImageSource.gallery),
                                ),
                                IconButton(
                                  icon: Icon(Icons.camera_alt),
                                  onPressed: () => _pickImage(ImageSource.camera),
                                ),
                              ],
                            ),
                            if (_selectedImages.isNotEmpty)
                              Container(
                                height: 100,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _selectedImages.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Image.file(_selectedImages[index]),
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (_endDate != null && _endDate!.isBefore(_startDate)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('End date cannot be before start date')),
                                );
                                return;
                              }

                              int id = DateTime.now().millisecondsSinceEpoch;
                              int type;
                              switch (_selectedLeaveType) {
                                case 'Annual Leave':
                                  type = 1;
                                  break;
                                case 'Casual Leave':
                                  type = 2;
                                  break;
                                case 'Sick Leave':
                                  type = 3;
                                  break;
                                case 'Maternity Leave':
                                  type = 4;
                                  break;
                                default:
                                  type = 1;
                              }

                              String name = _selectedLeaveType;
                              int totalLeaves = _selectedLeaveType == 'Maternity Leave' ? 5 : 10;
                              int availLeaves = 1;
                              String status = ['Approved', 'Rejected', 'Pending'][DateTime.now().millisecondsSinceEpoch % 3];
                              List<String> members = ['Ahmed Ali', 'Fatima Zahra', 'Hassan Ibrahim'];

                              LeaveRequest leaveRequest = LeaveRequest(
                                id: id,
                                type: type,
                                name: name,
                                totalLeaves: totalLeaves,
                                availLeaves: availLeaves,
                                startDate: _startDate,
                                endDate: _endDate!,
                                reason: _reasonController.text,
                                status: status,
                                members: members,
                                imagePaths: _selectedImages.map((img) => img.path).toList(),
                              );

                              Navigator.pop(context, leaveRequest);

                              _formKey.currentState!.reset();
                              _selectedLeaveType = 'Annual Leave';
                              _startDate = DateTime.now();
                              _endDate = DateTime.now();
                              _reasonController.clear();
                              _selectedImages.clear();

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Leave request submitted!')),
                              );
                              setState(() {});
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: backgroundColor,
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Submit',
                            style: TextStyle(color: AppColors.buttonTextColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          ),
        ),
      ),
    );
  }
}