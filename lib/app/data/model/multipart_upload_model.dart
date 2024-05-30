// To parse this JSON data, do
//
//     final multipartUploadModel = multipartUploadModelFromJson(jsonString);

import 'dart:convert';

MultipartUploadModel multipartUploadModelFromJson(String str) => MultipartUploadModel.fromJson(json.decode(str));

String multipartUploadModelToJson(MultipartUploadModel data) => json.encode(data.toJson());

class MultipartUploadModel {
    String? message;
    int? status;
    bool? success;
    Data? data;

    MultipartUploadModel({
        this.message,
        this.status,
        this.success,
        this.data,
    });

    factory MultipartUploadModel.fromJson(Map<String, dynamic> json) => MultipartUploadModel(
        message: json["message"],
        status: json["status"],
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "success": success,
        "data": data?.toJson(),
    };
}

class Data {
    String? imageUrl;

    Data({
        this.imageUrl,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        imageUrl: json["image_url"],
    );

    Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
    };
}
