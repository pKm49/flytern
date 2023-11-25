import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flytern/shared-module/controllers/shared.controller.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/business_specific/info_types.shared.constant.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentPage extends StatefulWidget {
  const DocumentPage({super.key});

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  final sharedController = Get.find<SharedController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initstate info");
    sharedController.getBusinessInfo(InfoType.SOCIAL);
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(sharedController.currentInfoTitle.value),
        elevation: 0.5,
      ),
      body: Obx(
        ()=> Stack(
          children: [
            Visibility(
                visible:
                sharedController.isInfoLoading.value,
                child: Container(
                  width: screenwidth,
                  height: screenheight * .9,
                  color: flyternGrey10,
                  child: Center(
                      child: LoadingAnimationWidget.prograssiveDots(
                        color: flyternSecondaryColor,
                        size: 50,
                      )),
                )),
            Visibility(
                visible:
                !sharedController.isInfoLoading.value &&
                    getHtmlData() !="",
                child: Container(
                  width: screenwidth,
                  height: screenheight * .9,
                  color: flyternGrey10,
                  child: SingleChildScrollView(
                    child: Html(
                      data: getHtmlData(),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
  Future<void> _launchUrl(String urlString) async {
    final Uri _url = Uri.parse(urlString);

    if (!await launchUrl(_url)) {
      print('Could not launch $_url');
    }
  }

  getHtmlData() {
    print("");
    switch (sharedController.currentInfoType.value){
      case InfoType.ABOUTUS:{
         return sharedController.aboutHtml.value;
      }
      case InfoType.TERMS:{
        return sharedController.termsHtml.value;
      }
      case InfoType.PRIVACY:{
        return sharedController.privacyHtml.value;
      }
      case InfoType.CONTACTUS:{
        return sharedController.contactHtml.value;
      }
      case InfoType.SOCIAL:{
        return "";
      }
    }
  }

}
