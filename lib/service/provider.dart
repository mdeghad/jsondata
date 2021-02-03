import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'package:jsondatexample/database/database_helper.dart';
import 'package:jsondatexample/model/user_data.dart';

class EmployeeApiProvider {
  Future<List<UserData>> getAllEmployees() async {

    Response response = await http.get("https://jsonplaceholder.typicode.com/users");

    return (response.body as List).map((employee) {
      print('Inserting $employee');
      DBProvider.db.createEmployee(UserData.fromJson(employee));
    }).toList();
  }
}