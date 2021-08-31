import 'package:unito_pandemic_decentralized/model/backend/disease.dart';

/// Class to map the contagions that might happen after contacts
/// 
/// This class does not ensure that contagion actually happened, whereas we do
/// map the contacts that happened outside the simulation environment and that
/// **might actually lead to a contagion**; after we get to know that one of the
/// key we encountered is actually sick, we can go check to a doctor our state
class RealContagionResponse {
  int id;
  User user;
  Disease disease;
  int timestamp;

  RealContagionResponse({this.id, this.user, this.disease, this.timestamp});

  RealContagionResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    disease = json['disease'] != null ? new Disease.fromJson(json['disease']) : null;
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.disease != null) {
      data['disease'] = this.disease.toJson();
    }
    data['timestamp'] = this.timestamp;
    return data;
  }
}

/// User object that model the table on the backend
/// 
/// We gets locally all the key that are used for the application, as well as
/// data that are required in the beginning for the registration, such as age
/// and gender.
class User {
  String pubKey;
  String password;
  int age;
  String gender;
  String name;
  bool enabled;
  List<String> roles;
  String username;
  List<Authorities> authorities;
  bool accountNonExpired;
  bool accountNonLocked;
  bool credentialsNonExpired;

  User(
      {this.pubKey,
      this.password,
      this.age,
      this.gender,
      this.name,
      this.enabled,
      this.roles,
      this.username,
      this.authorities,
      this.accountNonExpired,
      this.accountNonLocked,
      this.credentialsNonExpired});

  User.fromJson(Map<String, dynamic> json) {
    pubKey = json['pubKey'];
    password = json['password'];
    age = json['age'];
    gender = json['gender'];
    name = json['name'];
    enabled = json['enabled'];
    roles = json['roles'].cast<String>();
    username = json['username'];
    if (json['authorities'] != null) {
      authorities = new List<Authorities>();
      json['authorities'].forEach((v) {
        authorities.add(new Authorities.fromJson(v));
      });
    }
    accountNonExpired = json['accountNonExpired'];
    accountNonLocked = json['accountNonLocked'];
    credentialsNonExpired = json['credentialsNonExpired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pubKey'] = this.pubKey;
    data['password'] = this.password;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['name'] = this.name;
    data['enabled'] = this.enabled;
    data['roles'] = this.roles;
    data['username'] = this.username;
    if (this.authorities != null) {
      data['authorities'] = this.authorities.map((v) => v.toJson()).toList();
    }
    data['accountNonExpired'] = this.accountNonExpired;
    data['accountNonLocked'] = this.accountNonLocked;
    data['credentialsNonExpired'] = this.credentialsNonExpired;
    return data;
  }
}

class Authorities {
  String authority;

  Authorities({this.authority});

  Authorities.fromJson(Map<String, dynamic> json) {
    authority = json['authority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authority'] = this.authority;
    return data;
  }
}
