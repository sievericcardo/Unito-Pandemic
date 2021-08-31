import 'package:floor/floor.dart';

/// Disease entity that maps the different diseases that are studied
/// 
/// Even though the first version of the application **maps only Covid**, for
/// future releases we intend to add the possibility of generating a custom
/// **simulation** on different diseases so that the contagion probability
/// gets updated to better map the disease studied.
@entity
class Disease {
  @primaryKey
  int id;
  String name;
  double contagionProbability;

  Disease({this.id, this.name, this.contagionProbability});

  Disease.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contagionProbability = json['contagion_probability'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['contagion_probability'] = this.contagionProbability;
    return data;
  }

  String get getDiseaseName => this.name;
}
