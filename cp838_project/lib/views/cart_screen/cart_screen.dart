import 'package:cp838_project/consts/consts.dart';
import 'package:cp838_project/controllers/cart_controller.dart';
import 'package:cp838_project/services/firestore_services.dart';
import 'package:cp838_project/views/cart_screen/shipping_screen.dart';
import 'package:cp838_project/widget_common/custom_button.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    //
    var controller = Get.put(CartController());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Cart".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "Cart is empty!".text.color(darkFontGrey).make(),
            );
          } else {
            //
            var data = snapshot.data!.docs;
            controller.calcTotal(data);

            controller.productSnapshot = data;

            //
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            leading: Image.network(
                              data[index]['img'],
                              fit: BoxFit.cover,
                              width: 80,
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              textDirection: TextDirection.ltr,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(4.0),
                                  margin: const EdgeInsets.all(4.0),
                                  width: 10,
                                  height: 10,
                                  color: Color(int.parse(data[index]['color'])),
                                ),
                                "${data[index]['title']}"
                                    .text
                                    .fontFamily(bold)
                                    .maxLines(2)
                                    .overflow(TextOverflow.ellipsis)
                                    .size(16)
                                    .make()
                                    .box
                                    .width(context.screenWidth - 250)
                                    .make(),
                              ],
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              textDirection: TextDirection.ltr,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(4.0),
                                  margin: const EdgeInsets.all(4.0),
                                  child: "(x${data[index]['qty']})"
                                      .text
                                      .fontFamily(semibold)
                                      .size(14)
                                      .make(),
                                ),
                                "${data[index]['tprice']}"
                                    .toString()
                                    .toVND()
                                    .text
                                    .fontFamily(semibold)
                                    .size(14)
                                    .make(),
                              ],
                            ),
                            trailing: TextButton(
                              onPressed: () {
                                showDialog<String>(
                                  barrierDismissible:
                                      false, // user must tap button!
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Confirm'),
                                    content: const Text(
                                        'Do you want detele this item?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(color: redColor),
                                        ),
                                        onPressed: () {
                                          FirestoreServices.deleteItem(
                                              data[index].id);
                                          Navigator.pop(context, 'Delete');

                                          VxToast.show(context,
                                              msg: 'Delete successfully');
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: const Icon(
                                Icons.delete,
                                color: redColor,
                                size: 26,
                              ),
                            ));
                      },
                    ),
                  ),
                  20.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total price"
                          .text
                          .fontFamily(bold)
                          .color(darkFontGrey)
                          .make(),
                      Obx(
                        () => "${controller.totalP.value}"
                            .toString()
                            .toVND()
                            .text
                            .fontFamily(bold)
                            .color(redColor)
                            .size(18.0)
                            .make(),
                      ),
                    ],
                  )
                      .box
                      .padding(const EdgeInsets.all(12.0))
                      .color(lightBlue)
                      .width(context.screenWidth - 60)
                      .roundedSM
                      .make(),
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: 60,
        child: customButton(
            onPress: () {
              Get.to(() => const ShippingScreen());
            },
            color: blueColor,
            textColor: whiteColor,
            title: 'Checkout'),
      ),
    );
  }
}
