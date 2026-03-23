import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../constant/Colorapp.dart';

imageuploadcamera() async {
  final XFile? file = await ImagePicker().pickImage(
    source: ImageSource.camera,
    imageQuality: 90,
  );
  if (file != null) {
    return File(file.path);
  } else {
    return null;
  }
}

bool _isPicking = false;

Future<File?> fileuploadGallery({bool isvg = false}) async {
  if (_isPicking) return null;
  _isPicking = true;

  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: isvg
          ? ["svg", "SVG"]
          : ["png", "PNG", "jpg", "JPG", "jpeg", "gif"],
    );

    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);

      if (!isvg) {
        final targetPath = file.path.replaceFirst(
          RegExp(r'\.(png|jpg|jpeg)$'),
          '_compressed.jpg',
        );
        var compressedResult = await FlutterImageCompress.compressAndGetFile(
          file.absolute.path,
          targetPath,
          quality: 80,
          minWidth: 1024,
          minHeight: 1024,
        );
        if (compressedResult != null) file = File(compressedResult.path);

        file = await FlutterExifRotation.rotateImage(path: file.path);
      }

      return file;
    }
    return null;
  } finally {
    _isPicking = false;
  }
}

showbottom(imageuploadcamera(), fileuploadGallery()) {
  Get.bottomSheet(
    backgroundColor: AppColor.white,
    Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                "choose_image".tr,
                style: const TextStyle(
                  fontSize: 22,
                  color: AppColor.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            ListTile(
              onTap: () {
                imageuploadcamera();
                Get.back();
              },
              leading: const Icon(Icons.camera, size: 40),
              title: Text(
                "from_camera".tr,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              onTap: () {
                fileuploadGallery();
                Get.back();
              },
              leading: const Icon(Icons.image, size: 40),
              title: Text(
                "from_gallery".tr,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
