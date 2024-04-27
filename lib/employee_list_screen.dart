import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'add_employee_screen.dart';
import 'employee_card.dart';
import 'employee_detail_screen.dart';
import 'employee.dart';

class EmployeeListScreen extends StatefulWidget {
  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  List<Employee> _employees = [];
  String _sortBy = 'Name'; // Default sorting criteria
  String _filterBy = 'All'; // Default filter criteria
  String _searchQuery = ''; // Search query

  @override
  void initState() {
    super.initState();
    _loadEmployeeData();
  }

  Future<void> _loadEmployeeData() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      List<dynamic> data = json.decode(contents);
      setState(() {
        _employees = data.map((e) => Employee.fromJson(e)).toList();
      });
    } catch (e) {
      print("Error loading employee data: $e");
    }
  }

  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/employees.json');
  }

  Future<void> _saveEmployeeData() async {
    final file = await _localFile;
    String data = json.encode(_employees);
    await file.writeAsString(data);
  }

  double _calculateNetSalary(Employee employee) {
    // You can implement your salary calculation logic here
    // For example, let's say we deduct 20% as taxes
    double taxRate = 0.20;
    double netSalary = employee.salary * (1 - taxRate);
    return netSalary;
  }

  void _sortEmployees(String criteria) {
    setState(() {
      _sortBy = criteria;
      switch (criteria) {
        case 'Name':
          _employees.sort((a, b) => a.name.compareTo(b.name));
          break;
        case 'Position':
          _employees.sort((a, b) => a.position.compareTo(b.position));
          break;
        case 'Department':
          _employees.sort((a, b) => a.department.compareTo(b.department));
          break;
        case 'Salary':
          _employees.sort((a, b) => a.salary.compareTo(b.salary));
          break;
        case 'Net Salary':
          _employees.sort((a, b) => _calculateNetSalary(a).compareTo(_calculateNetSalary(b)));
          break;
        default:
          break;
      }
    });
  }

  void _filterEmployees(String criteria) {
    setState(() {
      _filterBy = criteria;
      if (criteria == 'All') {
        _employees = _employees; // Reset to all employees
      } else {
        _employees = _employees.where((employee) => employee.position == criteria || employee.department == criteria).toList();
      }
      _sortEmployees(_sortBy); // Re-sort after filtering
    });
  }

  void _searchEmployees(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });
  }

  List<Employee> _getFilteredEmployees() {
    // Filter employees based on search query and filter criteria
    return _employees.where((employee) {
      bool nameMatches = employee.name.toLowerCase().contains(_searchQuery);
      bool positionMatches = employee.position.toLowerCase().contains(_searchQuery);
      bool departmentMatches = employee.department.toLowerCase().contains(_searchQuery);
      return nameMatches || positionMatches || departmentMatches;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List'),
        backgroundColor: Colors.blue,
        actions: [
          PopupMenuButton(
            onSelected: _sortEmployees,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'Name',
                  child: Text('Sort by Name'),
                ),
                PopupMenuItem(
                  value: 'Position',
                  child: Text('Sort by Position'),
                ),
                PopupMenuItem(
                  value: 'Department',
                  child: Text('Sort by Department'),
                ),
                PopupMenuItem(
                  value: 'Salary',
                  child: Text('Sort by Salary'),
                ),
                PopupMenuItem(
                  value: 'Net Salary',
                  child: Text('Sort by Net Salary'),
                ),
              ];
            },
          ),
          PopupMenuButton(
            onSelected: _filterEmployees,
            itemBuilder: (BuildContext context) {
              List<String> filterOptions = ['All'];
              _employees.forEach((employee) {
                if (!filterOptions.contains(employee.position)) {
                  filterOptions.add(employee.position);
                }
                if (!filterOptions.contains(employee.department)) {
                  filterOptions.add(employee.department);
                }
              });
              return filterOptions.map((option) {
                return PopupMenuItem(
                  value: option,
                  child: Text('Filter by $option'),
                );
              }).toList();
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEmployeeScreen(
                    onAdd: (employee) {
                      setState(() {
                        _employees.add(employee);
                      });
                      _saveEmployeeData();
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: _searchEmployees,
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey[400],
                child: _buildEmployeeList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmployeeList() {
    List<Employee> filteredEmployees = _getFilteredEmployees();
    return filteredEmployees.isEmpty
        ? Center(
      child: Text(
        'No employees found.',
        style: TextStyle(fontSize: 18),
      ),
    )
        : ListView.builder(
      itemCount: filteredEmployees.length,
      itemBuilder: (context, index) {
        Employee employee = filteredEmployees[index];
        double netSalary = _calculateNetSalary(employee);
        return EmployeeCard(
          employee: employee,
          netSalary: netSalary,
          onUpdate: (updatedEmployee) {
            setState(() {
              _employees[index] = updatedEmployee;
            });
            _saveEmployeeData();
          },
          onDelete: () {
            setState(() {
              _employees.removeAt(index);
            });
            _saveEmployeeData();
          },
        );
      },
    );
  }
}
