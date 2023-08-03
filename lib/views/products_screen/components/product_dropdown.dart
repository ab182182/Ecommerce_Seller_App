import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:project_seller/const/const.dart';
import 'package:project_seller/controllers/products_controller.dart';
import 'package:project_seller/views/widgets/text_style.dart';

Widget productDropdown(hint, List<String> list, dropValue, ProductsController controller) {
  return Obx(
      ()=> DropdownButtonHideUnderline(
      child: DropdownButton(
        hint: normalText(text: "$hint", color: fontGrey),
        value: dropValue.value == '' ? null : dropValue.value,
        isExpanded: true,
        items: list.map((e) {
          return DropdownMenuItem(
              value: e,
              child: e.toString().text.make(),
          );
        }).toList(),
        onChanged: (newValue) {
          if (hint == "Category") {
            controller.subcategoryValue.value = '';
            controller.populateSubcategory(newValue.toString());
          }
          dropValue.value = newValue.toString();
        },
      ),
    ).box.white.padding(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.make(),
  );
}
