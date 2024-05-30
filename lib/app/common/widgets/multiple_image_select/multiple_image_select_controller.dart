import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:demo/app/api_services/api_services.dart';
import 'package:demo/app/common/widgets/multiple_image_select/multipart_upload_model.dart';
import 'package:demo/app/data/services/network_caller/network_response.dart';
import 'package:demo/app/data/services/network_caller/request_methods/post_request.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MultipleImageSelectController extends GetxController {
  static MultipleImageSelectController get instance =>
      Get.put(MultipleImageSelectController());

  final ImagePicker _picker = ImagePicker();
  final _images = <XFile>[].obs;
  final List<String> imageUrls = [];

  Future<void> pickImage(ImageSource source, int maxLimit,
      {bool? isFromBlogAndRecipe}) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (_images.length < maxLimit) {
        if (pickedFile != null) {
          _images.add(pickedFile);
          final success = await upload(pickedFile);
          if (success) {
            imageUrls.add(imageUrl);
          }
        }
      } else {
        Get.snackbar('Image Limit Reached',
            'You can only select $maxLimit images at a time');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  String imageUrl = '';
  MultipartUploadModel multipartUploadModel = MultipartUploadModel();
  final RxBool _imageUploadInProgress = false.obs;
  RxBool get imageUploadInProgress => _imageUploadInProgress;
  Future<bool> upload(XFile? image) async {
    _imageUploadInProgress.value = true;
    update();
    final NetworkResponse response = await PostRequest.execute(
        ApiServices.eventUpdateUrl, {},
        images: [File(image!.path)], isImage: true);
    _imageUploadInProgress.value = false;
    update();

    if (response.isSuccess) {
      final multipartUploadModel =
          multipartUploadModelFromJson(jsonEncode(response.responseData));
      imageUrl = multipartUploadModel.data!.imageUrl.toString();
      log(response.responseData);
      log(multipartUploadModel.data!.imageUrl.toString());
      log('Status from multiple imae controller: ${response.statusCode}');
      return true;
    } else {
      log("${response.statusCode}");
      clearImage();
      update();
      // Helpers.showToastMessage(message: "Failed to upload image");
      return false;
    }
  }

  void removeImage(int index) {
    _images.removeAt(index);
    imageUrls.removeAt(index);
  }

  void clearImage() {
    _images.clear();
    imageUrls.clear();
  }

  final RxBool isValid = true.obs;
  final RxString validationMessage = ''.obs;

  void validate() {
    if (imageUrls.isEmpty) {
      isValid.value = false;
      validationMessage.value = 'You must select an image to continue';
    } else {
      isValid.value = true;
    }
  }

  List<XFile> get images => _images;
}
