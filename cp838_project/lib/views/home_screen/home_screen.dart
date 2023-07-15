import 'package:cp838_project/consts/consts.dart';
import 'package:cp838_project/controllers/home_controller.dart';
import 'package:cp838_project/controllers/profile_controller.dart';
import 'package:cp838_project/services/firestore_services.dart';
import 'package:cp838_project/views/category_screen/item_details.dart';
import 'package:cp838_project/views/home_screen/componets/search_screen.dart';
import 'package:cp838_project/widget_common/featured_button.dart';
import 'package:cp838_project/widget_common/home_button.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //
  var controller = Get.put(HomeController());
  var controller2 = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            // search
            Container(
              alignment: Alignment.center,
              color: lightGrey,
              child: TextFormField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: const Icon(Icons.search).onTap(() {
                    if (controller.searchController.text.isNotEmptyAndNotNull) {
                      Get.to(() => SearchScreen(
                          keyword: controller.searchController.text));
                    }
                  }),
                  filled: true,
                  fillColor: whiteColor,
                  hintText: searchSomeThing,
                  hintStyle: const TextStyle(color: textfieldGrey),
                ),
              ),
            )
                .box
                .padding(const EdgeInsets.all(1.0))
                .margin(const EdgeInsets.symmetric(vertical: 8.0))
                .outerShadowSm
                .make(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // // VxSwiper brand
                    // VxSwiper.builder(
                    //   aspectRatio: 16 / 9,
                    //   autoPlay: true,
                    //   height: 150,
                    //   enlargeCenterPage: true,
                    //   itemCount: sliderList.length,
                    //   itemBuilder: (context, index) {
                    //     return Image.asset(sliderList[index], fit: BoxFit.fill)
                    //         .box
                    //         .rounded
                    //         .clip(Clip.antiAlias)
                    //         .margin(
                    //             const EdgeInsets.symmetric(horizontal: 10.0))
                    //         .make();
                    //   },
                    // ),

                    // // deals buttons

                    // VxSwiper brand 2nd-level
                    10.heightBox,
                    VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: secondSliderList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(secondSliderList[index],
                                fit: BoxFit.fill)
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(
                                const EdgeInsets.symmetric(horizontal: 10.0))
                            .make();
                      },
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        2,
                        (index) => homeButton(
                            width: context.screenWidth / 2.5,
                            height: context.screenHeight * 0.15,
                            icon: index == 0 ? icTodaysDeal : icFlashDeal,
                            title: index == 0 ? todayDeal : flashSale),
                      ),
                    ),
                    // category buttons
                    // 10.heightBox,
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: List.generate(
                    //     3,
                    //     (index) => homeButton(
                    //       width: context.screenWidth / 3.5,
                    //       height: context.screenHeight * 0.15,
                    //       icon: index == 0
                    //           ? icTopCategories
                    //           : index == 1
                    //               ? icBrands
                    //               : icTopShop,
                    //       title: index == 0
                    //           ? topCategories
                    //           : index == 1
                    //               ? brand
                    //               : topShops,
                    //     ),
                    //   ),
                    // ),

                    // feature category
                    10.heightBox,
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: featuredCategories.text
                    //       .color(darkFontGrey)
                    //       .size(18.0)
                    //       .fontFamily(semibold)
                    //       .make(),
                    // ),

                    // // feature category
                    // 20.heightBox,
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     children: List.generate(
                    //       3,
                    //       (index) => Column(
                    //         children: [
                    //           featuredButton(
                    //             icon: featureImageList[index],
                    //             title: featureList[index],
                    //           ),
                    //           10.heightBox,
                    //           featuredButton(
                    //             icon: featureImage2List[index],
                    //             title: feature2List[index],
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    // featured products
                    20.heightBox,
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      width: double.infinity,
                      decoration: const BoxDecoration(color: blueColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Hot & New product"
                              .text
                              .white
                              .fontFamily(bold)
                              .size(18.0)
                              .make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: StreamBuilder(
                              stream: FirestoreServices.getNewProducts(),
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
                                    child: "No products yet!"
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
                                      (index) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            data[index]['p_imgs'][0],
                                            width: 150,
                                            fit: BoxFit.cover,
                                          ),
                                          10.heightBox,
                                          "${data[index]['p_name']}"
                                              .text
                                              .maxLines(2)
                                              .overflow(TextOverflow.ellipsis)
                                              .fontFamily(semibold)
                                              .color(darkFontGrey)
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
                                          .rounded
                                          .width(170)
                                          .margin(const EdgeInsets.symmetric(
                                              horizontal: 8.0))
                                          .padding(const EdgeInsets.all(8.0))
                                          .make()
                                          .onTap(() {
                                        Get.to(() => ItemDetails(
                                            title: data[index]['p_name'],
                                            data: data[index]));
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

                    // VxSwiper brand 3rd
                    20.heightBox,
                    VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: sliderList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(sliderList[index], fit: BoxFit.fill)
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(
                                const EdgeInsets.symmetric(horizontal: 10.0))
                            .make();
                      },
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
                          .make(),
                    ),
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
                              child: "No products yet!"
                                  .text
                                  .color(darkFontGrey)
                                  .make(),
                            );
                          } else {
                            //
                            var data = snapshot.data!.docs;
                            return GridView.builder(
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
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
