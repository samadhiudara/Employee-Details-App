// employee.dart
import 'dart:convert';
import 'dart:math';

class Employee {
  String name;
  String position;
  String department;
  double salary;
  String contactInfo;
  String profilePicture; // New field for profile picture

  // Constructor
  Employee({
    required this.name,
    required this.position,
    required this.department,
    required this.salary,
    required this.contactInfo,
    required this.profilePicture, // Initialize profile picture
  });

  // Factory method to create an Employee object from JSON data
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      name: json['name'],
      position: json['position'],
      department: json['department'],
      salary: json['salary'],
      contactInfo: json['contactInfo'],
      profilePicture: getRandomProfilePicture(), // Assign a random profile picture path
    );
  }

  // Serialize Employee object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'position': position,
      'department': department,
      'salary': salary,
      'contactInfo': contactInfo,
      'profilePicture': profilePicture, // Serialize profile picture
    };
  }

  // Function to get a random profile picture path
  static String getRandomProfilePicture() {
    // List of random profile picture paths
    List<String> profilePictures = [
      'assets/image1.jpg',
      'assets/image2.jpg',
      'assets/image3.png',
      'assets/image6.jpg',

    ];
    // Select a random profile picture path
    Random random = Random();
    int index = random.nextInt(profilePictures.length);
    return profilePictures[index];
  }
}



