
import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/profile/controllers/copax.profile.controller.dart';
 import 'package:flytern/feature-modules/profile/models/user-copax.profile.model.dart';
import 'package:flytern/shared-module/ui/components/confirm_dialogue.shared.component.dart';
import 'package:flytern/shared-module/ui/components/user_details_card.shared.component.dart';
 import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';

class ProfileMyCoPassengersPage extends StatefulWidget {
  const ProfileMyCoPassengersPage({super.key});

  @override
  State<ProfileMyCoPassengersPage> createState() =>
      _ProfileMyCoPassengersPageState();
}

class _ProfileMyCoPassengersPageState extends State<ProfileMyCoPassengersPage> {
  final coPaxController = Get.find<CoPaxController>();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('co_passengers'.tr),
        elevation: 0.5,
      ),
      body: Obx(
            ()=>  Container(
          width: screenwidth,
          height: screenheight,
          color: flyternGrey10,
          child: Column(
            children: [
              Padding(
                padding: flyternLargePaddingAll,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      child: Text("add_co_passenger".tr,
                          style: getBodyMediumStyle(context).copyWith(
                              decoration: TextDecoration.underline,
                              color: flyternTertiaryColor)),
                      onTap: () {
                        coPaxController.initializeAuditData(true,true);
                      },
                    ),
                  ],
                ),
              ),
                Visibility(
                  visible:coPaxController.isSubmitting.value,
                  child: LinearProgressIndicator(
                    backgroundColor: flyternPrimaryColor,
                    color: flyternSecondaryColor,
                  )),
              Visibility(
                visible: getCopax().isEmpty,
                child: Container(
                  width: screenwidth,
                  color: flyternBackgroundWhite,
                  padding: flyternLargePaddingAll,
                  child: Center(
                    child: Text("no_item".tr,style: getBodyMediumStyle(context).copyWith(
                        color: flyternGrey60
                    ),),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: getCopax().length,
                    itemBuilder: (BuildContext context, int index) {
                      return  UserDetailsCard(
                        onDelete: (){
                          showDeleteConfirmDialog(getCopax()[index].id);
                        },
                        onEdit: (){
                          coPaxController.updateEditForm(getCopax()[index]);
                        },
                        isActionAllowed: true,
                        passportNumber: getCopax()[index].passportNumber,
                        name: "${getCopax()[index].title} ${getCopax()[index].firstName} ${getCopax()[index].lastName}",
                        age: getAge(getCopax()[index].dateOfBirth),
                        gender: getCopax()[index].gender,
                      );
                    }),
              ),

            ],
          ),
        ),
      ),
    );
  }

  showDeleteConfirmDialog(int id) async {

    showDialog(
      context: context,
      builder: (_) => ConfirmDialogue(
          onClick:() async {
            if(!coPaxController.isSubmitting.value){
              coPaxController.deleteCoPax(id);
              Navigator.pop(context);
            }

          },
          titleKey: 'are_you_sure'.tr, subtitleKey: ''),
    );

  }

  getAge(DateTime dateOfBirth) {

    int currenYear = DateTime.now().year;
    int dobYear = dateOfBirth.year;
    return "${currenYear - dobYear} years";
  }

  List<UserCoPax> getCopax() {
    return coPaxController.userCopaxes.where((p0) => p0.id != 0).toList() ;
  }
 

}
