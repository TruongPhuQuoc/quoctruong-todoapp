class TaskModel {
  int? id;
  String? description;
  bool isCompleted = false;

  TaskModel({this.id, this.description, this.isCompleted = false});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
    };
    return map;
  }

  TaskModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    description = map['description'];
    isCompleted = map['isCompleted'] == 1;
  }
}
