import 'package:cp838_project/consts/consts.dart';
import 'package:cp838_project/services/firestore_services.dart';
import 'package:cp838_project/views/category_screen/components/show_item_preview.dart';
import 'package:intl/intl.dart' as intl;

class ShowPreview extends StatelessWidget {
  final String? title;
  final dynamic req;
  const ShowPreview({Key? key, required this.title, required this.req})
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
        body: StreamBuilder(
          stream: FirestoreServices.getPreviews(req.id),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "No previews yet!".text.color(darkFontGrey).make(),
              );
            } else {
              //
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    data[index]['p_photoUrl'],
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Row(
                                  children: [
                                    "${data[index]['p_username']}"
                                        .text
                                        .color(darkFontGrey)
                                        .fontFamily(semibold)
                                        .maxLines(1)
                                        .overflow(TextOverflow.ellipsis)
                                        .make()
                                        .box
                                        .width(150)
                                        .make(),
                                    VxRating(
                                      isSelectable: false,
                                      value: double.parse(
                                          data[index]['p_rating'].toString()),
                                      onRatingUpdate: (value) {},
                                      normalColor: textfieldGrey,
                                      selectionColor: golden,
                                      size: 20,
                                      stepInt: true,
                                      maxRating: 5,
                                      count: 5,
                                    ).box.width(100).make(),
                                  ],
                                ),
                                subtitle: Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: "${data[index]['p_preview']}"
                                          .text
                                          .color(darkFontGrey)
                                          .maxLines(2)
                                          .overflow(TextOverflow.ellipsis)
                                          .make()
                                          .box
                                          .width(150)
                                          .make(),
                                    ),
                                    20.widthBox,
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: intl.DateFormat()
                                          .add_yMd()
                                          .format((data[index]['created_on']
                                              .toDate()))
                                          .text
                                          .color(darkFontGrey)
                                          .make(),
                                    ),
                                  ],
                                ),
                                trailing:
                                    const Icon(Icons.remove_red_eye_sharp)),
                          ).onTap(() {
                            Get.to(ShowItemPreview(
                                title: data[index]['p_username'],
                                data: data[index]));
                          });
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
