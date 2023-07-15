// ignore_for_file: must_be_immutable

import 'package:cp838_seller_project/consts/consts.dart';
import 'package:cp838_seller_project/controllers/product_controller.dart';
import 'package:cp838_seller_project/views/category_screen/components/product_color.dart';
import 'package:cp838_seller_project/views/category_screen/components/product_image.dart';
import 'package:cp838_seller_project/widget_common/bg_widget.dart';
import 'package:cp838_seller_project/widget_common/custom_button.dart';
import 'package:cp838_seller_project/widget_common/custom_textfield.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class EditProduct extends StatelessWidget {
  dynamic data;

  EditProduct({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    var controller = Get.put(ProductController());
    controller.categoryValue.value = data['p_category'].toString();
    controller.pnameController.text =
        controller.pnameController.text.isEmptyOrNull
            ? data['p_name']
            : controller.pnameController.text;
    controller.ppriceController.text =
        controller.ppriceController.text.isEmptyOrNull
            ? data['p_price']
            : controller.ppriceController.text;
    controller.pquantityController.text =
        controller.pquantityController.text.isEmptyOrNull
            ? data['p_quantity']
            : controller.pquantityController.text;
    controller.pdescController.text =
        controller.pdescController.text.isEmptyOrNull
            ? data['p_desc']
            : controller.pdescController.text;
    checkUpload() {
      Future.delayed(
        const Duration(seconds: 1),
        () {
          if (controller.pImagesLink.length ==
              controller.getImgs(controller.pImagesList).length) {
            controller.updateProduct(id: data.id, context: context);
            // Get.back();
          } else {
            checkUpload();
          }
        },
      );
    }

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: 'Edit'.text.fontFamily(bold).white.make(),
        ),
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                customTextField(
                    title: pname,
                    hint: pnameHint,
                    controller: controller.pnameController,
                    obscureText: false,
                    keyboardTypes: TextInputType.text),
                customTextField(
                    title: pprice,
                    hint: ppriceHint,
                    controller: controller.ppriceController,
                    obscureText: false,
                    keyboardTypes: TextInputType.number),
                customTextField(
                    title: pquantity,
                    hint: pquantityHint,
                    controller: controller.pquantityController,
                    obscureText: false,
                    keyboardTypes: TextInputType.number),
                customTextField(
                    isDesc: true,
                    title: pdesc,
                    hint: pdescHint,
                    controller: controller.pdescController,
                    obscureText: false,
                    keyboardTypes: TextInputType.text),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  //      .text
                  //    "Category"
                  //       .color(purpleColor)
                  //       .fontFamily(semibold)
                  //       .size(16.0)
                  //       .make(),
                  //   5.heightBox,
                  // productDropdown(
                  //     hint: 'Category',
                  //     list: controller.categoryList,
                  //     dropvalue: controller.categoryValue,
                  //     controller: controller),
                  SwitchListTile(
                    value: controller.isNew.value,
                    onChanged: (newValue) {
                      controller.isNew.value = newValue;
                    },
                    activeColor: red,
                    title: 'Hot & new'
                        .text
                        .color(purpleColor)
                        .fontFamily(semibold)
                        .make(),
                  ),
                ]),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(
                            data['p_imgs'].length,
                            (index) => controller.pImagesList[index] == null &&
                                    data['p_imgs'][index] != null
                                ? Image.network(
                                    data['p_imgs'][index],
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  )
                                    .onTap(() {
                                      controller.pickImage(index, context);
                                    })
                                    .box
                                    .margin(const EdgeInsets.all(10))
                                    .make()
                                : controller.pImagesList[index] != null
                                    ? Image.file(
                                        controller.pImagesList[index],
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      )
                                        .onTap(() {
                                          controller.pickImage(index, context);
                                        })
                                        .box
                                        .margin(const EdgeInsets.all(10))
                                        .make()
                                    : productImage(
                                            label: const Icon(
                                                Icons.add_photo_alternate))
                                        .onTap(() {
                                        controller.pickImage(index, context);
                                      }),
                          ),
                        ),
                        5.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(
                            3 - int.parse(data['p_imgs'].length.toString()),
                            (index) => controller.pImagesList[index +
                                        3 -
                                        int.parse(
                                            data['p_imgs'].length.toString()) -
                                        1] !=
                                    null
                                ? Image.file(
                                    controller.pImagesList[index +
                                        3 -
                                        int.parse(
                                            data['p_imgs'].length.toString()) -
                                        1],
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  )
                                    .onTap(() {
                                      controller.pickImage(
                                          index +
                                              3 -
                                              int.parse(data['p_imgs']
                                                  .length
                                                  .toString()) -
                                              1,
                                          context);
                                    })
                                    .box
                                    .margin(const EdgeInsets.all(10))
                                    .make()
                                : productImage(
                                        label: const Icon(
                                            Icons.add_photo_alternate))
                                    .box
                                    .margin(const EdgeInsets.all(10))
                                    .make()
                                    .onTap(() {
                                    controller.pickImage(
                                        index +
                                            3 -
                                            int.parse(data['p_imgs']
                                                .length
                                                .toString()) -
                                            1,
                                        context);
                                  }),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                10.heightBox,
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Choose colors"
                        .text
                        .color(purpleColor)
                        .fontFamily(semibold)
                        .size(16.0)
                        .make(),
                    5.heightBox,
                    Row(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(
                            int.parse(controller
                                .getColors(data['p_colors'])
                                .length
                                .toString()),
                            (index) => controller.pColorsList[index] == null &&
                                    data['p_colors'][index] != null
                                ? VxBox()
                                    .size(40, 40)
                                    .roundedSM
                                    .color(Color(data['p_colors'][index])
                                        .withOpacity(1.0))
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4.0))
                                    .make()
                                    .onTap(
                                    () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            titlePadding:
                                                const EdgeInsets.all(0),
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            content: SingleChildScrollView(
                                              child: MaterialPicker(
                                                pickerColor: blueColor,
                                                onColorChanged: (item) {
                                                  controller
                                                          .pColorsList[index] =
                                                      item.value;
                                                  Navigator.pop(
                                                      context, 'Cancel');
                                                },
                                                enableLabel: true,
                                                portraitOnly: false,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  )
                                : controller.pColorsList[index] != null
                                    ? VxBox()
                                        .size(40, 40)
                                        .roundedSM
                                        .color(
                                            Color(controller.pColorsList[index])
                                                .withOpacity(1.0))
                                        .margin(const EdgeInsets.symmetric(
                                            horizontal: 4.0))
                                        .make()
                                        .onTap(
                                        () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                titlePadding:
                                                    const EdgeInsets.all(0),
                                                contentPadding:
                                                    const EdgeInsets.all(0),
                                                content: SingleChildScrollView(
                                                  child: MaterialPicker(
                                                    pickerColor: blueColor,
                                                    onColorChanged: (item) {
                                                      controller.pColorsList[
                                                          index] = item.value;
                                                      Navigator.pop(
                                                          context, 'Cancel');
                                                    },
                                                    enableLabel: true,
                                                    portraitOnly: false,
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      )
                                    : productColor(label: const Icon(Icons.add))
                                        .onTap(() {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              titlePadding:
                                                  const EdgeInsets.all(0),
                                              contentPadding:
                                                  const EdgeInsets.all(0),
                                              content: SingleChildScrollView(
                                                child: MaterialPicker(
                                                  pickerColor: blueColor,
                                                  onColorChanged: (item) {
                                                    controller.pColorsList[
                                                        index] = item.value;
                                                    Navigator.pop(
                                                        context, 'Cancel');
                                                    FocusManager
                                                        .instance.primaryFocus
                                                        ?.unfocus();
                                                  },
                                                  enableLabel: true,
                                                  portraitOnly: false,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }),
                          ),
                        ),
                        5.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(
                            3 -
                                int.parse(controller
                                    .getColors(data['p_colors'])
                                    .length
                                    .toString()),
                            (index) => controller.pColorsList[index +
                                        3 -
                                        int.parse(controller
                                            .getColors(data['p_colors'])
                                            .toString()) -
                                        1] !=
                                    null
                                ? VxBox()
                                    .size(40, 40)
                                    .roundedSM
                                    .color(Color(controller.pColorsList[index +
                                            3 -
                                            int.parse(controller
                                                .getColors(data['p_colors'])
                                                .toString()) -
                                            1])
                                        .withOpacity(1.0))
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4.0))
                                    .make()
                                    .onTap(
                                    () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            titlePadding:
                                                const EdgeInsets.all(0),
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            content: SingleChildScrollView(
                                              child: MaterialPicker(
                                                pickerColor: blueColor,
                                                onColorChanged: (item) {
                                                  controller.pColorsList[index +
                                                      3 -
                                                      int.parse(controller
                                                          .getColors(
                                                              data['p_colors'])
                                                          .toString()) -
                                                      1] = item.value;
                                                  Navigator.pop(
                                                      context, 'Cancel');
                                                },
                                                enableLabel: true,
                                                portraitOnly: false,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  )
                                : productColor(label: const Icon(Icons.add))
                                    .onTap(() {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          titlePadding: const EdgeInsets.all(0),
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          content: SingleChildScrollView(
                                            child: MaterialPicker(
                                              pickerColor: blueColor,
                                              onColorChanged: (item) {
                                                controller.pColorsList[index +
                                                    3 -
                                                    int.parse(controller
                                                        .getColors(
                                                            data['p_colors'])
                                                        .toString()) -
                                                    1] = item.value;
                                                Navigator.pop(
                                                    context, 'Cancel');
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                              },
                                              enableLabel: true,
                                              portraitOnly: false,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }),
                          ),
                        ),
                        5.heightBox,
                      ],
                    )
                  ],
                ),
                10.heightBox,
                SizedBox(
                  width: context.screenWidth - 60,
                  child: customButton(
                      onPress: () async {
                        if (controller.pnameController.text.isEmptyOrNull) {
                          VxToast.show(context,
                              msg: 'Product name is required');
                        } else if (controller
                            .ppriceController.text.isEmptyOrNull) {
                          VxToast.show(context,
                              msg: 'Product price is required');
                        } else if (controller
                            .pquantityController.text.isEmptyOrNull) {
                          VxToast.show(context,
                              msg: 'Product quantity is required');
                        } else {
                          // controller.uploadImage(context: context);
                          // if (!context.mounted) return;
                          // checkUpload();
                          controller.updateProduct(
                              id: data.id, context: context);
                          Get.back();
                        }
                      },
                      color: red,
                      textColor: whiteColor,
                      title: 'Update product'),
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
