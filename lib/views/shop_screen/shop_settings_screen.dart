import 'package:get/get.dart';
import 'package:project_seller/controllers/profile_controller.dart';
import 'package:project_seller/views/widgets/custom_textfield.dart';
import 'package:project_seller/views/widgets/loading_indicator.dart';

import '../../const/const.dart';
import '../widgets/text_style.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: shopSettings, size: 16.0),
          actions: [
            controller.isLoading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);
                      await controller.updateShop(
                        shopName: controller.shopNameController.text,
                        shopAddress: controller.shopAddressController.text,
                        shopMobile: controller.shopMobileController.text,
                        shopWebsite: controller.shopWebsiteController.text,
                        shopDesc: controller.shopDescController.text,
                      );
                      VxToast.show(context, msg: "Shop updated");
                    },
                    child: normalText(text: save)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                customTextField(
                    label: shopName,
                    hint: nameHint,
                    controller: controller.shopNameController),
                10.heightBox,
                customTextField(
                    label: address,
                    hint: shopAddressHint,
                    controller: controller.shopAddressController),
                10.heightBox,
                customTextField(
                    label: mobile,
                    hint: shopMobileHint,
                    controller: controller.shopMobileController),
                10.heightBox,
                customTextField(
                    label: website,
                    hint: shopWebsiteHint,
                    controller: controller.shopWebsiteController),
                10.heightBox,
                customTextField(
                    label: description,
                    hint: shopDescHint,
                    isDesc: true,
                    controller: controller.shopDescController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
