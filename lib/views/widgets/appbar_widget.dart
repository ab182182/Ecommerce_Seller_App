import 'package:project_seller/const/const.dart';
import 'package:intl/intl.dart' as intl;
import 'text_style.dart';

AppBar appbarWidget(title){
  return AppBar(
    backgroundColor: white,
    automaticallyImplyLeading: false,
    title: boldText(text: title, color: fontGrey, size: 16.0),
    actions: [
      Center(
        child: normalText(
            text: intl.DateFormat('EEE, MMM dd, ' 'yyyy')
                .format(DateTime.now()),
            color: purpleColor),
      ),
      10.widthBox,
    ],
  );
}