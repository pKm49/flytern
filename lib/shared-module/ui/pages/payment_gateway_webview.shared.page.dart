import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/controllers/shared.controller.dart';
import 'package:flytern/shared-module/ui/components/confirm_dialogue.shared.component.dart';
import 'package:get/get.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PaymentGatewayWebView extends StatefulWidget {

  const PaymentGatewayWebView({Key? key }) : super(key: key);

  @override
  _PaymentGatewayWebViewState createState() => _PaymentGatewayWebViewState();
}

class _PaymentGatewayWebViewState extends State<PaymentGatewayWebView> {

  late InAppWebViewController controller;

  String gatewayUrl="";
  String confirmationUrl="";
  String summaryPageUrl="";
  bool isConfirmationReached = false;

  var getArguments = Get.arguments;
  final sharedController = Get.find<SharedController>();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setWebviewController();

  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return  WillPopScope(
        onWillPop: () async {
          return (await showDialog(
            context: context,
            builder: (_) => ConfirmDialogue(
                onClick: () async {
                  Navigator.of(context).pop(true);
                },
                titleKey: 'cancel_booking'.tr + " ?",
                subtitleKey: 'cancel_confirm'.tr),
          )
          ) ?? false;



        },
        child: Obx(
              ()=> Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: flyternBackgroundWhite,
              appBar: AppBar(
                title: Text('complete_payment'.tr),
              ),
              body:  InAppWebView(
                initialUrlRequest: URLRequest(url:Uri.parse(gatewayUrl) ),
                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                    )
                ),
                onReceivedServerTrustAuthRequest: (controller, challenge) async {
                  return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
                },
                onWebViewCreated: (InAppWebViewController controller) {
                  controller = controller;
                },
                onUpdateVisitedHistory: (InAppWebViewController controller, Uri? url, bool? flag) {
                  print("onUpdateVisitedHistory");
                  print(url);
                  print(flag);

                  if(url.toString().contains(confirmationUrl) ){
                    setBack(true);
                  }
                },
                onLoadStart: (InAppWebViewController controller, Uri? url) {
                    print("onLoadStart");
                    print(url);
                },
                onLoadStop: (InAppWebViewController controller, Uri? url) async {
                  print("onLoadStop");
                  print(url);
                  print(!url.toString().contains(confirmationUrl));
                  if(!url.toString().contains(confirmationUrl) ){
                    sharedController.changePaymentGatewayLoading(false);
                  }else{
                    isConfirmationReached = true;
                    setState(() {

                    });
                  }

                },
                onProgressChanged: (InAppWebViewController controller, int progress) {
                  print("onProgressChanged");
                  print(progress);
                  if(!isConfirmationReached){
                    if(progress == 100){
                      sharedController.changePaymentGatewayLoading(false);
                    }else{
                      sharedController.changePaymentGatewayLoading(true);
                    }
                  }


                },
              ),
              bottomSheet: (sharedController.paymentGatewayIsLoading.value || isConfirmationReached)? Container(
                  width: screenwidth,
                  height: screenheight,
                  color: flyternBackgroundWhite,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                ):Container(width: screenwidth,height: 1,)),
        ),
      );

  }

  void setWebviewController() {
    gatewayUrl = getArguments[0];
    confirmationUrl = getArguments[1];
    summaryPageUrl = getArguments[2];
    isConfirmationReached = false;
    setState(() {

    });
    // controller = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setBackgroundColor(const Color(0x00000000))
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onProgress: (int progress) {
    //         // Update loading bar.
    //       },
    //       onPageStarted: (String url) {},
    //       onPageFinished: (String url) {
    //         print("onPageFinished");
    //         print(url);
    //         setState(() {
    //           isLoading = false;
    //         });
    //       },
    //       onWebResourceError: (WebResourceError error) {
    //         print("WebResourceError");
    //         print(error);
    //       },
    //       onNavigationRequest: (NavigationRequest request) {
    //         print("NavigationRequest");
    //         print(request.url);
    //          if (request.url
    //             .contains(confirmationUrl)) {
    //           Future.delayed(const Duration(seconds: 1), () {
    //             //asynchronous delay
    //             // Get.until((route) => Get.currentRoute == '/OrderComplete');
    //             Get.back(result: true);
    //
    //           });
    //         }else{
    //           Get.back(result: false);
    //
    //         }
    //         return NavigationDecision.navigate;
    //       },
    //     ),
    //   );
    // controller.loadRequest(Uri.parse(gatewayUrl));


  }


  handleError(e) {
    print("catch error");
    print(e);
  }

  Future<void> setBack(bool status) async {

    sharedController.changePaymentGatewayLoading(false);
    sharedController.changePaymentGatewayBackConfirmation();
    setState(() {
    });

    await Future.delayed(const Duration(seconds: 2));
    sharedController.paymentGatewayGoback(status,summaryPageUrl);

  }
}
