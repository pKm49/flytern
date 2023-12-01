import 'package:flutter/material.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImageViewer extends StatefulWidget {
  const FullScreenImageViewer({super.key});

  @override
  State<FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer> {

  var getArguments = Get.arguments;
  String imageUrl = "";
  List<String> galleryImages = [];
  int selectedImageIndex = -1;

  @override
  void initState() {
    print("getArguments");
    print(getArguments);
    // TODO: implement initState

    super.initState();
    imageUrl = getArguments[0];
    galleryImages = getArguments[1]??[];
    selectedImageIndex = getSelectedImageIndex();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
      ),
      body: Container(
          width: screenwidth,
          height: screenheight,
          child: Column(
            children: [
              Expanded(
                child: PhotoView(
                  imageProvider: NetworkImage(
                      galleryImages.isNotEmpty?
                      galleryImages[selectedImageIndex]:imageUrl),
                ),
              ),
              Visibility(
                visible: galleryImages.isNotEmpty,
                child: Container(
                  padding: flyternMediumPaddingAll.copyWith(
                      bottom: 0, top: 0),
                  margin: flyternLargePaddingVertical,
                  height: screenwidth * .15,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (var i = 0;
                      i <
                          galleryImages.length;
                      i++)
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedImageIndex = i;
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      flyternBorderRadiusExtraSmall),
                                  border: Border.all(
                                      color: i ==
                                          selectedImageIndex
                                          ? flyternSecondaryColor
                                          : Colors.transparent,
                                      width: 2)),
                              margin: EdgeInsets.only(
                                  right: flyternSpaceSmall),
                              clipBehavior: Clip.hardEdge,
                              height: screenwidth * .16,
                              child: Image.network(  galleryImages[i],
                                  height: screenwidth * .2, errorBuilder:
                                      (context, error, stackTrace) {
                                    return Container(
                                      color: flyternGrey10,
                                      height: screenwidth * .2,
                                      child: Center(
                                        child: Icon(
                                          Icons.business,
                                          color: flyternGrey40,
                                        ),
                                      ),
                                    );
                                  })),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  int getSelectedImageIndex() {
    if(galleryImages.isEmpty){
      return -1;
    }
    for(var i=0;i<galleryImages.length;i++){
       if(galleryImages[i]==imageUrl){
         return i;
       }
    }
    return -1;
  }
}
