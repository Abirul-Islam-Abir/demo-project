import 'dart:io';

import 'package:demo/app/common/widgets/multiple_image_select/image_picker_bottom_sheet.dart';
import 'package:demo/app/common/widgets/multiple_image_select/multiple_image_select_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MultipleImageSelectWidget extends StatelessWidget {
  const MultipleImageSelectWidget({
    super.key,
    required this.maxLimit,
    this.containerHeight,
    this.isFromBlogAndRecipe = false,
    this.upLoadTypeName,
  });

  final double? containerHeight;
  final int maxLimit;
  final bool isFromBlogAndRecipe;
  final String? upLoadTypeName;

  @override
  Widget build(BuildContext context) {
    final MultipleImageSelectController controller =
        Get.put(MultipleImageSelectController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: InkWell(onTap: () {
            imagePickerBottomSheet(context, controller, maxLimit,
                isFromBlogAndRecipe: isFromBlogAndRecipe);
          }, child: Obx(() {
            return Container(
                width: Get.width,
                height: containerHeight ?? 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blue.withOpacity(.10),
                  border: Border.all(
                    width: .7,
                    color: controller.isValid.value ? Colors.blue : Colors.red,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.photo),
                    const SizedBox(width: 10),
                    Text(
                      upLoadTypeName ?? 'Upload Image',
                    ),
                  ],
                ));
          })),
        ),
        const SizedBox(height: 10),
        if (!isFromBlogAndRecipe)
          Obx(
            () => Wrap(
              children: List.generate(
                controller.images.length,
                (index) => Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 4),
                      height: 58,
                      width: 78,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        image: DecorationImage(
                          image: FileImage(File(controller.images[index].path)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 27,
                      left: 50,
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          controller.removeImage(index);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        Obx(
          () => controller.isValid.value
              ? const SizedBox()
              : const Text('Please select at least one image',
                  style: TextStyle(color: Colors.red)),
        )
      ],
    );
  }

  Future<dynamic> imagePickerBottomSheet(BuildContext context,
      MultipleImageSelectController controller, int maxLimit,
      {bool? isFromBlogAndRecipe}) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return ImagePickerBottomSheet(
          onTapForPhotoLibrary: () {
            if (isFromBlogAndRecipe == true && controller.images.isNotEmpty) {
              controller.images.removeLast();
            }
            controller.pickImage(ImageSource.gallery, maxLimit,
                isFromBlogAndRecipe: isFromBlogAndRecipe);
            Get.back();
          },
          onTapForCamera: () {
            if (isFromBlogAndRecipe == true && controller.images.isNotEmpty) {
              controller.images.removeLast();
            }
            controller.pickImage(ImageSource.camera, maxLimit,
                isFromBlogAndRecipe: isFromBlogAndRecipe);
            Get.back();
          },
        );
      },
    );
  }
}
