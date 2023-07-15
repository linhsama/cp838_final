import 'package:cp838_seller_project/consts/consts.dart';

Widget homeButton(
    {required width,
    required height,
    required icon,
    required title,
    required count}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (title.toString())
                .text
                .color(whiteColor)
                .size(16.0)
                .fontFamily(semibold)
                .make(),
            10.heightBox,
            (count.toString())
                .text
                .color(whiteColor)
                .size(22.0)
                .fontFamily(semibold)
                .make()
          ],
        ),
      ),
      Image.asset(
        icon,
        width: 40,
        height: 40,
        color: whiteColor,
        fit: BoxFit.cover,
      ),
    ],
  )
      .box
      .rounded
      .color(purpleColor)
      .size(width, height)
      .padding(const EdgeInsets.all(12.0))
      .outerShadowSm
      .make();
}
