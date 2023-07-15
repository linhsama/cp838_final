import 'package:cp838_project/consts/consts.dart';

Widget customTextField(
    {required String title,
    required String hint,
    required controller,
    required obscureText,
    required keyboardTypes,
    isDesc = false,
    enabled = true,
    maxLenth = 50}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title.text.color(darkFontGrey).fontFamily(semibold).size(16.0).make(),
      5.heightBox,
      TextFormField(
        enabled: enabled,
        keyboardType: keyboardTypes,
        maxLength: maxLenth,
        textInputAction: TextInputAction.next,
        obscureText: obscureText,
        controller: controller,
        maxLines: isDesc ? 4 : 1,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle:
              const TextStyle(fontFamily: semibold, color: textfieldGrey),
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: darkFontGrey),
          ),
        ),
      ),
      5.heightBox,
    ],
  );
}
