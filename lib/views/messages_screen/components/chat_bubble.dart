import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_seller/const/const.dart';
import 'package:intl/intl.dart' as intl;

Widget chatBubble(DocumentSnapshot data){
  var t = data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  var time = intl.DateFormat("h:mm a").format(t);

  return data['uid'] == currentUser!.uid ? Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(12),
    decoration: const BoxDecoration(
      color: purpleColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
        bottomLeft: Radius.circular(30),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        "${data['msg']}".text.white.size(16).make(),
        10.heightBox,
        time.text.color(white.withOpacity(0.5)).make(),
      ],
    ),
  ) : Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(12),
    decoration: const BoxDecoration(
      color: Color.fromRGBO(230, 46, 4, 1),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "${data['msg']}".text.white.size(16).make(),
        10.heightBox,
        time.text.color(white.withOpacity(0.5)).make(),
      ],
    ),
  );
  // return Directionality(
  //     textDirection: TextDirection.ltr,
  //     child: Container(
  //       padding: const EdgeInsets.all(12),
  //       margin: const EdgeInsets.only(bottom: 12),
  //       decoration: const BoxDecoration(
  //         color: purpleColor,
  //         borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(20),
  //           topRight: Radius.circular(20),
  //           bottomLeft: Radius.circular(20),
  //         ),
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           normalText(text: "Your message here..."),
  //           10.heightBox,
  //           normalText(text: "10:45 AM"),
  //         ],
  //       ),
  //     ),);
}