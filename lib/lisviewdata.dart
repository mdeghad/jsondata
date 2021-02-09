import 'package:flutter/material.dart';
import 'package:jsondatexample/database/database_helper.dart';
import 'package:jsondatexample/model/userdata.dart';
import 'package:jsondatexample/screen/add.dart';
import 'package:jsondatexample/service/provider.dart';

class ListSqlData extends StatefulWidget {
  final Employee note;
  ListSqlData(this.note);
//  const ListSqlData({Key key}) : super(key: key);

  @override
  ListSqlDataState createState() => ListSqlDataState();
}

class ListSqlDataState extends State<ListSqlData> {
  var isLoading = false;
  final usernameController=TextEditingController();
  final addressController=TextEditingController();
  final nameController=TextEditingController();

  _updateUserDetails() async {
    setState(() {
      isLoading = true;
    });

    // var apiProvider = EmployeeApiProvider();
    // await apiProvider.getAllEmployees();
    await DBProvider.db.updateUsers();
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api to sqlite'),
        centerTitle: true,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(Icons.get_app),
              onPressed: () async {
                await _loadFromApi();
              },
            ),
          ),
      Container(
        padding: EdgeInsets.only(right: 10.0),
        child: IconButton(
          icon: Icon(Icons.update),
          onPressed: () async {
            _updateUserDetails();
          },
        ),
          ),
        ],
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : _buildEmployeeListView(),
    );
  }

  _loadFromApi() async {
    setState(() {
      isLoading = true;
    });

    var apiProvider = EmployeeApiProvider();
    await apiProvider.getAllEmployees();

    // wait for 2 seconds to simulate loading of data
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  _deleteData() async {
    setState(() {
      isLoading = true;
    });

    await DBProvider.db.deleteAllEmployees();

    // wait for 1 second to simulate loading of data
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });

    print('All employees deleted');
  }

  _buildEmployeeListView() {
    return FutureBuilder(
      future: DBProvider.db.getAllEmployees(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.separated(
              separatorBuilder: (context, index) =>
                  Divider(
                    color: Colors.black12,
                  ),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {



                return
                  Card(child:
                  ListTile(
                    leading: Text(
                      "${index + 1}",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    title: Text(
                        "Name: ${snapshot.data[index].name} ${snapshot
                            .data[index].username} "),
                    subtitle: Text('City: ${snapshot.data[index].address
                        .city},Street:${snapshot.data[index].address.street}'),

                  )


                  );
              }
          );
        }
      },
    );
  }
}


