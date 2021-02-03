import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jsondatexample/database/database_helper.dart';
import 'package:jsondatexample/model/user_data.dart';
import 'package:jsondatexample/service/getdata.dart';
import 'package:http/http.dart' as http;

class ListData extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return ListDataState();
  }

}

class ListDataState extends State{
  final GetData getData = GetData();

  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
      appBar: AppBar(
        title: Text("Data"),
      ),
      body: FutureBuilder(
        future: getData.getPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<UserData>> snapshot) {
          if (snapshot.hasData) {
            List<UserData> posts = snapshot.data;
            return ListView(
              children: posts
                  .map(
                    (UserData post) => Card(child: ListTile(
                    leading: Text("${post.id}"),
                  title: Text(post.name),
                  subtitle: Text("${post.username}"),
                 trailing:  Column(

                    children: <Widget>[
                    Text("City:${ post.address.city}"),
                      Text("Street:${ post.address.street}"),

                      ],
                    ),

                  // onTap: () => Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => PostDetail(
                  //       post: post,
                  //     ),
                  //   ),
                  // ),
                ),
                    )
              )
                  .toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  


  }






