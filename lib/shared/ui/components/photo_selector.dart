import 'dart:convert';
import 'dart:io';
 
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';

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
              getPictureFromGallery();
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

  Future<void> getPictureFromGallery() async {
    List<String> allowedExtensions = ['jpg', 'png', 'jpeg'];
    List<String> allowedVideExtensions = ['mp4', 'avi'];
    if(isVideosAllowed){
      allowedExtensions.addAll(allowedVideExtensions);
    }

    FilePickerResult? result1 = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: allowedExtensions);

    if (result1 == null) return;

    await cropImage(result1.files.first.path!);
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

