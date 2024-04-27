// employee_card.dart
import 'package:flutter/material.dart';
import 'employee.dart';
import 'employee_detail_screen.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;
  final double netSalary;
  final Function(Employee) onUpdate;
  final Function onDelete;

  EmployeeCard({
    required this.employee,
    required this.netSalary,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(employee.profilePicture),
                  radius: 60,
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${employee.name}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('Position: ${employee.position}'),
                    SizedBox(height: 8),
                    Text('Department: ${employee.department}'),
                    SizedBox(height: 8),
                    Text('Gross Salary: \$${employee.salary.toStringAsFixed(2)}'),
                    SizedBox(height: 8),
                    Text('Net Salary: \$${netSalary.toStringAsFixed(2)}'),
                    SizedBox(height: 8),
                    Text('Contact: ${employee.contactInfo}'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmployeeDetailScreen(
                          employee: employee,
                          onUpdate: onUpdate,
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    onDelete();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
