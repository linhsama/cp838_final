import 'package:cp838_project/chat_screen/chat_screen.dart';
import 'package:cp838_project/consts/consts.dart';
import 'package:cp838_project/services/firestore_services.dart';

class Messagescreen extends StatelessWidget {
  const Messagescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            "My Messages".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllMessages(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "No messages yet!".text.color(darkFontGrey).make(),
            );
          } else {
            //
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                              onTap: () {
                                Get.to(
                                  () => ChatScreen(
                                      title: data[index]['fromName']),
                                  arguments: [
                                    data[index]['fromId'],
                                    data[index]['fromName'],
                                  ],
                                );
                              },
                              leading: const CircleAvatar(
                                backgroundColor: redColor,
                                child: Icon(
                                  Icons.person,
                                  color: whiteColor,
                                ),
                              ),
                              title: "${data[index]['fromName']}"
                                  .text
                                  .color(darkFontGrey)
                                  .fontFamily(semibold)
                                  .make(),
                              subtitle:
                                  "${data[index]['last_msg']}".text.make()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
