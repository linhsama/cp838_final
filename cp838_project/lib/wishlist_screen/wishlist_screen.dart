import 'package:cp838_project/consts/consts.dart';
import 'package:cp838_project/controllers/product_controller.dart';
import 'package:cp838_project/services/firestore_services.dart';
import 'package:cp838_project/views/category_screen/item_details.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    var controller = Get.put(ProductController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            "My Wishlists".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllWishlists(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "No Wishlist yet!".text.color(darkFontGrey).makeCentered(),
            );
          } else {
            //
            var data = snapshot.data!.docs;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    Get.to(() => ItemDetails(
                        title: data[index]['p_name'], data: data[index]));
                  },
                  leading: Image.network(
                    data[index]['p_imgs'][0],
                    fit: BoxFit.cover,
                    width: 80,
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
                          .width(context.screenWidth - 250)
                          .make(),
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    textDirection: TextDirection.ltr,
                    children: [
                      "${data[index]['p_price']}"
                          .toString()
                          .toVND()
                          .text
                          .color(redColor)
                          .fontFamily(semibold)
                          .size(14)
                          .make(),
                    ],
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      showDialog<String>(
                        barrierDismissible: false, // user must tap button!
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Confirm'),
                          content: const Text('Do you want remove this item?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              child: const Text(
                                'Remove',
                                style: TextStyle(color: redColor),
                              ),
                              onPressed: () {
                                controller.removeWishList(
                                    data[index].id, context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.favorite,
                      color: redColor,
                      size: 26,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
