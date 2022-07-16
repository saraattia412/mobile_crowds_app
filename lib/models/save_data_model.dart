
import 'package:cloud_firestore/cloud_firestore.dart';

class SaveDataModel{
  late String name;
  late String date;
  late String id;
  late String path;
  late DateTime dateTime;


  SaveDataModel({
    required this.date,
    required this.name,
    required this.id,
    required this.path,


  });

  SaveDataModel.fromJson(Map <String , dynamic>? json) {
    date= json!['date'];
    name= json['name'];
    id= json['id'];
    path=json['path'];
    dateTime=(json['dateTime'] as Timestamp).toDate();
  }

  Map <String , dynamic> toMap(){
    return {
      'name' : name,
      'date' : date,
      'id' : id,
      'path':path,
      'dateTime' : DateTime.now(),

    };
  }
}








