import 'package:cp838_project/consts/consts.dart';
import 'package:cp838_project/controllers/product_controller.dart';
import 'package:cp838_project/services/firestore_services.dart';
import 'package:cp838_project/views/category_screen/category_details.dart';
import 'package:cp838_project/views/category_screen/item_details.dart';
import 'package:cp838_project/widget_common/bg_widget.dart';
import 'package:cp838_project/widget_common/exit_dialog.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    //
    var controller = Get.put(ProductController());

    return WillPopScope(
      onWillPop: () async {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => exitDialog(context: context),
        );
        return false;
      },
      child: bgWidget(
        child: Scaffold(
            appBar: AppBar(
              // leading: IconButton(
              //   onPressed: () {
              //     showDialog(
              //       barrierDismissible: false,
              //       context: context,
              //       builder: (context) => exitDialog(context: context),
              //     );
              //   },
              //   icon: const Icon(Icons.category),
              // color: whiteColor,
              // ),

              automaticallyImplyLeading: false,
              title: categories.text.fontFamily(bold).white.make(),
            ),
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      10.heightBox,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: StreamBuilder(
                          stream: FirestoreServices.getAllCategories(),
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
                                child: "No Categorirs yet!"
                                    .text
                                    .color(darkFontGrey)
                                    .make(),
                              );
                            } else {
                              //
                              var data = snapshot.data!.docs;
                              return Row(
                                children: List.generate(
                                  data.length,
                                  (index) => Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        data[index]['c_imgs'][0],
                                        height: 70,
                                        width: 70,
                                        fit: BoxFit.cover,
                                      ),
                                      10.widthBox,
                                      "${data[index]['c_name']}"
                                          .text
                                          .fontFamily(semibold)
                                          .maxLines(1)
                                          .overflow(TextOverflow.ellipsis)
                                          .color(darkFontGrey)
                                          .make()
                                          .box
                                          .width(80)
                                          .make(),
                                    ],
                                  )
                                      .box
                                      .white
                                      .rounded
                                      .width(200)
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 8.0))
                                      .padding(const EdgeInsets.all(8.0))
                                      .make()
                                      .onTap(() {
                                    Get.to(() => CategoryDetails(
                                        title: data[index]['c_name']));
                                  }),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                //all products
                20.heightBox,
                10.heightBox,
                Align(
                  alignment: Alignment.centerLeft,
                  child: allProducts.text
                      .color(darkFontGrey)
                      .size(18.0)
                      .fontFamily(semibold)
                      .make()
                      .box
                      .padding(const EdgeInsets.all(10))
                      .make(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: StreamBuilder(
                        stream: FirestoreServices.getAllProducts(),
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
                              child: "No products yet!"
                                  .text
                                  .color(darkFontGrey)
                                  .make(),
                            );
                          } else {
                            //
                            var data = snapshot.data!.docs;
                            return GridView.builder(
                                padding: const EdgeInsets.all(10),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: data.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8,
                                        mainAxisExtent: 300),
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        data[index]['p_imgs'][0],
                                        height: 170,
                                        width: 170,
                                        fit: BoxFit.cover,
                                      ),
                                      const Spacer(),
                                      "${data[index]['p_name']}"
                                          .text
                                          .fontFamily(semibold)
                                          .maxLines(2)
                                          .overflow(TextOverflow.ellipsis)
                                          .color(darkFontGrey)
                                          .make()
                                          .box
                                          .width(160)
                                          .make(),
                                      10.heightBox,
                                      "${data[index]['p_price']}"
                                          .toString()
                                          .toVND()
                                          .text
                                          .fontFamily(bold)
                                          .color(blueColor)
                                          .size(16)
                                          .make()
                                    ],
                                  )
                                      .box
                                      .white
                                      .roundedSM
                                      .outerShadow
                                      .padding(const EdgeInsets.all(12.0))
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 4.0))
                                      .make()
                                      .onTap(() {
                                    Get.to(() => ItemDetails(
                                        title: data[index]['p_name'],
                                        data: data[index]));
                                  });
                                });
                          }
                        }),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
