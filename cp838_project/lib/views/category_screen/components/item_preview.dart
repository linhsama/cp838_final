// ignore_for_file: unnecessary_null_comparison

import 'package:cp838_project/consts/consts.dart';
import 'package:cp838_project/controllers/product_controller.dart';
import 'package:cp838_project/views/category_screen/components/product_image.dart';
import 'package:cp838_project/widget_common/custom_button.dart';
import 'package:cp838_project/widget_common/custom_textfield.dart';

class ItemPreview extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemPreview({Key? key, required this.title, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    checkUpload() {
      Future.delayed(
        const Duration(seconds: 1),
        () {
          if (controller.pImagesPreviewLink.length ==
              controller.getImgs(controller.pPreviewImagesList).length) {
            controller.updatePreview(data, context);

            Get.back();
            Get.back();
          } else {
            checkUpload();
          }
        },
      );
    }

    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
          title:
              title.toString().text.color(darkFontGrey).fontFamily(bold).make(),
        ),
        body: Obx(
          () => Container(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // rating
                          10.heightBox,
                          "Your Rating"
                              .text
                              .color(darkFontGrey)
                              .fontFamily(semibold)
                              .size(16.0)
                              .make(),
                          20.heightBox,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              VxRating(
                                isSelectable: true,
                                onRatingUpdate: (value) {
                                  controller.ratingCount(
                                      (double.parse(value).ceilToDouble()));
                                },
                                normalColor: textfieldGrey,
                                selectionColor: golden,
                                size: 50,
                                stepInt: true,
                                maxRating: 5,
                                count: 5,
                                value: 5.0,
                              ),
                              10.widthBox,
                            ],
                          ),

                          10.heightBox,
                          customTextField(
                              title: 'Preview',
                              hint: 'Your preview',
                              controller: controller.ppreviewController,
                              obscureText: false,
                              keyboardTypes: TextInputType.text,
                              maxLenth: 200,
                              isDesc: true),
                          10.heightBox,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Add Images"
                                  .text
                                  .color(darkFontGrey)
                                  .fontFamily(semibold)
                                  .size(16.0)
                                  .make(),
                              5.heightBox,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: List.generate(
                                  3,
                                  (index) => controller
                                              .pPreviewImagesList[index] !=
                                          null
                                      ? Image.file(
                                          controller.pPreviewImagesList[index],
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ).onTap(() {
                                          controller.pickImagePreview(
                                              index, context);
                                        })
                                      : productImage(
                                              label: const Icon(
                                                  Icons.add_photo_alternate))
                                          .onTap(() {
                                          controller.pickImagePreview(
                                              index, context);
                                        }),
                                ),
                              ),
                              5.heightBox,
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                10.heightBox,
                // controller.isLoading.isTrue
                // ? const CircularProgressIndicator(
                //     valueColor: AlwaysStoppedAnimation(redColor),
                //   )
                // :
                SizedBox(
                  width: context.screenWidth - 60,
                  child: customButton(
                      onPress: () {
                        controller.uploadImagePreview(context);
                        checkUpload();
                      },
                      color: redColor,
                      textColor: whiteColor,
                      title: "Send preview"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
