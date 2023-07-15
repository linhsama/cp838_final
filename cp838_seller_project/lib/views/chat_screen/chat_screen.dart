import 'package:cp838_seller_project/views/chat_screen/components/sender_bubble.dart';
import 'package:cp838_seller_project/consts/consts.dart';
import 'package:cp838_seller_project/controllers/chat_controller.dart';
import 'package:cp838_seller_project/services/firestore_services.dart';

class ChatScreen extends StatelessWidget {
  final String? title;
  const ChatScreen({Key? key, this.title}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    //
    var controller = Get.put(ChatController());
    controller.getChatId();

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title
            .toString()
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Obx(
            () => controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    ),
                  )
                : Expanded(
                    child: StreamBuilder(
                      stream: FirestoreServices.getChatMessages(
                          controller.chatDocId.toString()),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            ),
                          );
                        } else if (snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: "Send a message..."
                                .text
                                .color(darkFontGrey)
                                .make(),
                          );
                        } else {
                          return ListView(
                              children: snapshot.data!.docs
                                  .mapIndexed((currentValue, index) {
                            var data = snapshot.data!.docs[index];
                            return Align(
                                alignment: data['uid'] == currentUser!.uid
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: senderBubble(data: data));
                          }).toList());
                        }
                      },
                    ),
                  ),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.msgController,
                  decoration: const InputDecoration(
                    hintText: 'Type your message...',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: textfieldGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: textfieldGrey),
                    ),
                  ),
                ),
              ),
              MaterialButton(
                minWidth: 10,
                onPressed: () {
                  controller.pickImage(context);
                  // controller.uploadImage(context: context);
                },
                child: const Icon(
                  Icons.add_a_photo,
                  color: blueColor,
                ),
              ),
              MaterialButton(
                minWidth: 10,
                onPressed: () {
                  if (controller.msgController.text.trim().isNotEmpty) {
                    controller.sendMsg(controller.msgController.text);
                    controller.msgController.clear();
                  } else {
                    VxToast.show(context,
                        msg: 'Message is required', textColor: redColor);
                  }
                },
                child: const Icon(
                  Icons.send,
                  color: blueColor,
                ),
              ),
            ],
          )
              .box
              .height(60)
              .padding(const EdgeInsets.all(8.0))
              .margin(const EdgeInsets.all(8.0))
              .make()
        ]),
      ),
    );
  }
}
