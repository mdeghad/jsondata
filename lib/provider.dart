
import 'package:dio/dio.dart';
import 'package:jsondatexample/database/database_helper.dart';
import 'package:jsondatexample/model/userdata.dart';


class EmployeeApiProvider {
  Future<List<Employee>> getAllEmployees() async {
    var url = "https://jsonplaceholder.typicode.com/users";
    Response response = await Dio().get(url);

    return (response.data as List).map((employee) {
      print('Inserting $employee');
     DBProvider.db.createEmployee(Employee.fromJson(employee));
      print("insert");
    }).toList();
  }
}