
import 'dart:convert';

class UserData{

  int id;
  String  email;
  String username;
  Address address;
  String name;

  UserData({this.name, this.address, this.id, this.email, this.username, });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] as int,
     username: json['username'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      address: json['address']!=null?new Address.fromJson(json['address']):null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email']=this.email;
    data['name']=this.name;
    return data;
  }
UserData.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.username= map['username'];
    this.email=map['email'];
  }

  UserData.toMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.username= map['username'];
    this.email=map['email'];
  }


  UserData.map(dynamic obj) {
    this.id = obj['id'];
    this.name = obj['name'];
    this.username = obj['username'];
  }




}

class Address{
  String street;
  String city;
  String zipcode;


  Address({this.street, this.city, this.zipcode,});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    city = json['city'];
    zipcode = json['zipcode'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['city'] = this.city;
    data['zipcode'] = this.zipcode;

    return data;
  }
}

