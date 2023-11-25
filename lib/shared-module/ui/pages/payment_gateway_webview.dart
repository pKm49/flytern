import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared-module/services/utility-services/snackbar_shower.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentGatewayWebView extends StatefulWidget {

  const PaymentGatewayWebView({Key? key }) : super(key: key);

  @override
  _PaymentGatewayWebViewState createState() => _PaymentGatewayWebViewState();
}

class _PaymentGatewayWebViewState extends State<PaymentGatewayWebView> {
  var controller = WebViewController();
  String gatewayUrl="";
  String confirmationUrl="";
  var isLoading = true;
  var getArguments = Get.arguments;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setWebviewController();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: flyternBackgroundWhite,
          appBar: AppBar(
            title: Text('complete_payment'.tr),
          ),
          body: Stack(
            children: [
              WebViewWidget(controller: controller),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    )
                  : Stack(),
            ],
          )),
    );
  }

  void setWebviewController() {
    gatewayUrl = getArguments[0];
    confirmationUrl = getArguments[1];
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            print('navigate url ${request.url}');
            if (request.url
                .contains('https://api2.poundkw.com/api/payment/success')) {
              Future.delayed(const Duration(seconds: 1), () {
                //asynchronous delay
                // Get.until((route) => Get.currentRoute == '/OrderComplete');
                Get.back(result: true);

              });
            }else{
              Get.back(result: false);

            }
            return NavigationDecision.navigate;
          },
        ),
      );

    controller.loadRequest(Uri.parse(gatewayUrl));

  }
}
