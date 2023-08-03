import 'package:get/get.dart';
import 'package:project_seller/controllers/home_controller.dart';
import 'package:project_seller/views/home_screen/home_screen.dart';
import 'package:project_seller/views/orders_screen/orders_screen.dart';
import 'package:project_seller/views/products_screen/products_screen.dart';
import 'package:project_seller/views/profile_screen/profile_screen.dart';
import '../../const/const.dart';
import '../widgets/exit_dialog.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navScreens = [ const HomeScreen(), const ProductsScreen(), const OrdersScreen(), const ProfileScreen()];

    var bottomNavbar = [
      const BottomNavigationBarItem(icon: Icon(Icons.home),label: dashboard),
      BottomNavigationBarItem(icon: Image.asset(icProducts,color: darkGrey,width: 24,),label: products),
      BottomNavigationBarItem(icon: Image.asset(icOrders,color: darkGrey,width: 24,),label: orders),
      BottomNavigationBarItem(icon: Image.asset(icGeneralSetting,color: darkGrey,width: 24,),label: settings),
    ];
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => exitDialog(context),
        );
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: Obx(
            () => BottomNavigationBar(
            onTap: (index){
              controller.navIndex.value = index;
            },
                currentIndex: controller.navIndex.value,
            type: BottomNavigationBarType.fixed,
              selectedItemColor: purpleColor,
              unselectedItemColor: darkGrey,
              items: bottomNavbar),
        ),
        body: Obx(
            () => Column(
            children: [
              Expanded(child: navScreens.elementAt(controller.navIndex.value)),
            ],
          ),
        ),
      ),
    );
  }
}
