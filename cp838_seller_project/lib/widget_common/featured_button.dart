import 'package:cp838_seller_project/consts/consts.dart';

Widget featuredButton({required icon, required title}) {
  return Expanded(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          icon,
          width: 40,
          fit: BoxFit.fill,
        ),
        10.heightBox,
        (title.toString()).text.color(darkFontGrey).fontFamily(semibold).make()
      ],
    ),
  )
      .box
      .rounded
      .width(200.0)
      .white
      .outerShadowSm
      .margin(const EdgeInsets.all(4.0))
      .padding(const EdgeInsets.all(4.0))
      .make();
}
