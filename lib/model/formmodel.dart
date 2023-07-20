import 'hobbymodellist.dart';

class FormModel {
  String? id;
  String? name;
  String? birthdate;
  String? email;
  String? phone;
  String? gender;
  String? hobby;
  Address? address;

  FormModel(
      {this.id,
        this.name,
        this.birthdate,
        this.email,
        this.phone,
        this.gender,
        this.hobby,
        this.address});

  FormModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    birthdate = json['birthdate'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    hobby = json['hobby'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['birthdate'] = this.birthdate;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['hobby'] = this.hobby;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    return data;
  }
}

class Address {
  String? country;
  String? state;
  String? city;
  String? zipcode;
  Geo? geo;

  Address({this.country, this.state, this.city, this.zipcode, this.geo});

  Address.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    state = json['state'];
    city = json['city'];
    zipcode = json['zipcode'];
    geo = json['geo'] != null ? new Geo.fromJson(json['geo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['zipcode'] = this.zipcode;
    if (this.geo != null) {
      data['geo'] = this.geo!.toJson();
    }
    return data;
  }
}

class Geo {
  String? lat;
  String? lng;

  Geo({this.lat, this.lng});

  Geo.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}