import 'dart:convert';
import 'dart:io';
 
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:mime/mime.dart';

class PhotoSelector extends StatelessWidget {

  final Function(File? photo) photoSelected;      // <------------|
  bool isVideosAllowed;
    PhotoSelector({super.key, required this.photoSelected
    , required this.isVideosAllowed});

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
              openFilePicker();
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
            onTap: () {
              Navigator.pop(context);
              getPictureFromCamera();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.camera_alt,
                    color: flyternPrimaryColor),
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
    print("openFilePicker");
    print(isVideosAllowed);
    if(isVideosAllowed){
      getPictureFromGallery();
    }else{
      print("opening ImagePicker");

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

    print("opening file picker");

    List<String> allowedExtensions = ['jpg', 'png', 'jpeg'];
    List<String> allowedVideExtensions = ['mp4', 'avi'];
    if(isVideosAllowed){
      allowedExtensions.addAll(allowedVideExtensions);
    }

    FilePickerResult? result1 = await FilePicker.platform.pickFiles(
      // initialDirectory: ,
        type: FileType.custom, allowedExtensions: allowedExtensions);

    if (result1 == null) return;

    String? mimeStr = lookupMimeType(result1.files.first.path!);

    if(mimeStr == null) return;

    String fileType = mimeStr.split('/')[0];
    print("fileType");
    print(fileType);
    if(fileType == "image"){
        await cropImage(result1.files.first.path!);
    }else{
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
    }else{
      photoSelected(null);
    }
  }
}
