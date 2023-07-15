import 'package:cp838_project/consts/consts.dart';
import 'package:cp838_project/order_screen/components/order_place_details.dart';
import 'package:cp838_project/order_screen/components/order_status.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatelessWidget {
  final dynamic data;
  const OrderDetails({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: "Order Details"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                orderStatus(
                  icon: Icons.done,
                  color: redColor,
                  title: 'Order placed',
                  showDone: data['order_placed'],
                ),
                orderStatus(
                  icon: Icons.thumb_up,
                  color: Colors.blue,
                  title: 'Confirmed',
                  showDone: data['order_confirmed'],
                ),
                // orderStatus(
                //   icon: Icons.car_crash,
                //   color: Colors.yellow,
                //   title: 'On Delivery',
                //   showDone: data['order_on_delivery'],
                // ),
                // orderStatus(
                //   icon: Icons.done_all_outlined,
                //   color: Colors.purple,
                //   title: 'Delivered',
                //   showDone: data['order_delivered'],
                // ),
                const Divider(),
                orderPlaceDetails(
                    title1: 'Order Code',
                    title2: 'Shipping Method',
                    data1: data['order_code'],
                    data2: data['shipping_method']),
                orderPlaceDetails(
                    title1: 'Order Date',
                    title2: 'Payment Method',
                    data1: intl.DateFormat()
                        .add_yMd()
                        .format((data['order_date'].toDate())),
                    data2: data['payment_method']),
                orderPlaceDetails(
                  title1: 'Payment Status',
                  title2: 'Delivery Status',
                  data1: 'Unpaid',
                  data2: 'Order placed',
                ),
                const Divider(),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          'Shipping Information'
                              .text
                              .fontFamily(bold)
                              .size(18)
                              .make(),
                          5.heightBox,
                          "Name: ${data['order_by_fullname']}"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make()
                              .box
                              .width(200)
                              .make(),
                          5.heightBox,
                          "Email: ${data['order_by_email']}"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make()
                              .box
                              .width(200)
                              .make(),
                          5.heightBox,
                          "Address: ${data['order_by_address']}"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make()
                              .box
                              .width(200)
                              .make(),
                          5.heightBox,
                          // "State: ${data['order_by_state']}"
                          //     .text
                          //     .fontFamily(semibold)
                          //     .color(darkFontGrey)
                          //     .make()
                          //     .box
                          //     .width(200)
                          //     .make(),
                          // 5.heightBox,  "State: ${data['order_by_state']}"
                          //     .text
                          //     .fontFamily(semibold)
                          //     .color(darkFontGrey)
                          //     .make()
                          //     .box
                          //     .width(200)
                          //     .make(),
                          5.heightBox,
                          // "City: ${data['order_by_city']}"
                          //     .text
                          //     .fontFamily(semibold)
                          //     .color(darkFontGrey)
                          //     .make()
                          //     .box
                          //     .width(200)
                          //     .make(),
                          // 5.heightBox,
                          "Phone number: ${data['order_by_phoneNumber']}"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make()
                              .box
                              .width(200)
                              .make(),
                          5.heightBox,
                          // "Postal code: ${data['order_by_postalCode']}"
                          //     .text
                          //     .fontFamily(semibold)
                          //     .color(darkFontGrey)
                          //     .make()
                          //     .box
                          //     .width(200)
                          //     .make(),
                        ],
                      ),
                      SizedBox(
                        width: 170,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            'Total Amount'.text.fontFamily(semibold).make(),
                            5.heightBox,
                            "${data['total_amount']}"
                                .toString()
                                .toVND()
                                .text
                                .fontFamily(bold)
                                .size(20)
                                .color(redColor)
                                .make(),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ).box.outerShadowMd.white.make(),
            const Divider(),
            10.heightBox,
            'Ordered Products'.text.size(18).fontFamily(bold).makeCentered(),
            10.heightBox,
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(data['orders'].length, (index) {
                // return Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       orderPlaceDetails(
                //         title1: data['orders'][index]['title'],
                //         title2: data['orders'][index]['tprice'],
                //         data1: "x ${data['orders'][index]['qty']}",
                //         data2: "Refundable",
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Container(
                //           width: 30,
                //           height: 30,
                //           color:
                //               Color(int.parse(data['orders'][index]['color'])),
                //         ),
                //       ),
                //     ]);
                return ListTile(
                  leading: Image.network(
                    data['orders'][index]['img'],
                    fit: BoxFit.cover,
                    width: 50,
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
                        color: Color(int.parse(data['orders'][index]['color'])),
                      ),
                      "${data['orders'][index]['title']}"
                          .text
                          .fontFamily(bold)
                          .maxLines(2)
                          .overflow(TextOverflow.ellipsis)
                          .size(14)
                          .make()
                          .box
                          .width(context.screenWidth - 150)
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
                        child: "(x${data['orders'][index]['qty']})"
                            .text
                            .fontFamily(semibold)
                            .size(12)
                            .make(),
                      ),
                      "${int.parse(data['orders'][index]['tprice']) * int.parse(data['orders'][index]['qty'])}"
                          .toString()
                          .toVND()
                          .text
                          .fontFamily(semibold)
                          .size(12)
                          .make(),
                    ],
                  ),
                );
              }).toList(),
            ),

            // ListView.builder(
            //   itemCount: data['orders'].length,
            //   itemBuilder: (BuildContext context, int index) {
            //     return ListTile(
            // leading: Image.network(
            //   data['orders'][index]['img'],
            //   fit: BoxFit.cover,
            //   width: 80,
            // ),
            // title: Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   textDirection: TextDirection.ltr,
            //   children: [
            //     Container(
            //       padding: const EdgeInsets.all(4.0),
            //       margin: const EdgeInsets.all(4.0),
            //       width: 10,
            //       height: 10,
            //       color: Color(int.parse(data['orders'][index]['color'])),
            //     ),
            //     "${data['orders'][index]['title']}"
            //         .text
            //         .fontFamily(bold)
            //         .maxLines(2)
            //         .overflow(TextOverflow.ellipsis)
            //         .size(16)
            //         .make()
            //         .box
            //         .width(context.screenWidth - 250)
            //         .make(),
            //   ],
            // ),
            //       subtitle: Row(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         textDirection: TextDirection.ltr,
            //         children: [
            //           Container(
            //             padding: const EdgeInsets.all(4.0),
            //             margin: const EdgeInsets.all(4.0),
            //             child: "(x${data['orders'][index]['qty']})"
            //                 .text
            //                 .fontFamily(semibold)
            //                 .size(14)
            //                 .make(),
            //           ),
            //           "${data['orders'][index]['tprice']}"
            //               .toString()
            //               .toVND()
            //               .text
            //               .fontFamily(semibold)
            //               .size(14)
            //               .make(),
            //         ],
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
