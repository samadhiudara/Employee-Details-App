import 'package:flutter/material.dart';
import 'employee.dart';

class AddEmployeeScreen extends StatelessWidget {
  final Function(Employee) onAdd;

  AddEmployeeScreen({required this.onAdd});

  TextEditingController _nameController = TextEditingController();
  TextEditingController _positionController = TextEditingController();
  TextEditingController _departmentController = TextEditingController();
  TextEditingController _salaryController = TextEditingController();
  TextEditingController _contactInfoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
        backgroundColor: Colors.blue, // Set app bar background color
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter Employee Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _nameController,
                style: TextStyle(color: Colors.black), // Text color
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200], // Text field background color
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _positionController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Position',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _departmentController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Department',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _salaryController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Salary',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                controller: _contactInfoController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Contact Info',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 32),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Employee newEmployee = Employee(
                        name: _nameController.text,
                        position: _positionController.text,
                        department: _departmentController.text,
                        salary: double.parse(_salaryController.text),
                        contactInfo: _contactInfoController.text,
                        profilePicture: '',
                      );
                      onAdd(newEmployee);
                      Navigator.pop(context);
                    },
                    child: Text('Add Employee'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 20), // Adjust button padding
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32),
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/image4.png',
                  height: 300,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white, // Set screen background color
    );
  }
}
