import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project_seller/services/store_services.dart';
import 'package:project_seller/views/products_screen/product_details.dart';
import 'package:project_seller/views/widgets/appbar_widget.dart';
import 'package:project_seller/views/widgets/dashboard_button.dart';
import 'package:project_seller/views/widgets/loading_indicator.dart';
import 'package:project_seller/views/widgets/text_style.dart';
import '../../const/const.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  void initState() {
    StoreServices.getTotalSale(currentUser!.uid);
    StoreServices.getRating(currentUser!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: appbarWidget(dashboard),
      body: StreamBuilder(
        stream: StoreServices.getProducts(currentUser!.uid),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot_1) {
          return StreamBuilder(
            stream: StoreServices.getOrders(currentUser!.uid),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot_2) {
              if (!snapshot_1.hasData && !snapshot_2.hasData) {
                return loadingIndicator();
              } else {
                var data = snapshot_1.data!.docs;
                var order = snapshot_2.data?.docs ?? [];

                data = data.sortedBy((a, b) =>
                    b['p_wishlist'].length.compareTo(a['p_wishlist'].length));

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          dashboardButton(context,
                              title: products,
                              count: "${data.length}",
                              icon: icProducts),
                          dashboardButton(context,
                              title: orders,
                              count: "${order.length}",
                              icon: icOrders),
                        ],
                      ),
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          dashboardButton(context,
                              title: rating, count: StoreServices.averageRating.toStringAsFixed(1), icon: icStar),
                          dashboardButton(context,
                              title: totalSales,
                              count: StoreServices.totalSale.toStringAsFixed(2),
                              icon: icTotalSales),
                        ],
                      ),
                      10.heightBox,
                      const Divider(),
                      10.heightBox,
                      boldText(text: popular, color: fontGrey, size: 16.0),
                      20.heightBox,
                      Expanded(
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                            data.length,
                            (index) => data[index]['p_wishlist'].length == 0
                                ? const SizedBox()
                                : ListTile(
                                    onTap: () {
                                      Get.to(() => ProductDetails(
                                            data: data[index],
                                          ));
                                    },
                                    leading: Image.network(
                                      data[index]['p_imgs'][0],
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                    title: boldText(
                                        text: "${data[index]['p_name']}",
                                        color: fontGrey),
                                    subtitle: normalText(
                                        text: "${data[index]['p_price']}"
                                            .numCurrencyWithLocale(
                                                locale: "en_IN"),
                                        color: darkGrey),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
