class GetAllBlogsModel {
  String? id;
  String? title;
  String? body;
  String? category;
  String? bannerImageUrl;
  String? imageUrl;
  String? videoLink;
  String? createdAt;
  String? updatedAt;
  String? userId;
  String? creatorName;
  String? eventCategoryId;

  GetAllBlogsModel(
      {this.id,
        this.title,
        this.body,
        this.category,
        this.bannerImageUrl,
        this.imageUrl,
        this.videoLink,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.creatorName,
        this.eventCategoryId});

  GetAllBlogsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['Body'];
    category = json['category'];
    bannerImageUrl = json['banner_image_url'];
    imageUrl = json['image_url'];
    videoLink = json['video_link'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
    creatorName = json['creator_name'];
    eventCategoryId = json['eventCategoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['Body'] = body;
    data['category'] = category;
    data['banner_image_url'] = bannerImageUrl;
    data['image_url'] = imageUrl;
    data['video_link'] = videoLink;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['userId'] = userId;
    data['creator_name'] = creatorName;
    data['eventCategoryId'] = eventCategoryId;
    return data;
  }
}
