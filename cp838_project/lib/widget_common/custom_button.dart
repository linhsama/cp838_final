import 'package:cp838_project/consts/consts.dart';

Widget customButton(
    {required onPress, required color, required textColor, required title}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.all(12.0),
    ),
    onPressed: onPress,
    child: (title.toString()).text.color(textColor).fontFamily(bold).make(),
  );
}
