import 'package:cp838_seller_project/consts/consts.dart';
import 'package:cp838_seller_project/controllers/product_controller.dart';
import 'package:cp838_seller_project/views/category_screen/components/product_image.dart';
import 'package:cp838_seller_project/widget_common/bg_widget.dart';
import 'package:cp838_seller_project/widget_common/custom_button.dart';
import 'package:cp838_seller_project/widget_common/custom_textfield.dart';

class AddCategory extends StatelessWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    var controller = Get.put(ProductController());

    checkUpload() {
      Future.delayed(
        const Duration(seconds: 1),
        () {
          if (controller.pImagesLink.length == 1) {
            controller.addCategory(context: context);
            Get.back();
          } else {
            checkUpload();
          }
        },
      );
    }

    return Material(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: purpleColor, //change your color here
          ),
          title: 'Add category'.text.fontFamily(bold).color(purpleColor).make(),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: FloatingActionButton(
            backgroundColor: purpleColor,
            onPressed: () async {
              await controller.getCategories();
              controller.populateCategoryList();
              Get.to(() => const AddCategory());
            },
            child: const Icon(Icons.add)),
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                customTextField(
                    title: 'Category name',
                    hint: 'category name',
                    controller: controller.cnameController,
                    obscureText: false,
                    keyboardTypes: TextInputType.text),
                customTextField(
                    isDesc: true,
                    title: 'Category description',
                    hint: 'category description',
                    controller: controller.cdescController,
                    obscureText: false,
                    keyboardTypes: TextInputType.text),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Add Images"
                        .text
                        .color(purpleColor)
                        .fontFamily(semibold)
                        .size(16.0)
                        .make(),
                    5.heightBox,
                    controller.pImagesList[0] != null
                        ? Image.file(
                            controller.pImagesList[0],
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ).onTap(() {
                            controller.pickImage(0, context);
                          })
                        : productImage(
                                label: const Icon(Icons.add_photo_alternate))
                            .onTap(() {
                            controller.pickImage(0, context);
                          }),
                    5.heightBox,
                  ],
                ),
                10.heightBox,
                SizedBox(
                  width: context.screenWidth - 60,
                  child: customButton(
                      onPress: () {
                        if (controller.cnameController.text.isEmptyOrNull) {
                          VxToast.show(context,
                              msg: 'Category name is required');
                        } else {
                          controller.uploadImage(context: context);
                          checkUpload();
                        }
                      },
                      color: red,
                      textColor: whiteColor,
                      title: "Add caterory"),
                )
              ],
            )
                .box
                .white
                .shadowSm
                .roundedSM
                .padding(const EdgeInsets.all(12.0))
                .margin(const EdgeInsets.all(12.0))
                .make(),
          ),
        ),
      ),
    );
  }
}
