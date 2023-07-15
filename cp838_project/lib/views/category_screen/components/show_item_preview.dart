import 'package:cp838_project/consts/consts.dart';

class ShowItemPreview extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ShowItemPreview({Key? key, required this.title, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
          title:
              title.toString().text.color(darkFontGrey).fontFamily(bold).make(),
        ),
        body: Container(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // rating
                        10.heightBox,
                        "Rating (${data['p_rating']} / 5.0)"
                            .text
                            .color(darkFontGrey)
                            .fontFamily(semibold)
                            .size(16.0)
                            .make(),
                        20.heightBox,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            VxRating(
                              isSelectable: false,
                              onRatingUpdate: (value) {},
                              normalColor: textfieldGrey,
                              selectionColor: golden,
                              size: 50,
                              stepInt: true,
                              maxRating: 5,
                              value: double.parse(data['p_rating'].toString()),
                            ),
                            10.widthBox,
                          ],
                        ),

                        10.heightBox,
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Preview"
                                  .text
                                  .color(darkFontGrey)
                                  .fontFamily(semibold)
                                  .size(16.0)
                                  .make(),
                              5.heightBox,
                              "${data['p_preview']}"
                                  .text
                                  .color(darkFontGrey)
                                  .make(),
                            ]),
                        10.heightBox,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Images"
                                .text
                                .color(darkFontGrey)
                                .fontFamily(semibold)
                                .size(16.0)
                                .make(),
                            5.heightBox,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(
                                data['p_imgs'].length,
                                (index) => Image.network(
                                  data['p_imgs'][index],
                                  width: 350,
                                  height: 350,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
