class EventByIdModel {
  String? id;
  String? title;
  String? createdAt;
  String? updatedAt;

  EventByIdModel({this.id, this.title, this.createdAt, this.updatedAt});

  EventByIdModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
