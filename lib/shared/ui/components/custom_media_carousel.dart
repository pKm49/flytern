import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:ionicons/ionicons.dart';

class CustomMediaCarousel extends StatefulWidget {
  List<String> medias = [];
  CustomMediaCarousel({Key? key, required this.medias}) : super(key: key);

  @override
  _CustomMediaCarouselState createState() => _CustomMediaCarouselState();
}

class _CustomMediaCarouselState extends State<CustomMediaCarousel> {
  int currentPos = 0;


  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Container(
      width: screenwidth  ,
      height: screenwidth +28,

      child: Column(
        children: [
          // Stack(
          //   children: [
          //
          //     Container(
          //       width: screenwidth,
          //       height: screenwidth,
          //       padding: flyternMediumPaddingAll,
          //       alignment: Alignment.center,
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           InkWell(
          //             child: Container(
          //                 decoration: BoxDecoration(
          //                   boxShadow: flyternItemShadow
          //                 ),
          //                 child: Icon(Ionicons.chevron_back_circle,size: flyternFontSize24*1.3,color: flyternBackgroundWhite)),
          //           ),
          //           InkWell(
          //             child: Container(
          //                 decoration: BoxDecoration(
          //                     boxShadow: flyternItemShadow
          //                 ),
          //                 child: Icon(Ionicons.chevron_forward_circle,size: flyternFontSize24*1.3,color: flyternBackgroundWhite)),
          //           ),
          //
          //          ],
          //       ),
          //     )
          //   ],
          // ),
          CarouselSlider(
              options: CarouselOptions(
                  aspectRatio: 16 /16,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentPos = index;
                    });
                  },
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  initialPage: 0),
              items: [
                for (var i = 0; i < widget.medias.length; i++)
                  Container(width: screenwidth  ,
                      height: screenwidth ,
                      child: Image.network(widget.medias[i],
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: flyternGrey40,
                            width: screenwidth  ,
                            height: screenwidth +30 ,
                          );
                        },))
              ]),
          Visibility(
            visible: widget.medias.length>1,
            child: Container(
              color: flyternBackgroundWhite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for(var i=0;i<widget.medias.length;i++)
                    Container(
                      width: 8.0,
                      height: 8.0,
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentPos == i
                            ? flyternBlack
                            : flyternGrey40,
                      ),
                    )

                ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}
