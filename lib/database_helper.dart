import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'employee.dart';

class DatabaseHelper {
  static late Database _db;

  Future<void> initializeDatabase() async {
    if (_db != null) {
      return;
    }
    try {
      String path = join(await getDatabasesPath(), 'employees.db');
      _db = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
            CREATE TABLE employees(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT,
              position TEXT,
              department TEXT,
              salary REAL,
              contactInfo TEXT,
              profilePicture TEXT
            )
          ''');
        },
      );
    } catch (e) {
      print("Error initializing database: $e");
    }
  }

  Future<List<Employee>> getEmployees() async {
    try {
      if (_db == null) {
        await initializeDatabase();
      }
      final List<Map<String, dynamic>> maps = await _db.query('employees');
      return List.generate(maps.length, (i) {
        return Employee(
          name: maps[i]['name'],
          position: maps[i]['position'],
          department: maps[i]['department'],
          salary: maps[i]['salary'],
          contactInfo: maps[i]['contactInfo'],
          profilePicture: maps[i]['profilePicture'],
        );
      });
    } catch (e) {
      print("Error getting employees: $e");
      return [];
    }
  }

  Future<int> insertEmployee(Employee employee) async {
    try {
      if (_db == null) {
        await initializeDatabase();
      }
      return await _db.insert(
        'employees',
        employee.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("Error inserting employee: $e");
      return -1;
    }
  }

  Future<int> updateEmployee(Employee employee) async {
    try {
      if (_db == null) {
        await initializeDatabase();
      }
      return await _db.update(
        'employees',
        employee.toJson(),
        where: 'name = ?',
        whereArgs: [employee.name],
      );
    } catch (e) {
      print("Error updating employee: $e");
      return -1;
    }
  }

  Future<int> deleteEmployee(String name) async {
    try {
      if (_db == null) {
        await initializeDatabase();
      }
      return await _db.delete(
        'employees',
        where: 'name = ?',
        whereArgs: [name],
      );
    } catch (e) {
      print("Error deleting employee: $e");
      return -1;
    }
  }
}
