import 'package:cp838_project/consts/consts.dart';

Widget homeButton(
    {required width, required height, required icon, required title}) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(icon, width: 26),
        10.heightBox,
        (title.toString()).text.color(darkFontGrey).fontFamily(semibold).make()
      ],
    ),
  ).box.rounded.white.size(width, height).outerShadowSm.make();
}
