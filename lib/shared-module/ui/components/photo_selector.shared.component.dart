 import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/toaster_snackbar_shower.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
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
              handleCameraClick(context);
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
    print("handleMediaClick");
    if (Platform.isIOS) {
      if (await Permission.photos.isGranted) {
        openFilePicker();
      } else {
        if (await Permission.photos.isPermanentlyDenied) {
          showSnackbar(context, "media_permission_message".tr, "error");
        }else{
          showPhotosPermissionDialogue( );
        }
      }
    } else if (Platform.isAndroid) {
      final AndroidDeviceInfo android = await DeviceInfoPlugin().androidInfo;
      final int sdkInt = android.version.sdkInt;
    print("Device is Android");
    print(sdkInt);
      if(sdkInt>32){
        print("sdkInt>32");

        if (await Permission.photos.isGranted) {
          print("Permission is granted");
          openFilePicker();
        } else {
          print("Permission not granted");
          if (await Permission.photos.isPermanentlyDenied) {
            print("Permission isPermanentlyDenied");
            showSnackbar(context, "media_permission_message".tr, "error");
          }else{
            print("Permission is not PermanentlyDenied");
            showPhotosPermissionDialogue( );
          }
        }
      }else{
        print("sdkInt<32");
        if (await Permission.storage.isGranted) {
          openFilePicker();
        } else {
          if (await Permission.storage.isPermanentlyDenied) {
            showSnackbar(context, "media_permission_message".tr, "error");
          }else{
            showPhotosPermissionDialogue( );
          }
        }
      }
     }

  }

  Future<void> handleCameraClick(BuildContext context) async {
    if (await Permission.camera.isGranted) {
    getPictureFromCamera();
    } else {
      if (await Permission.camera.isPermanentlyDenied) {
        showSnackbar(
            context, "camera_permission_message".tr, "error");
      }else{
        showCameraPermissionDialogue();
      }

    }
  }

  void showPhotosPermissionDialogue() async {

    BuildContext context = Get.context!;

    final dialogTitleWidget = Text('photo_access_permission_title'.tr,style: getHeadlineMediumStyle(context).copyWith(color: flyternGrey80,fontWeight: flyternFontWeightBold));
    final dialogTextWidget = Text( 'photo_access_permission_info'.tr,style: getBodyMediumStyle(context));
    final why_permission_q = Text( 'why_permission_q'.tr,style: getBodyMediumStyle(context).copyWith(fontWeight: flyternFontWeightBold));
    final photo_access_permission_why_a = Text( 'photo_access_permission_why_a'.tr,style: getBodyMediumStyle(context));
    final how_permission_q = Text( 'how_permission_q'.tr,style: getBodyMediumStyle(context).copyWith(fontWeight: flyternFontWeightBold));
    final photo_camear_access_permission_how_a1 = Text( 'photo_camear_access_permission_how_a1'.tr,style: getBodyMediumStyle(context));
    final photo_access_permission_how_a2 = Text( 'photo_access_permission_how_a2'.tr,style: getBodyMediumStyle(context));
    final privacy_at_core = Text( 'privacy_at_core'.tr,style: getBodyMediumStyle(context).copyWith(fontWeight: flyternFontWeightBold));
    final privacy_at_core_info1 = Text( 'privacy_at_core_info1'.tr,style: getBodyMediumStyle(context));
    final privacy_at_core_info2 = Text( 'privacy_at_core_info2'.tr,style: getBodyMediumStyle(context));
    final thanks_for_personalizing = Text( 'thanks_for_personalizing'.tr,style: getBodyMediumStyle(context));

    final updateButtonTextWidget = Text('continue'.tr);
    final updateButtonCancelTextWidget = Text('cancel'.tr);

    updateAction() async {
      Navigator.pop(context);
      if (Platform.isIOS) {
        final PermissionStatus try1 = await Permission.photos.request();
        if (try1 == PermissionStatus.granted) {
          openFilePicker();
        }else{
          showSnackbar(
              context, "media_permission_message".tr, "error");
        }
      }else{
        final AndroidDeviceInfo android = await DeviceInfoPlugin().androidInfo;
        final int sdkInt = android.version.sdkInt;
        if(sdkInt>32){
          final PermissionStatus try1 = await Permission.photos.request();
          if (try1 == PermissionStatus.granted) {
            openFilePicker();
          }else{
            showSnackbar(
                context, "media_permission_message".tr, "error");
          }
        }else{
          final PermissionStatus try1 = await Permission.storage.request();
          if (try1 == PermissionStatus.granted) {
            openFilePicker();
          }else{
            showSnackbar(
                context, "media_permission_message".tr, "error");
          }
        }
      }
    }

    List<Widget> actions = [

      TextButton(onPressed: (){
        Navigator.pop(context);
      }, child: updateButtonCancelTextWidget),

      ElevatedButton(
          onPressed:updateAction,
          style: getElevatedButtonStyle(context).copyWith(padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(
                  horizontal: flyternSpaceLarge,
                  vertical: flyternSpaceSmall))),
          child:  updateButtonTextWidget)
    ];

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
            child: AlertDialog(
              title: dialogTitleWidget,
              content: Container(
                height: 700,
                width: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    dialogTextWidget,
                    why_permission_q,
                    photo_access_permission_why_a,
                    how_permission_q,
                    photo_camear_access_permission_how_a1,
                    photo_access_permission_how_a2,
                    privacy_at_core,
                    privacy_at_core_info1,
                    privacy_at_core_info2,
                    thanks_for_personalizing
                  ],
                ),
              ),
              actions: actions,
            ),
            onWillPop: () => Future.value(false));
      },
    );

  }

  void showCameraPermissionDialogue() async {
    BuildContext context = Get.context!;

    final dialogTitleWidget = Text('camera_access_permission_title'.tr,style: getHeadlineMediumStyle(context).copyWith(color: flyternGrey80,fontWeight: flyternFontWeightBold));
    final dialogTextWidget = Text( 'camera_access_permission_info'.tr,style: getBodyMediumStyle(context),);

    final why_permission_q = Text( 'why_permission_q'.tr,style: getBodyMediumStyle(context).copyWith(fontWeight: flyternFontWeightBold));
    final camera_access_permission_why_a = Text( 'camera_access_permission_why_a'.tr,style: getBodyMediumStyle(context));
    final how_permission_q = Text( 'how_permission_q'.tr,style: getBodyMediumStyle(context).copyWith(fontWeight: flyternFontWeightBold));
    final photo_camear_access_permission_how_a1 = Text( 'photo_camear_access_permission_how_a1'.tr,style: getBodyMediumStyle(context));
    final camera_access_permission_how_a2 = Text( 'camera_access_permission_how_a2'.tr,style: getBodyMediumStyle(context));
    final privacy_at_core = Text( 'privacy_at_core'.tr,style: getBodyMediumStyle(context).copyWith(fontWeight: flyternFontWeightBold));
    final privacy_at_core_info1 = Text( 'privacy_at_core_info1'.tr,style: getBodyMediumStyle(context));
    final privacy_at_core_info2 = Text( 'privacy_at_core_info2'.tr,style: getBodyMediumStyle(context));
    final thanks_for_personalizing = Text( 'thanks_for_personalizing'.tr,style: getBodyMediumStyle(context));

    final updateButtonTextWidget = Text('continue'.tr);
    final updateButtonCancelTextWidget = Text('cancel'.tr);

    updateAction() async {
      Navigator.pop(context);
      final PermissionStatus try1 = await Permission.camera.request();
      if (try1 == PermissionStatus.granted) {
        getPictureFromCamera();
      }else{
        showSnackbar(
            context, "camera_permission_message".tr, "error");
      }

    }

    List<Widget> actions = [

      TextButton(onPressed: (){
        Navigator.pop(context);
      }, child: updateButtonCancelTextWidget),

      ElevatedButton(
          onPressed:updateAction,
          style: getElevatedButtonStyle(context).copyWith(padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(
                  horizontal: flyternSpaceLarge,
                  vertical: flyternSpaceSmall))),
          child:  updateButtonTextWidget)
    ];

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
            child:AlertDialog(
              title: dialogTitleWidget,
              content: Container(
                height: 700,
                width: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    dialogTextWidget,
                    why_permission_q,
                    camera_access_permission_why_a,
                    how_permission_q,
                    photo_camear_access_permission_how_a1,
                    camera_access_permission_how_a2,
                    privacy_at_core,
                    privacy_at_core_info1,
                    privacy_at_core_info2,
                    thanks_for_personalizing
                  ],
                ),
              ),
              actions: actions,
            ),
            onWillPop: () => Future.value(false));
      },
    );

  }

}
