import 'package:cp838_project/consts/consts.dart';

Widget orderPlaceDetails(
    {required title1, required title2, required data1, required data2}) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "$title1".toString().text.fontFamily(bold).make(),
            "$data1".text.fontFamily(semibold).color(redColor).make(),
          ],
        ),
        SizedBox(
          width: 130,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "$title2".toString().text.fontFamily(bold).make(),
              "$data2".text.fontFamily(semibold).color(darkFontGrey).make(),
            ],
          ),
        ),
      ],
    ),
  );
}
