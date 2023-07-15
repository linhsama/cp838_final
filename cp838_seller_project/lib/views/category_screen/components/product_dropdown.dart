import 'package:cp838_seller_project/consts/consts.dart';

Widget productDropdown(
    {required hint,
    required List<String> list,
    required dropvalue,
    required controller}) {
  return Obx(
    () => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        5.heightBox,
        DropdownButtonHideUnderline(
          child: DropdownButton(
            dropdownColor: lightGrey,
            hint: "$hint".text.color(fontGrey).make(),
            value: dropvalue.value == '' ? null : dropvalue.value,
            items: list.map((e) {
              return DropdownMenuItem(
                  value: e, child: e.toString().text.color(purpleColor).make());
            }).toList(),
            isExpanded: true,
            onChanged: (newValue) {
              if (hint == 'Cateroty') {
                controller.subcategoryvalue.value = '';
                controller.populateSubcategory(newValue.toString());
              }
              dropvalue.value = newValue.toString();
            },
          )
              .box
              .white
              .roundedSM
              .padding(const EdgeInsets.symmetric(horizontal: 25.0))
              .make(),
        )
            .box
            .color(darkFontGrey)
            .padding(const EdgeInsets.all(0.1))
            .roundedSM
            .make(),
        5.heightBox,
      ],
    ),
  );
}
