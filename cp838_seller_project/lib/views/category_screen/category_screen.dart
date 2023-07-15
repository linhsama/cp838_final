import 'package:cp838_seller_project/consts/consts.dart';
import 'package:cp838_seller_project/controllers/product_controller.dart';
import 'package:cp838_seller_project/services/firestore_services.dart';
import 'package:cp838_seller_project/views/category_screen/add_category.dart';
import 'package:cp838_seller_project/views/category_screen/category_details.dart';
import 'package:cp838_seller_project/views/products_screen/edit_product.dart';
import 'package:cp838_seller_project/views/products_screen/item_details.dart';
import 'package:cp838_seller_project/widget_common/bg_widget.dart';
import 'package:cp838_seller_project/widget_common/exit_dialog.dart';
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
      child: Material(
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
                title:
                    categories.text.fontFamily(bold).color(purpleColor).make(),
              ),
              floatingActionButtonAnimator:
                  FloatingActionButtonAnimator.scaling,
              floatingActionButton: FloatingActionButton(
                  backgroundColor: purpleColor,
                  onPressed: () async {
                    await controller.getCategories();
                    controller.populateCategoryList();
                    controller.clearList();

                    Get.to(() => const AddCategory());
                  },
                  child: const Icon(Icons.add)),
              body: Column(
                children: [
                  20.heightBox,
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    width: double.infinity,
                    decoration: const BoxDecoration(color: blueColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "All categories"
                            .text
                            .white
                            .fontFamily(bold)
                            .size(18.0)
                            .make(),
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
                                    valueColor:
                                        AlwaysStoppedAnimation(redColor),
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
                                          height: 50,
                                          width: 50,
                                          fit: BoxFit.cover,
                                        ),
                                        10.widthBox,
                                        "${data[index]['c_name']}"
                                            .text
                                            .fontFamily(semibold)
                                            .maxLines(2)
                                            .overflow(TextOverflow.ellipsis)
                                            .color(darkFontGrey)
                                            .make(),
                                      ],
                                    )
                                        .box
                                        .white
                                        .rounded
                                        .width(170)
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
                  20.heightBox,
                  const Divider(),
                  "All product"
                      .text
                      .fontFamily(semibold)
                      .maxLines(1)
                      .overflow(TextOverflow.ellipsis)
                      .color(darkFontGrey)
                      .make(),
                  20.heightBox,
                  StreamBuilder(
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
                          child: "prodcut is empty!"
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
                            return Card(
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(children: [
                                      Image.network(
                                        data[index]['p_imgs'][0],
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.cover,
                                      )
                                    ]),
                                    5.widthBox,
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              "${data[index]['p_name']}"
                                                  .text
                                                  .fontFamily(bold)
                                                  .maxLines(2)
                                                  .overflow(
                                                      TextOverflow.ellipsis)
                                                  .make()
                                                  .box
                                                  .width(100)
                                                  .make(),
                                              5.heightBox,
                                              data[index]['is_new'] == true
                                                  ? "New"
                                                      .text
                                                      .fontFamily(bold)
                                                      .color(red)
                                                      .maxLines(1)
                                                      .overflow(
                                                          TextOverflow.ellipsis)
                                                      .make()
                                                  : ""
                                                      .text
                                                      .fontFamily(bold)
                                                      .maxLines(1)
                                                      .overflow(
                                                          TextOverflow.ellipsis)
                                                      .make()
                                            ],
                                          ),
                                        ]).box.width(120).make(),
                                    Row(children: [
                                      TextButton(
                                          onPressed: () {
                                            Get.to(() => ItemDetails(
                                                  title: data[index]['p_name'],
                                                  data: data[index],
                                                ));
                                          },
                                          child:
                                              const Icon(Icons.remove_red_eye)),
                                      TextButton(
                                          onPressed: () {
                                            Get.to(() =>
                                                EditProduct(data: data[index]));
                                          },
                                          child: const Icon(Icons.edit)),
                                      TextButton(
                                          onPressed: () {
                                            showDialog<String>(
                                              barrierDismissible:
                                                  false, // user must tap button!
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                title: const Text('Confirm'),
                                                content: const Text(
                                                    'Do you want to delete item?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context, 'Cancel'),
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    child: const Text(
                                                      'OK',
                                                      style: TextStyle(
                                                          color: redColor),
                                                    ),
                                                    onPressed: () async {
                                                      controller.deleteProduct(
                                                          docId: data[index].id,
                                                          context: context);
                                                      Navigator.pop(
                                                          context, 'Cancel');
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            color: redColor,
                                          )),
                                    ])
                                        .box
                                        .margin(const EdgeInsets.all(4.0))
                                        .make()
                                  ]),
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                ],
              ))),
    );
  }
}
