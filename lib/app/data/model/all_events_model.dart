class AllEventModel {
  String? id;
  String? title;
  String? description;
  String? category;
  String? imageUrl;
  int? minAge;
  int? maxAge;
  int? guestLimit;
  int? escrowPrice;
  int? cashPrice;
  String? paymentType;
  String? startTime;
  String? endTime;
  String? homeNumber;
  String? street;
  String? town;
  String? city;
  String? state;
  String? country;
  String? createdAt;
  String? updatedAt;
  String? creatorName;
  String? userId;
  String? eventCategoryId;

  AllEventModel(
      {this.id,
        this.title,
        this.description,
        this.category,
        this.imageUrl,
        this.minAge,
        this.maxAge,
        this.guestLimit,
        this.escrowPrice,
        this.cashPrice,
        this.paymentType,
        this.startTime,
        this.endTime,
        this.homeNumber,
        this.street,
        this.town,
        this.city,
        this.state,
        this.country,
        this.createdAt,
        this.updatedAt,
        this.creatorName,
        this.userId,
        this.eventCategoryId});

  AllEventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    imageUrl = json['image_url'];
    minAge = json['min_age'];
    maxAge = json['max_age'];
    guestLimit = json['Guest_limit'];
    escrowPrice = json['escrow_price'];
    cashPrice = json['cash_price'];
    paymentType = json['payment_type'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    homeNumber = json['home_number'];
    street = json['street'];
    town = json['town'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    creatorName = json['creator_name'];
    userId = json['userId'];
    eventCategoryId = json['eventCategoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['category'] = category;
    data['image_url'] = imageUrl;
    data['min_age'] = minAge;
    data['max_age'] = maxAge;
    data['Guest_limit'] = guestLimit;
    data['escrow_price'] = escrowPrice;
    data['cash_price'] = cashPrice;
    data['payment_type'] = paymentType;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['home_number'] = homeNumber;
    data['street'] = street;
    data['town'] = town;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['creator_name'] = creatorName;
    data['userId'] = userId;
    data['eventCategoryId'] = eventCategoryId;
    return data;
  }
}
