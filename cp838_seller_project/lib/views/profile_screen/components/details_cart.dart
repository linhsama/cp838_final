import 'package:cp838_seller_project/consts/consts.dart';

Widget detailsCard({required width, required count, required title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count
          .toString()
          .text
          .fontFamily(bold)
          .color(darkFontGrey)
          .size(16.0)
          .make(),
      5.heightBox,
      title.toString().text.color(darkFontGrey).make(),
    ],
  )
      .box
      .white
      .roundedSM
      .outerShadow
      .width(width)
      .height(60)
      .padding(const EdgeInsets.all(4.0))
      .make();
}
