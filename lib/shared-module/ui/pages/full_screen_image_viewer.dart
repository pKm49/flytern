import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImageViewer extends StatefulWidget {
  const FullScreenImageViewer({super.key });

  @override
  State<FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer> {
  var getArguments = Get.arguments;
  String imageUrl = "";
  @override
  void initState() {
    print("getArguments");
    print(getArguments);
    // TODO: implement initState


    super.initState();
    imageUrl = getArguments[0];
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
        )
    );
  }
}
