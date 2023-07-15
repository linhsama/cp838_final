// ignore_for_file: use_build_context_synchronously

import 'package:cp838_seller_project/consts/consts.dart';
import 'package:cp838_seller_project/controllers/profile_controller.dart';
import 'package:cp838_seller_project/widget_common/bg_widget.dart';
import 'package:cp838_seller_project/widget_common/custom_button.dart';
import 'package:cp838_seller_project/widget_common/custom_textfield.dart';

class EditShopScreen extends StatelessWidget {
  final dynamic data;
  const EditShopScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    var controller = Get.find<ProfileController>();

    controller.shopnameController.text =
        controller.shopnameController.text.isEmptyOrNull
            ? data['shopname']
            : controller.shopnameController.text;
    controller.phonenumberController.text =
        controller.phonenumberController.text.isEmptyOrNull
            ? data['shopPhoneNumber']
            : controller.phonenumberController.text;
    controller.websiteController.text =
        controller.websiteController.text.isEmptyOrNull
            ? data['shopWebsite']
            : controller.websiteController.text;
    controller.addressController.text =
        controller.addressController.text.isEmptyOrNull
            ? data['shopAddress']
            : controller.addressController.text;
    controller.descriptionController.text =
        controller.descriptionController.text.isEmptyOrNull
            ? data['shopDesc']
            : controller.descriptionController.text;

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: editShop.text.fontFamily(bold).white.make(),
        ),
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                customTextField(
                    title: shopname,
                    hint: shopnameHint,
                    controller: controller.shopnameController,
                    obscureText: false,
                    keyboardTypes: TextInputType.text),
                customTextField(
                    title: phonenumber,
                    hint: phonenumberHint,
                    controller: controller.phonenumberController,
                    obscureText: false,
                    keyboardTypes: TextInputType.number),
                customTextField(
                    title: website,
                    hint: websiteHint,
                    controller: controller.websiteController,
                    obscureText: false,
                    keyboardTypes: TextInputType.text),
                customTextField(
                    title: address,
                    hint: addressHint,
                    controller: controller.addressController,
                    obscureText: false,
                    keyboardTypes: TextInputType.text),
                customTextField(
                    title: description,
                    hint: descriptionHint,
                    controller: controller.descriptionController,
                    obscureText: false,
                    keyboardTypes: TextInputType.text),
                controller.isLoading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : SizedBox(
                        width: context.screenWidth - 60,
                        child: customButton(
                            onPress: () async {
                              if (controller
                                  .shopnameController.text.isEmptyOrNull) {
                                VxToast.show(context,
                                    msg: 'Shop name is required');
                              } else if (controller
                                  .phonenumberController.text.isEmptyOrNull) {
                                VxToast.show(context,
                                    msg: 'Phone number is required');
                              } else if (controller
                                  .addressController.text.isEmptyOrNull) {
                                VxToast.show(context,
                                    msg: 'Address is required');
                              } else if (controller
                                  .descriptionController.text.isEmptyOrNull) {
                                VxToast.show(context,
                                    msg: 'Description is required');
                              } else {
                                controller.isLoading(true);

                                await controller.updateShop(
                                    shopname:
                                        controller.shopnameController.text,
                                    phonenumber:
                                        controller.phonenumberController.text,
                                    website: controller.websiteController.text,
                                    address: controller.addressController.text,
                                    description:
                                        controller.descriptionController.text,
                                    context);

                                Get.back();
                              }
                            },
                            color: red,
                            textColor: whiteColor,
                            title: updateShop),
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
