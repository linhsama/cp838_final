import 'package:cp838_project/consts/consts.dart';
import 'package:cp838_project/services/firestore_services.dart';
import 'package:cp838_project/views/category_screen/item_details.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class SearchScreen extends StatelessWidget {
  final String? keyword;
  const SearchScreen({Key? key, required this.keyword}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(title: "$keyword".text.color(darkFontGrey).make()),
      body: StreamBuilder(
          stream: FirestoreServices.getProductBySearch(keyword: keyword),
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
                child: "No products found!".text.color(darkFontGrey).make(),
              );
            } else {
              //
              var data = snapshot.data!.docs;
              return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 300),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          data[index]['p_imgs'][0],
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                        const Spacer(),
                        "${data[index]['p_name']}"
                            .text
                            .maxLines(2)
                            .fontFamily(semibold)
                            .size(16)
                            .overflow(TextOverflow.ellipsis)
                            .color(darkFontGrey)
                            .make()
                            .box
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
                        .margin(const EdgeInsets.all(8.0))
                        .make()
                        .onTap(() {
                      Get.to(() => ItemDetails(
                          title: data[index]['p_name'], data: data[index]));
                    });
                  });
            }
          }),
    );
  }
}
