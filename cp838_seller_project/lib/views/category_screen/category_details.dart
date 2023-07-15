import 'package:cp838_seller_project/consts/consts.dart';
import 'package:cp838_seller_project/controllers/home_controller.dart';
import 'package:cp838_seller_project/controllers/product_controller.dart';
import 'package:cp838_seller_project/services/firestore_services.dart';
import 'package:cp838_seller_project/views/products_screen/add_product.dart';
import 'package:cp838_seller_project/views/products_screen/edit_product.dart';
import 'package:cp838_seller_project/views/products_screen/item_details.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    var controller = Get.put(ProductController());
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: FloatingActionButton(
            backgroundColor: purpleColor,
            onPressed: () async {
              await controller.getCategories();
              controller.populateCategoryList();
              controller.clearList();

              Get.to(() => AddProduct(data: title));
            },
            child: const Icon(Icons.add)),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: purpleColor,
              )),
          title:
              title.toString().text.fontFamily(bold).color(purpleColor).make(),
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getProducts(title),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "this is empty!".text.color(darkFontGrey).make(),
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    "${data[index]['p_name']}"
                                        .text
                                        .fontFamily(bold)
                                        .maxLines(2)
                                        .overflow(TextOverflow.ellipsis)
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
                                            .overflow(TextOverflow.ellipsis)
                                            .make()
                                        : ""
                                            .text
                                            .fontFamily(bold)
                                            .maxLines(1)
                                            .overflow(TextOverflow.ellipsis)
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
                                child: const Icon(Icons.remove_red_eye)),
                            TextButton(
                                onPressed: () {
                                  Get.to(() => EditProduct(data: data[index]));
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
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          child: const Text(
                                            'OK',
                                            style: TextStyle(color: redColor),
                                          ),
                                          onPressed: () async {
                                            controller.deleteProduct(
                                                docId: data[index].id,
                                                context: context);
                                            var controller2 =
                                                Get.put(HomeController());

                                            controller2.getCountOrder();
                                            controller2.getCountProduct();
                                            controller2.getTotalSale();
                                            controller2.orderCount;
                                            controller2.productCount;
                                            Navigator.pop(context, 'Cancel');
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
                          ]).box.margin(const EdgeInsets.all(1.0)).make()
                        ]),
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
