import 'package:cp838_seller_project/consts/consts.dart';

Widget appLogoWidget() {
  return Image.asset(icAppLogo)
      .box
      .white
      .size(77, 77)
      .padding(const EdgeInsets.all(8.0))
      .rounded
      .make();
}
