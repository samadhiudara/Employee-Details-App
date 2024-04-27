import 'package:flutter/material.dart';
import 'employee.dart';

class EmployeeDetailScreen extends StatefulWidget {
  final Employee employee;
  final Function(Employee) onUpdate;

  EmployeeDetailScreen({
    required this.employee,
    required this.onUpdate,
  });

  @override
  _EmployeeDetailScreenState createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _positionController = TextEditingController();
  TextEditingController _departmentController = TextEditingController();
  TextEditingController _salaryController = TextEditingController();
  TextEditingController _contactInfoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.employee.name;
    _positionController.text = widget.employee.position;
    _departmentController.text = widget.employee.department;
    _salaryController.text = widget.employee.salary.toString();
    _contactInfoController.text = widget.employee.contactInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Detail'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,

                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _positionController,
              decoration: InputDecoration(
                labelText: 'Position',
                labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _departmentController,
              decoration: InputDecoration(
                labelText: 'Department',
                labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _salaryController,
              decoration: InputDecoration(
                labelText: 'Salary',
                labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _contactInfoController,
              decoration: InputDecoration(
                labelText: 'Contact Info',
                labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                double newSalary = double.parse(_salaryController.text);
                Employee updatedEmployee = Employee(
                  name: _nameController.text,
                  position: _positionController.text,
                  department: _departmentController.text,
                  salary: newSalary,
                  contactInfo: _contactInfoController.text,
                  profilePicture: '',
                );
                widget.onUpdate(updatedEmployee);
                Navigator.pop(context);
              },
              child: Text(
                'Save',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            SizedBox(height: 16),
            Container(
              color: Colors.grey[300],
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
              child: Image.asset(
                'assets/image5.png',
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
