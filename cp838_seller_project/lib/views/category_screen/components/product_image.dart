import 'package:cp838_seller_project/consts/consts.dart';

Widget productImage({required label}) {
  return SizedBox(
    child: label,
  ).box.color(lightBlue).size(100, 100).roundedSM.make();
}
