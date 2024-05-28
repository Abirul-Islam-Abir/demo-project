class GetBlogsByIdModel {
  String? id;
  String? link;
  String? type;
  String? createdAt;
  String? updatedAt;
  String? blogId;

  GetBlogsByIdModel(
      {this.id,
        this.link,
        this.type,
        this.createdAt,
        this.updatedAt,
        this.blogId});

  GetBlogsByIdModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    link = json['link'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    blogId = json['blogId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['link'] = link;
    data['type'] = type;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['blogId'] = blogId;
    return data;
  }
}
