import 'package:cp838_seller_project/consts/consts.dart';
import 'package:cp838_seller_project/controllers/orders_controller.dart';
import 'package:cp838_seller_project/views/order_screen/components/order_place_details.dart';
import 'package:cp838_seller_project/views/order_screen/components/order_status.dart';
import 'package:cp838_seller_project/widget_common/custom_button.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatefulWidget {
  final dynamic data;
  const OrderDetails({Key? key, required this.data}) : super(key: key);

  @override
  createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var controller = Get.put(OrdersController());

  @override
  void initState() {
    super.initState();
    controller.getOrders(widget.data);
    controller.confirmed.value = widget.data['order_confirmed'];
  }

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
      bottomNavigationBar: Visibility(
        visible: !controller.confirmed.value,
        child: SizedBox(
          height: 60,
          width: context.screenWidth,
          child: customButton(
              onPress: () {
                setState(() {
                  controller.confirmed(true);
                });
                controller.changeStatus(
                    title: 'order_confirmed',
                    status: true,
                    docID: widget.data.id);
              },
              color: green,
              textColor: whiteColor,
              title: 'Confirm Order'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                orderStatus(
                  icon: Icons.done,
                  color: redColor,
                  showDone: SwitchListTile(
                    value: widget.data['order_placed'],
                    onChanged: (value) {},
                    activeColor: green,
                    title: 'Order placed'
                        .text
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                  ),
                ),
                orderStatus(
                  icon: Icons.thumb_up,
                  color: Colors.blue,
                  showDone: SwitchListTile(
                    value: controller.confirmed.value,
                    onChanged: (value) {},
                    activeColor: green,
                    title: 'Confirmed'
                        .text
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                  ),
                ),
                // orderStatus(
                //   icon: Icons.car_crash,
                //   color: Colors.yellow,
                //   showDone: SwitchListTile(
                //     value: widget.data['order_on_delivery'],
                //     onChanged: (value) {
                //       controller.ondelivery(true);
                //       controller.changeStatus(
                //           title: 'order_on_delivery',
                //           status: true,
                //           docID: widget.data.id);
                //     },
                //     activeColor: green,
                //     title: 'On Confirmed'
                //         .text
                //         .color(darkFontGrey)
                //         .fontFamily(semibold)
                //         .make(),
                //   ),
                // ),
                // orderStatus(
                //   icon: Icons.done_all_outlined,
                //   color: Colors.purple,
                //   showDone: SwitchListTile(
                //     value: widget.data['order_delivered'],
                //     onChanged: (value) {
                //       controller.delivered(true);
                //       controller.changeStatus(
                //           title: 'order_delivered',
                //           status: true,
                //           docID: widget.data.id);
                //     },
                //     activeColor: green,
                //     title: 'Delivered'
                //         .text
                //         .color(darkFontGrey)
                //         .fontFamily(semibold)
                //         .make(),
                //   ),
                // ),
                const Divider(),
                orderPlaceDetails(
                    title1: 'Order Code',
                    title2: 'Shipping Method',
                    data1: widget.data['order_code'],
                    data2: widget.data['shipping_method']),
                orderPlaceDetails(
                    title1: 'Order Date',
                    title2: 'Payment Method',
                    data1: intl.DateFormat()
                        .add_yMd()
                        .format((widget.data['order_date'].toDate())),
                    data2: widget.data['payment_method']),
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
                          "Name: ${widget.data['order_by_fullname']}"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make()
                              .box
                              .width(200)
                              .make(),
                          5.heightBox,
                          "Email: ${widget.data['order_by_email']}"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make()
                              .box
                              .width(200)
                              .make(),
                          5.heightBox,
                          "Address: ${widget.data['order_by_address']}"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make()
                              .box
                              .width(200)
                              .make(),
                          5.heightBox,
                          // "State: ${widget.data['order_by_state']}"
                          //     .text
                          //     .fontFamily(semibold)
                          //     .color(darkFontGrey)
                          //     .make()
                          //     .box
                          //     .width(200)
                          //     .make(),
                          // 5.heightBox,
                          // "City: ${widget.data['order_by_city']}"
                          //     .text
                          //     .fontFamily(semibold)
                          //     .color(darkFontGrey)
                          //     .make()
                          //     .box
                          //     .width(200)
                          //     .make(),
                          // 5.heightBox,
                          "Phone number: ${widget.data['order_by_phoneNumber']}"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make()
                              .box
                              .width(200)
                              .make(),
                          5.heightBox,
                          // "Postal code: ${widget.data['order_by_postalCode']}"
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
                            "${widget.data['total_amount']}"
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
              children: List.generate(widget.data['orders'].length, (index) {
                // return Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       orderPlaceDetails(
                //         title1: widget.data['orders'][index]['title'],
                //         title2: widget.data['orders'][index]['tprice'],
                //         data1: "x ${widget.data['orders'][index]['qty']}",
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
                    widget.data['orders'][index]['img'],
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
                        color: Color(int.parse(
                            widget.data['orders'][index]['color'].toString())),
                      ),
                      "${widget.data['orders'][index]['title']}"
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
                        child: "(x${widget.data['orders'][index]['qty']})"
                            .text
                            .fontFamily(semibold)
                            .size(12)
                            .make(),
                      ),
                      "${int.parse(widget.data['orders'][index]['tprice'].toString()) * int.parse(widget.data['orders'][index]['qty'].toString())}"
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
            //   itemCount: widget.data['orders'].length,
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
            //     "${widget.data['orders'][index]['title']}"
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
            //             child: "(x${widget.data['orders'][index]['qty']})"
            //                 .text
            //                 .fontFamily(semibold)
            //                 .size(14)
            //                 .make(),
            //           ),
            //           "${widget.data['orders'][index]['tprice']}"
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
