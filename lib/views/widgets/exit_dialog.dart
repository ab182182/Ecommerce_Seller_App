import 'package:flutter/services.dart';
import 'package:project_seller/const/const.dart';
import 'package:project_seller/views/widgets/our_button.dart';
import 'package:project_seller/views/widgets/text_style.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        boldText(text: "Confirm", size: 18.0, color: darkGrey),
        const Divider(),
        10.heightBox,
        "Are you sure you want to exit ?"
            .text
            .size(16)
            .color(fontGrey)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
                color: purpleColor,
                onPress: () {
                  SystemNavigator.pop();
                },
                // textColor: white,
                title: "Yes"),
            ourButton(
                color: purpleColor,
                onPress: () {
                  Navigator.pop(context);
                },
                // textColor: white,
                title: "No"),
          ],
        ),
      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(12)).roundedSM.make(),
  );
}