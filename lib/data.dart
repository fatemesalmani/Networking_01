import 'package:dio/dio.dart';

class User {
  Address? address;
  int? id;
  String? email;
  String? username;
  String? password;
  Name? name;
  String? phone;
  int? v;

  User({
    this.address,
    this.id,
    this.email,
    this.username,
    this.password,
    this.name,
    this.phone,
    this.v,
  });

  User.fromJson(Map<String, dynamic> json) {
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    id = json['id'];
    email = json['email'];
    username = json['username'];
    password = json['password'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    phone = json['phone'];
    v = json['__v'];
  }

  static List<User> userFromSnapshot(List userSnapshot) {
    return userSnapshot.map((data) {
      return User.fromJson(data);
    }).toList();
  }
}

class Address {
  Geolocation? geolocation;
  String? city;
  String? street;
  int? number;
  String? zipcode;

  Address({
    this.geolocation,
    this.city,
    this.street,
    this.number,
    this.zipcode,
  });

  Address.fromJson(Map<String, dynamic> json) {
    geolocation = json['geolocation'] != null ? Geolocation.fromJson(json['geolocation']) : null;
    city = json['city'];
    street = json['street'];
    number = json['number'];
    zipcode = json['zipcode'];
  }
}

class Geolocation {
  String? lat;
  String? long;

  Geolocation({
    this.lat,
    this.long,
  });

  Geolocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
  }
}

class Name {
  String? firstname;
  String? lastname;

  Name({
    this.firstname,
    this.lastname,
  });

  Name.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
  }
}

class HttpClient{
  static Dio instance=Dio(BaseOptions(
    baseUrl: 'http://fakestoreapi.com/users'
  ));
}

Future<List<User>> getUsers() async{
  final response= await HttpClient.instance.get('http://fakestoreapi.com/users');
  final List<User> students=[];
  if (response.data is List<dynamic>){
    for (var element in (response.data as List<dynamic>)) { 
      students.add(User.fromJson(element));
    }
  }
  return students;
}

