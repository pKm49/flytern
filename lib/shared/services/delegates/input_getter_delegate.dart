import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:ionicons/ionicons.dart';

class InputGetterDelegate extends StatefulWidget {
  String currentText;
  String hintText;
  final Function(String text) textSubmitted;

  InputGetterDelegate(
      {super.key,
      required this.hintText,
      required this.currentText,
      required this.textSubmitted});

  @override
  State<InputGetterDelegate> createState() => _InputGetterDelegateState();
}

class _InputGetterDelegateState extends State<InputGetterDelegate> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController.text = widget.currentText;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: TextFormField(
            autofocus: true,
            onFieldSubmitted: (String s) {
              widget.textSubmitted(textEditingController.text);
            },
            controller: textEditingController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              fillColor: flyternBackgroundWhite,
              hintText: widget.hintText,
            )),
        actions: [
          InkWell(
              onTap: () {
                textEditingController.text = "";
                setState(() {});
              },
              child: Icon(Ionicons.close)),
          addHorizontalSpace(flyternSpaceSmall)
        ],
      ),
    );
  }
}
