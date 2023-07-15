import 'package:cp838_seller_project/consts/consts.dart';
import 'package:cp838_seller_project/controllers/product_controller.dart';
import 'package:cp838_seller_project/views/products_screen/components/item_preview.dart';
import 'package:cp838_seller_project/views/products_screen/components/show_preview.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({Key? key, required this.title, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    controller.colorIndex = 0.obs;
    controller.quantity = 1.obs;
    // controller.getThisWishlists(data.id, title);

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
          actions: const [],
        ),
        body: Container(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VxSwiper.builder(
                          autoPlay: true,
                          height: 350,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1.0,
                          itemCount: int.parse(controller
                              .getImgs(data['p_imgs'])
                              .length
                              .toString()),
                          itemBuilder: (context, index) {
                            return Image.network(
                              data['p_imgs'][index],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          }),

                      // title and details section
                      10.heightBox,
                      title
                          .toString()
                          .text
                          .size(16.0)
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),

                      // rating
                      10.heightBox,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          VxRating(
                            isSelectable: false,
                            value: double.parse(data['p_rating'].toString()),
                            onRatingUpdate: (value) {},
                            normalColor: textfieldGrey,
                            selectionColor: golden,
                            size: 25,
                            stepInt: true,
                            maxRating: 5,
                            count: 5,
                          ),
                          10.widthBox,
                        ],
                      ),

                      10.heightBox,
                      data['p_price']
                          .toString()
                          .toVND()
                          .text
                          .fontFamily(bold)
                          .color(blueColor)
                          .size(18.0)
                          .make(),
                      10.heightBox,

                      Container(
                        child: Column(
                          children: [
                            // color section
                            Row(
                              children: [
                                SizedBox(
                                  width: 70,
                                  child: "Color: "
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ),
                                Row(
                                  children: List.generate(
                                    int.parse(controller
                                        .getColors(data['p_colors'])
                                        .length
                                        .toString()),
                                    (index) => Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        VxBox()
                                            .size(40, 40)
                                            .roundedFull
                                            .color(
                                                Color(data['p_colors'][index])
                                                    .withOpacity(1.0))
                                            .margin(const EdgeInsets.symmetric(
                                                horizontal: 4.0))
                                            .make()
                                            .onTap(() {
                                          controller.colorIndex(index);
                                        }),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ).box.padding(const EdgeInsets.all(5.0)).make(),

                            10.heightBox,
                            //quantity section
                            Row(
                              children: [
                                SizedBox(
                                  width: 60,
                                  child: "Quantity: "
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ),
                                Row(
                                  children: [
                                    30.widthBox,
                                    "${data['p_quantity']} vailable "
                                        .text
                                        .color(textfieldGrey)
                                        .make(),
                                  ],
                                ),
                              ],
                            ).box.padding(const EdgeInsets.all(4.0)).make(),

                            10.heightBox,
                          ],
                        ).box.white.margin(const EdgeInsets.all(10.0)).make(),
                      ).box.gray100.make(),

                      //desciption section
                      20.heightBox,
                      Container(
                        color: whiteColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Description "
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            10.heightBox,
                            "${data['p_desc']}".text.color(darkFontGrey).make(),
                          ],
                        ),
                      ).box.rounded.padding(const EdgeInsets.all(8.0)).make(),
                      // Button section
                      20.heightBox,
                      Container(
                        color: lightGrey,
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: itemDetailButtonList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    5.heightBox,
                                    Container(
                                      child: ListTile(
                                        onTap: () {
                                          switch (index) {
                                            case 0:
                                              Get.to(() => ItemPreview(
                                                  title: data['p_name'],
                                                  data: data));
                                              break;
                                            case 1:
                                              Get.to(() => ShowPreview(
                                                  title: data['p_name'],
                                                  req: data));
                                              break;
                                            case 2:
                                            case 3:
                                            case 4:
                                              VxToast.show(context,
                                                  msg:
                                                      'Chức năng sẽ sớm ra mắt');
                                              break;
                                          }
                                        },
                                        title: itemDetailButtonList[index]
                                            .text
                                            .fontFamily(semibold)
                                            .color(darkFontGrey)
                                            .make(),
                                        trailing:
                                            const Icon(Icons.arrow_forward),
                                      ).box.white.make(),
                                    )
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
