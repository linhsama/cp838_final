import 'package:cp838_seller_project/consts/consts.dart';

Widget productColor({required label}) {
  return SizedBox(
    child: label,
  ).box.color(lightBlue).size(40, 40).roundedSM.make();
}
