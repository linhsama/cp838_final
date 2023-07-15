// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cp838_seller_project/consts/consts.dart';
import 'package:cp838_seller_project/controllers/profile_controller.dart';
import 'package:cp838_seller_project/widget_common/bg_widget.dart';
import 'package:cp838_seller_project/widget_common/custom_button.dart';
import 'package:cp838_seller_project/widget_common/custom_textfield.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    var controller = Get.put(ProfileController());

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: editProfile.text.fontFamily(bold).white.make(),
        ),
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                data['imageUrl'] != ''
                    ? Image.network(
                        data['imageUrl'],
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    : Image.file(
                        File(controller.profileImgPath.value),
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
                10.widthBox,
                TextButton(
                  onPressed: () {
                    Get.find<ProfileController>().changeImage(context: context);
                  },
                  child: const Icon(
                    Icons.add_a_photo,
                    color: textfieldGrey,
                  ),
                ),
                const Divider(),
                20.heightBox,
                customTextField(
                    title: shopname,
                    hint: shopnameHint,
                    controller: controller.shopnameController,
                    obscureText: false,
                    keyboardTypes: TextInputType.text),
                customTextField(
                    title: oldPassword,
                    hint: passwordHint,
                    controller: controller.oldPasswordController,
                    obscureText: true,
                    keyboardTypes: TextInputType.text),
                customTextField(
                    title: newPassword,
                    hint: passwordHint,
                    controller: controller.newPasswordController,
                    obscureText: true,
                    keyboardTypes: TextInputType.text),
                controller.isLoading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : SizedBox(
                        width: context.screenWidth - 60,
                        child: customButton(
                            onPress: () async {
                              controller.isLoading(true);

                              //if old password matches data
                              if (controller.oldPasswordController.text ==
                                  data['password']) {
                                controller.changeAuthPassword(
                                    email: data['email'],
                                    password:
                                        controller.oldPasswordController.text,
                                    newPassword:
                                        controller.newPasswordController.text);

                                //if image is not selected
                                if (controller
                                    .profileImgPath.value.isNotEmpty) {
                                  await controller.uploadProfileImage(context);
                                } else {
                                  controller.profileImageLink =
                                      data['imageUrl'];
                                }
                                await controller.updateProfile(
                                    shopname:
                                        controller.shopnameController.text,
                                    password: controller.newPasswordController
                                            .text.isEmptyOrNull
                                        ? controller.oldPasswordController.text
                                        : controller.newPasswordController.text,
                                    imageUrl: controller.profileImageLink,
                                    context: context);

                                Get.back();
                              } else {
                                VxToast.show(context, msg: 'Wrong password');
                                controller.isLoading(false);
                              }
                            },
                            color: redColor,
                            textColor: whiteColor,
                            title: updateProfile),
                      )
              ],
            )
                .box
                .white
                .shadowSm
                .roundedSM
                .padding(const EdgeInsets.all(16.0))
                .margin(
                    const EdgeInsets.only(top: 50.0, left: 12.0, right: 12.0))
                .make(),
          ),
        ),
      ),
    );
  }
}
