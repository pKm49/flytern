import 'package:flutter/material.dart';
import 'package:flytern/core-module/controllers/core.controller.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/selectable_text_pill.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationsPage extends StatefulWidget {
  NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final coreController = Get.find<CoreController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    coreController.getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text("notifications".tr),
          elevation: 0.5,
          actions: [
            Visibility(
              visible: !coreController.isNotificationsLoading.value &&
                  coreController.notifications.value.isNotEmpty,
              child: Container(
                padding: flyternExtraSmallPaddingAll.copyWith(
                    left: flyternSpaceSmall, right: flyternSpaceSmall),
                margin: flyternMediumPaddingAll,
                decoration: BoxDecoration(
                  color: flyternSecondaryColor,
                  borderRadius:
                      BorderRadius.circular(flyternBorderRadiusExtraSmall),
                ),
                child: Center(
                    child: Text(
                  coreController.notifications.value.length.toString(),
                  style: TextStyle(color: flyternBackgroundWhite),
                )),
              ),
            ),
          ],
        ),
        body: Container(
          width: screenwidth,
          height: screenheight,
          child: Stack(
            children: [
              Visibility(
                visible: !coreController.isNotificationsLoading.value &&
                    coreController.notifications.value.isEmpty,
                child: Container(
                  width: screenwidth,
                  height: screenheight,
                  color: flyternGrey10,
                  child: Center(
                    child:
                        Text("no_item".tr, style: getBodyMediumStyle(context)),
                  ),
                ),
              ),
              Visibility(
                visible: !coreController.isNotificationsLoading.value &&
                    coreController.notifications.value.isNotEmpty,
                child: Container(
                  width: screenwidth,
                  height: screenheight,
                  color: flyternGrey10,
                  child: ListView.builder(
                      itemCount: coreController.notifications.value.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            if (coreController
                                .notifications.value[i].isRedirection) {
                              _launchUrl(coreController
                                  .notifications.value[i].redirectionUrl);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: i ==
                                        (coreController.notifications.length -
                                            1)
                                    ? null
                                    : flyternDefaultBorderBottomOnly),
                            child: Container(
                              width: screenwidth,
                              color: flyternBackgroundWhite,
                              padding: flyternLargePaddingAll,
                              child: Wrap(
                                runSpacing: flyternSpaceSmall,
                                spacing: flyternSpaceSmall,
                                direction: Axis.vertical,
                                children: [
                                  Text(
                                    coreController
                                        .notifications.value[i].header,
                                    style: getBodyMediumStyle(context).copyWith(
                                        fontWeight: flyternFontWeightBold),
                                  ),
                                  Container(
                                    width:
                                        screenwidth - (flyternSpaceLarge * 2),
                                    child: Text(
                                      coreController
                                          .notifications.value[i].information,
                                      style: getBodyMediumStyle(context)
                                          .copyWith(color: flyternGrey60),
                                    ),
                                  ),
                                  Text(
                                    coreController
                                        .notifications.value[i].entryOn,
                                    style: getLabelLargeStyle(context)
                                        .copyWith(color: flyternGrey40),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
              Visibility(
                visible: coreController.isNotificationsLoading.value,
                child: Container(
                  width: screenwidth,
                  height: screenheight,
                  color: flyternGrey10,
                  child: Center(
                      child: LoadingAnimationWidget.prograssiveDots(
                    color: flyternSecondaryColor,
                    size: 50,
                  )),
                ),
              )
            ],
          ),
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
}
