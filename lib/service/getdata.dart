import 'dart:convert';

import 'package:http/http.dart';
import 'package:jsondatexample/database/database_helper.dart';
import 'package:jsondatexample/model/user_data.dart';
import 'package:http/http.dart' as http;


class GetData {
  final String postsURL = "https://jsonplaceholder.typicode.com/users";

  Future<List<UserData>> getPosts() async {
    Response res = await get(postsURL);
try {
  (res.statusCode == 200);
  var result=res.body;
  print(result);
  List<dynamic> body = jsonDecode(res.body);

  List<UserData> posts = body
      .map(
        (dynamic item) => UserData.fromJson(item),
  )
      .toList();
  DBProvider.db.createEmployee(UserData.toJson(employee));
  return posts;
}
    on Exception catch (_){
      throw "Can't get posts.";
    }
  }
}