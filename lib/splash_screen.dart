import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jsondatexample/screen/listdata.dart';
import 'package:jsondatexample/service/getdata.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
return SplashScreenState();
  }

}

class SplashScreenState extends State{
  final GetData getData = GetData();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   Timer(Duration(seconds:10),()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ListData())));

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(

     body:Center(child: Image.network("https://www.kindpng.com/picc/m/355-3557482_flutter-logo-png-transparent-png.png"))


    );
  }

}