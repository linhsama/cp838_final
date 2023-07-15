import 'package:cp838_project/chat_screen/chat_screen.dart';
import 'package:cp838_project/consts/consts.dart';
import 'package:cp838_project/controllers/chat_controller.dart';
import 'package:cp838_project/controllers/product_controller.dart';
import 'package:cp838_project/controllers/profile_controller.dart';
import 'package:cp838_project/services/firestore_services.dart';
import 'package:cp838_project/views/category_screen/components/item_preview.dart';
import 'package:cp838_project/views/category_screen/components/show_preview.dart';
import 'package:cp838_project/widget_common/custom_button.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class ItemDetails extends StatefulWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({Key? key, required this.title, required this.data})
      : super(key: key);

  @override
  createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    controller.colorIndex = 0.obs;
    controller.quantity = 1.obs;
    controller.getThisWishlists(widget.data.id, widget.title);

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
          title: widget.title
              .toString()
              .text
              .color(darkFontGrey)
              .maxLines(2)
              .overflow(TextOverflow.ellipsis)
              .fontFamily(bold)
              .make(),
          actions: [
            Obx(
              () => IconButton(
                onPressed: () {
                  if (controller.isFav.value) {
                    controller.removeWishList(widget.data.id, context);
                    var controller2 = Get.put(ProfileController());
                    controller2.getOrders();
                    controller2.getWishlists();
                    controller2.getMessages();
                  } else {
                    var controller2 = Get.put(ProfileController());
                    controller2.getOrders();
                    controller2.getWishlists();
                    controller2.getMessages();
                    controller.addWishList(widget.data.id, context);
                  }
                },
                icon: controller.isFav.value == true
                    ? const Icon(
                        Icons.favorite,
                        color: redColor,
                      )
                    : const Icon(
                        Icons.favorite_outline,
                        color: darkFontGrey,
                      ),
              ),
            ),
          ],
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
                          itemCount: widget.data['p_imgs'].length,
                          itemBuilder: (context, index) {
                            return Image.network(
                              widget.data['p_imgs'][index],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          }),

                      // title and details section
                      10.heightBox,
                      widget.title
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
                            value: double.parse(
                                widget.data['p_rating'].toString()),
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
                      widget.data['p_price']
                          .toString()
                          .toVND()
                          .text
                          .fontFamily(bold)
                          .color(blueColor)
                          .size(18.0)
                          .make(),
                      10.heightBox,
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    "Shop"
                                        .text
                                        .white
                                        .fontFamily(semibold)
                                        .make(),
                                    5.heightBox,
                                    "${widget.data['p_shopname']}"
                                        .text
                                        .color(darkFontGrey)
                                        .fontFamily(semibold)
                                        .make()
                                  ],
                                ),
                              ),
                              const CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.message_rounded,
                                  color: darkFontGrey,
                                ),
                              )
                            ],
                          )
                              .box
                              .height(60)
                              .padding(
                                  const EdgeInsets.symmetric(horizontal: 16.0))
                              .color(textfieldGrey)
                              .make()
                              .onTap(() {
                            Get.to(
                                () => ChatScreen(
                                    title: "${widget.data['p_shopname']}"),
                                arguments: [
                                  widget.data['shop_id'],
                                  widget.data['p_shopname'],
                                ]);
                          }),
                        ],
                      ),
                      20.heightBox,
                      Obx(
                        () => Container(
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
                                      widget.data['p_colors'].length,
                                      (index) => Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          VxBox()
                                              .size(40, 40)
                                              .roundedFull
                                              .color(Color(int.parse(widget
                                                      .data['p_colors'][index]
                                                      .toString()))
                                                  .withOpacity(1.0))
                                              .margin(
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0))
                                              .make()
                                              .onTap(() {
                                            controller.colorIndex(index);
                                          }),
                                          Visibility(
                                            visible: index ==
                                                controller.colorIndex.value,
                                            child: const Icon(Icons.done,
                                                color: whiteColor),
                                          )
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
                                      TextButton(
                                          onPressed: () {
                                            controller.quantity.value > 1
                                                ? controller.quantity(
                                                    controller.quantity.value -
                                                        1)
                                                : controller.quantity(1);
                                          },
                                          child: const Icon(Icons.remove)),
                                      controller.quantity.value.text
                                          .size(16.0)
                                          .color(Colors.green)
                                          .fontFamily(bold)
                                          .make()
                                          .box
                                          .margin(const EdgeInsets.symmetric(
                                              horizontal: 3.0))
                                          .make(),
                                      TextButton(
                                          onPressed: () {
                                            controller.quantity.value <
                                                    int.parse(widget
                                                        .data['p_quantity'])
                                                ? controller.quantity(
                                                    controller.quantity.value +
                                                        1)
                                                : controller.quantity(
                                                    widget.data['p_quantity']);
                                          },
                                          child: const Icon(Icons.add)),
                                      10.widthBox,
                                      "${widget.data['p_quantity']} vailable "
                                          .text
                                          .color(textfieldGrey)
                                          .make(),
                                    ],
                                  ),
                                ],
                              ).box.padding(const EdgeInsets.all(4.0)).make(),

                              10.heightBox,
                              //total price
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: "Total: "
                                        .text
                                        .color(textfieldGrey)
                                        .make(),
                                  ),
                                  "${controller.total((controller.quantity.value * double.parse(widget.data['p_price']))).floor()}"
                                      .toString()
                                      .toVND()
                                      .text
                                      .fontFamily(bold)
                                      .color(redColor)
                                      .size(22.0)
                                      .make(),
                                ],
                              )
                                  .box
                                  .color(lightGolden)
                                  .padding(const EdgeInsets.all(10.0))
                                  .make(),
                            ],
                          ).box.white.margin(const EdgeInsets.all(10.0)).make(),
                        ).box.gray100.make(),
                      ),

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
                            "${widget.data['p_desc']}"
                                .text
                                .color(darkFontGrey)
                                .make(),
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
                                                  title: widget.data['p_name'],
                                                  data: widget.data));
                                              break;
                                            case 1:
                                              Get.to(() => ShowPreview(
                                                  title: widget.data['p_name'],
                                                  req: widget.data));
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

                      // Container(
                      //   color: lightGrey,
                      //   child: Column(
                      //     children: [
                      //       //Products you may also like
                      //       20.heightBox,
                      //       productsYouMayLike.text
                      //           .fontFamily(bold)
                      //           .size(16.0)
                      //           .color(darkFontGrey)
                      //           .make(),
                      //       10.heightBox,
                      //       SingleChildScrollView(
                      //         scrollDirection: Axis.horizontal,
                      //         child: StreamBuilder(
                      //             stream: FirestoreServices.getNewProducts(),
                      //             builder: (BuildContext context,
                      //                 AsyncSnapshot<QuerySnapshot> snapshot) {
                      //               if (!snapshot.haswidget.Data) {
                      //                 return const Center(
                      //                   child: CircularProgressIndicator(
                      //                     valueColor:
                      //                         AlwaysStoppedAnimation(redColor),
                      //                   ),
                      //                 );
                      //               } else if (snapshot.widget.data!.docs.isEmpty) {
                      //                 return Center(
                      //                   child: "No products yet!"
                      //                       .text
                      //                       .color(darkFontGrey)
                      //                       .make(),
                      //                 );
                      //               } else {
                      //                 //
                      //                 var widget.data = snapshot.widget.data!.docs;
                      //                 return Row(
                      //                   children: List.generate(
                      //                     6,
                      //                     (index) => Column(
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.start,
                      //                       children: [
                      //                         Image.asset(
                      //                           widget.data[index]['p_img'][0],
                      //                           width: 150,
                      //                           fit: BoxFit.cover,
                      //                         ),
                      //                         10.heightBox,
                      //                         "${widget.data[index]['p_name']}"
                      //                             .text
                      //                             .fontFamily(semibold)
                      //                             .color(darkFontGrey)
                      //                             .make(),
                      //                         10.heightBox,
                      //                         "${widget.data[index]['p_price']}"
                      //                             .toString()
                      //                             .toVND()
                      //                             .text
                      //                             .fontFamily(bold)
                      //                             .color(blueColor)
                      //                             .size(16)
                      //                             .make()
                      //                       ],
                      //                     )
                      //                         .box
                      //                         .white
                      //                         .rounded
                      //                         .margin(
                      //                             const EdgeInsets.symmetric(
                      //                                 horizontal: 4.0))
                      //                         .padding(
                      //                             const EdgeInsets.all(8.0))
                      //                         .make(),
                      //                   ),
                      //                 );
                      //               }
                      //             }),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: customButton(
                  onPress: () {
                    controller.addToCart(
                        title: widget.data['p_name'],
                        img: widget.data['p_imgs'][0],
                        shopname: widget.data['p_shopname'],
                        color: widget.data['p_colors']
                                [controller.colorIndex.value]
                            .toString(),
                        qty: controller.quantity.value.toString(),
                        tprice: controller.total.value.toInt().toString(),
                        shopId: widget.data['shop_id'],
                        context: context);
                    VxToast.show(context, msg: 'Added to cart');
                  },
                  color: blueColor,
                  textColor: whiteColor,
                  title: "Add to cart"),
            )
          ]),
        ),
      ),
    );
  }
}
