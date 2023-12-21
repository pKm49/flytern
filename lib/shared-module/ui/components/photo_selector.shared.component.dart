 import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/toaster_snackbar_shower.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:mime/mime.dart';
import 'package:permission_handler/permission_handler.dart';

class PhotoSelector extends StatelessWidget {
  final Function(File? photo) photoSelected; // <------------|
  bool isVideosAllowed;

  PhotoSelector(
      {super.key, required this.photoSelected, required this.isVideosAllowed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: flyternLargePaddingAll,
      child: Wrap(
        children: [
          addVerticalSpace(flyternSpaceSmall),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              handleMediaClick(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.photo, color: flyternPrimaryColor),
                addHorizontalSpace(flyternSpaceMedium),
                Expanded(
                  child: Text("choose_from_gallery".tr),
                ),
              ],
            ),
          ),
          addVerticalSpace(flyternSpaceSmall),
          Divider(),
          addVerticalSpace(flyternSpaceSmall),
          InkWell(
            onTap: () async {
              Navigator.pop(context);
              if (await Permission.camera.request().isGranted) {
                getPictureFromCamera();
              } else {
                showSnackbar(
                    context, "camera_permission_message".tr, "error");
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.camera_alt, color: flyternPrimaryColor),
                addHorizontalSpace(flyternSpaceMedium),
                Expanded(
                  child: Text("open_camera".tr),
                ),
              ],
            ),
          ),
          addVerticalSpace(flyternSpaceSmall),
        ],
      ),
    );
  }

  openFilePicker() async {
    if (isVideosAllowed) {
      getPictureFromGallery();
    } else {
      final _picker = ImagePicker();
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        await cropImage(pickedFile.path!);
      } else {
        return;
      }
    }
  }

  Future<void> getPictureFromGallery() async {
    List<String> allowedExtensions = ['jpg', 'png', 'jpeg'];
    List<String> allowedVideExtensions = ['mp4', 'avi'];
    if (isVideosAllowed) {
      allowedExtensions.addAll(allowedVideExtensions);
    }

    FilePickerResult? result1 = await FilePicker.platform.pickFiles(
        // initialDirectory: ,
        type: FileType.custom,
        allowedExtensions: allowedExtensions);

    if (result1 == null) return;

    String? mimeStr = lookupMimeType(result1.files.first.path!);

    if (mimeStr == null) return;

    String fileType = mimeStr.split('/')[0];

    if (fileType == "image") {
      await cropImage(result1.files.first.path!);
    } else {
      photoSelected(File(result1.files.first.path!));
    }
  }

  Future<void> getPictureFromCamera() async {
    final _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      await cropImage(pickedFile.path!);
    } else {
      return;
    }
  }

  cropImage(filePath) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: filePath,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: flyternPrimaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ]);

    if (croppedFile != null) {
      photoSelected(File(croppedFile!.path));
    } else {
      photoSelected(null);
    }
  }

  Future<void> handleMediaClick(context) async {
    if (await permissionPhotoOrStorage()) {
      openFilePicker();
    } else {
      showSnackbar(context, "media_permission_message".tr, "error");
    }
  }


  Future<bool> permissionPhotoOrStorage() async {
    bool perm = false;
    if (Platform.isIOS) {
      perm = await permissionPhotos();
    } else if (Platform.isAndroid) {
      final AndroidDeviceInfo android = await DeviceInfoPlugin().androidInfo;
      final int sdkInt = android.version.sdkInt ?? 0;
      perm = sdkInt > 32 ? await permissionPhotos() : await permissionStorage();
    }
    return Future<bool>.value(perm);
  }

  Future<bool> permissionPhotos() async {
    bool hasPhotosPermission = false;
    final PermissionStatus try0 = await Permission.photos.status;
    if (try0 == PermissionStatus.granted) {
      hasPhotosPermission = true;
    } else {
      final PermissionStatus try1 = await Permission.photos.request();
      if (try1 == PermissionStatus.granted) {
        hasPhotosPermission = true;
      } else {}
    }
    return Future<bool>.value(hasPhotosPermission);
  }

  Future<bool> permissionStorage() async {
    bool hasStoragePermission = false;
    final PermissionStatus try0 = await Permission.storage.status;
    if (try0 == PermissionStatus.granted) {
      hasStoragePermission = true;
    } else {
      final PermissionStatus try1 = await Permission.storage.request();
      if (try1 == PermissionStatus.granted) {
        hasStoragePermission = true;
      } else {}
    }
    return Future<bool>.value(hasStoragePermission);
  }

}
