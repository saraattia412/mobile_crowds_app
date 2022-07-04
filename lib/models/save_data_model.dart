
class SaveDataModel{
  late String name;
  late String date;
  late String id;
  late String path;


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

  }

  Map <String , dynamic> toMap(){
    return {
      'name' : name,
      'date' : date,
      'id' : id,
      'path':path

    };
  }
}








