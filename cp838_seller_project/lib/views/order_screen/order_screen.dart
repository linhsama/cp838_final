import 'package:cp838_seller_project/consts/consts.dart';
import 'package:cp838_seller_project/views/order_screen/order_details.dart';
import 'package:cp838_seller_project/services/firestore_services.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:intl/intl.dart' as intl;

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "My Orders".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "No order yet!".text.color(darkFontGrey).makeCentered(),
            );
          } else {
            //
            var data = snapshot.data!.docs;
            return ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return const Divider(color: lightGrey);
              },
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: "${index + 1}"
                      .text
                      .fontFamily(bold)
                      .color(darkFontGrey)
                      .make(),
                  title: "ID: ${data[index]['order_code']}"
                      .toString()
                      .text
                      .fontFamily(semibold)
                      .make(),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          "Total Amount: ".text.fontFamily(semibold).make(),
                          "${data[index]['total_amount']}"
                              .toVND()
                              .text
                              .color(redColor)
                              .make(),
                        ],
                      ),
                      Row(
                        children: [
                          "Date Order: ".text.fontFamily(semibold).make(),
                          intl.DateFormat()
                              .add_yMd()
                              .format((data[index]['order_date'].toDate()))
                              .text
                              .make(),
                        ],
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Get.to(() => OrderDetails(data: data[index]));
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: darkFontGrey,
                    ),
                  ),
                )
                    .box
                    .white
                    .roundedSM
                    .padding(const EdgeInsets.symmetric(horizontal: 8.0))
                    .outerShadowSm
                    .make()
                    .box
                    .make();
              },
            );
          }
        },
      ),
    );
  }
}
