import 'package:flutter/material.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/models/general_item.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:ionicons/ionicons.dart';

class DropDownSelector extends StatefulWidget {

  var selected;
  List<GeneralItem> items = [];
  final titleText;
  final hintText;
  final isBold;

  final Function(String) valueChanged;

  DropDownSelector({Key? key, required this.items,this.hintText,this.isBold, this.titleText, required this.valueChanged, this.selected}) : super(key: key);

  @override
  _DropDownSelectorState createState() => _DropDownSelectorState();
}

class _DropDownSelectorState extends State<DropDownSelector> {

  @override
  Widget build(BuildContext context) {

    double screenheight = ((MediaQuery.of(context).size.height * .9) - 60.0);
    double screenwidth = MediaQuery.of(context).size.width;

    return DropdownButton<String>(
      icon: Icon(Ionicons.caret_down,color: flyternGrey60),
      value:  widget.selected != null?widget.selected.toString():null,
      iconSize: flyternFontSize16,
      isExpanded: true,
      elevation: 16,
      hint:Text(widget.hintText??"",textAlign: TextAlign.start,style: getBodyMediumStyle(context),) ,
      borderRadius:  BorderRadius.all(const Radius.circular(flyternBorderRadiusExtraSmall)),
      style: TextStyle(                  fontSize: screenwidth*.035,
          color:flyternGrey60),
      underline: Container(
        height: 1,
        color: Colors.transparent,
      ),
      onChanged: (String? Value) {
        setState(() {
          widget.selected = Value;
          widget.valueChanged(Value!);
        });
      },
      items: widget.items.map((GeneralItem value) {
        return DropdownMenuItem<String>(
          value: value.id.toString(),
          child: Row(
            children: [
              Visibility(
                  visible: value.imageUrl !="",
                  child: Padding(
                    padding: const EdgeInsets.only(right: flyternSpaceMedium),
                    child: Image.network(value.imageUrl??"", width: 30),
                  )),
              Expanded(
                child: Text(value.name,textAlign: TextAlign.start,
                  maxLines: 2,
                  style: TextStyle(color:  flyternGrey60),),
              ),
            ],
          ),
        );
      }).toList(),
    );

  }
}