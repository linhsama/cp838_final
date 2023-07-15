import 'package:cp838_seller_project/consts/consts.dart';
import 'package:cp838_seller_project/controllers/home_controller.dart';
import 'package:cp838_seller_project/controllers/product_controller.dart';
import 'package:cp838_seller_project/services/firestore_services.dart';
import 'package:cp838_seller_project/views/products_screen/item_details.dart';
import 'package:cp838_seller_project/widget_common/home_button.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //
  var controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.getCountOrder();
    controller.getCountProduct();
    controller.getTotalSale();
    controller.orderCount;
    controller.productCount;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        title:
            dashboard.text.fontFamily(bold).color(purpleColor).size(22).make(),
      ),
      body: Container(
        padding: const EdgeInsets.all(12.0),
        color: lightGrey,
        width: context.screenWidth,
        height: context.screenHeight,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          homeButton(
                            width: context.screenWidth / 2.5,
                            height: 80.0,
                            icon: icProduct,
                            title: product,
                            count: controller.productCount,
                          ),
                          homeButton(
                            width: context.screenWidth / 2.5,
                            height: 80.0,
                            icon: icOrder,
                            title: order,
                            count: controller.orderCount,
                          ),
                        ],
                      ),
                      20.heightBox,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     homeButton(
                      //       width: context.screenWidth / 2.5,
                      //       height: 80.0,
                      //       icon: icTotalSale,
                      //       title: totalSale,
                      //       count: controller.totalSale,
                      //     ),
                      //   ],
                      // ),
                      //feature products
                      20.heightBox,
                      const Divider(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: 'New Product'
                            .text
                            .fontFamily(bold)
                            .color(purpleColor)
                            .size(22)
                            .make(),
                      ),
                      20.heightBox,

                      StreamBuilder(
                        stream: FirestoreServices.getNewProducts(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(redColor),
                              ),
                            );
                          } else if (snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: "Product is empty!"
                                  .text
                                  .color(darkFontGrey)
                                  .make(),
                            );
                          } else {
                            //
                            var data = snapshot.data!.docs;
                            return ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: List.generate(data.length, (index) {
                                return ListTile(
                                  onTap: () {
                                    Get.put(ProductController())
                                        .getAllWishlists(data[index]['p_name']);
                                    Get.to(() => ItemDetails(
                                        data: data[index],
                                        title: data[index]['p_name']));
                                  },
                                  leading: Image.network(
                                    data[index]['p_imgs'][0],
                                    fit: BoxFit.cover,
                                    width: 70,
                                  ),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    textDirection: TextDirection.ltr,
                                    children: [
                                      "${data[index]['p_name']}"
                                          .text
                                          .fontFamily(bold)
                                          .maxLines(2)
                                          .overflow(TextOverflow.ellipsis)
                                          .size(16)
                                          .make()
                                          .box
                                          .width(context.screenWidth - 190)
                                          .make(),
                                    ],
                                  ),
                                  subtitle: "${data[index]['p_price']}"
                                      .toString()
                                      .toVND()
                                      .text
                                      .fontFamily(semibold)
                                      .size(14)
                                      .make(),
                                  trailing: const Icon(Icons.remove_red_eye),
                                )
                                    .box
                                    .white
                                    .roundedSM
                                    .margin(const EdgeInsets.symmetric(
                                        vertical: 4.0))
                                    .padding(const EdgeInsets.symmetric(
                                        vertical: 6.0))
                                    .make();
                              }).toList(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
