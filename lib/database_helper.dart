import 'dart:io';
import 'package:jsondatexample/model/userdata.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();
  static final table = 'Address';

  static final columnName = 'name';
  static final columnId = 'id';

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the Employee table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'employee_manager.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE Employee('
              'id INTEGER PRIMARY KEY,'
              'name TEXT,'
              'username TEXT'
              ')');

          await db.execute('CREATE TABLE Address('
              'id INTEGER,'
              'street TEXT,'
              'city TEXT,'
              'FOREIGN KEY($columnId) REFERENCES Employee($columnId)'
              ')');
        });
  }

  // Insert employee on database
  createEmployee(Employee newEmployee) async {
    final db = await database;
    final res = await db.insert('Employee', {
      'id': newEmployee.id,
      'name': newEmployee.name,
      'username': newEmployee.username,
    });
    Address newAddress = newEmployee.address;
    final addressResult = await db.insert('Address', {
      'city': newAddress.city,
      'street': newAddress.street,
      'id': newEmployee.id,
    });
    return res;
  }

  // Delete all employees
  Future<int> deleteAllEmployees() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Employee');

    return res;
  }

  Future<List<Employee>> getAllEmployees() async {
    final db = await database;
    final res = await db.rawQuery(
        'SELECT Employee.$columnName,Employee.username,Address.city,Address.street FROM Employee INNER JOIN Address ON Address.$columnId=Employee.$columnId');
    List<Employee> list = res.isNotEmpty ? res.map((c) {
      final Employee e = Employee.fromJson(c);
      e.address = Address.fromJson(c);
      return e;
    })
        .toList() : new List();
    print("$list");
    return list;
  }

  updateUsers() async {
    var dbClient = await database;
   final updateRes = await dbClient.rawUpdate("UPDATE Employee SET name = 'abcde' WHERE id = 1");
   return updateRes;



  }

// updateClient(Employee newClient) async {
//   final db = await database;
//   var res = await db.update("Employee", newClient.toJson(),
//       where: "id = ?", whereArgs: [newClient.id]);
//   return res;
// }
}