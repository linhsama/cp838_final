import 'package:cp838_project/consts/consts.dart';

Widget bgWidget({required Widget child}) {
  return Container(
    decoration: const BoxDecoration(
      image:
          DecorationImage(image: AssetImage(imgBackground), fit: BoxFit.fill),
    ),
    child: child,
  );
}
