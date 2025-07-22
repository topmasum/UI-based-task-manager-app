class TaskCountModel{
  late String id;
  late int count;

  TaskCountModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    count = json['sum'];
  }
}