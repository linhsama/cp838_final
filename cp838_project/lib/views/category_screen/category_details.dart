import 'package:cp838_project/consts/consts.dart';
import 'package:cp838_project/controllers/product_controller.dart';
import 'package:cp838_project/services/firestore_services.dart';
import 'package:cp838_project/views/category_screen/item_details.dart';
import 'package:cp838_project/widget_common/bg_widget.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    var controller = Get.find<ProductController>();
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: bgWidget(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back)),
            title: title.toString().text.fontFamily(bold).white.make(),
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
                  child: "No products found!".text.color(darkFontGrey).make(),
                );
              } else {
                var data = snapshot.data!.docs;
                return Container(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: List.generate(
                              controller.subCat.length,
                              (index) => "${controller.subCat[index]}"
                                  .text
                                  .size(12.0)
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .makeCentered()
                                  .box
                                  .white
                                  .size(150, 60)
                                  .roundedSM
                                  .outerShadowSm
                                  .margin(const EdgeInsets.symmetric(
                                      horizontal: 4.0))
                                  .make()),
                        ),
                      ),

                      // items container
                      20.heightBox,
                      Expanded(
                        child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 250,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  data[index]['p_imgs'][0],
                                  height: 160,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ).box.roundedSM.clip(Clip.antiAlias).make(),
                                5.heightBox,
                                "${data[index]['p_name']} "
                                    .text
                                    .maxLines(2)
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
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 4.0))
                                .padding(const EdgeInsets.all(4.0))
                                .outerShadow
                                .make()
                                .onTap(() {
                              Get.to(() => ItemDetails(
                                    title: "${data[index]['p_name']}",
                                    data: data[index],
                                  ));
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
