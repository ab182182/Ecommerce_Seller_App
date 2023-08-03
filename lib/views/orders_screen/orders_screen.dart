import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project_seller/controllers/orders_controller.dart';
import 'package:project_seller/services/store_services.dart';
import 'package:project_seller/views/orders_screen/order_details.dart';
import 'package:project_seller/views/widgets/appbar_widget.dart';
import 'package:intl/intl.dart' as intl;
import 'package:project_seller/views/widgets/loading_indicator.dart';
import '../../const/const.dart';
import '../widgets/text_style.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: appbarWidget(orders),
      body: StreamBuilder(
        stream: StoreServices.getOrders(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(data.length, (index) {
                    var time = data[index]['order_date'].toDate();
                    return ListTile(
                      onTap: () {
                        Get.to(() => OrderDetails(data: data[index],));
                      },
                      tileColor: textfieldGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      title: boldText(
                          text: "${data[index]['order_code']}",
                          color: purpleColor),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                color: fontGrey,
                              ),
                              10.widthBox,
                              normalText(
                                  text: intl.DateFormat()
                                      .add_yMMMd()
                                      .format(time),
                                  color: fontGrey),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.payment,
                                color: fontGrey,
                              ),
                              10.widthBox,
                              boldText(text: unpaid, color: red),
                            ],
                          ),
                        ],
                      ),
                      trailing: boldText(
                          size: 16.0,
                          color: purpleColor,
                          text: "${data[index]['total_amount']}".numCurrencyWithLocale(locale: "en_IN")),
                    ).box.margin(const EdgeInsets.only(bottom: 5)).make();
                  }),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
